import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

typedef StreamController CreateStreamController();
typedef void TimeChangeHandler(Duration duration);
typedef void SeekHandler(bool finished);
typedef void ErrorHandler(String message);
typedef void AudioPlayerStateChangeHandler(CustomAudioPlayerState state);

enum ReleaseMode {
  STOP
}

enum CustomAudioPlayerState {
  STOPPED,
  PLAYING,
  PAUSED,
  COMPLETED,
}
enum PlayingRouteState {
  SPEAKERS,
  EARPIECE,
}
enum PlayerMode {
  MEDIA_PLAYER,
  LOW_LATENCY
}

enum PlayerControlCommand {
  NEXT_TRACK,
  PREVIOUS_TRACK,
}

class CustomAudioPlayer {
  static final MethodChannel _channel =
  const MethodChannel('xyz.luan/audioplayers')
    ..setMethodCallHandler(platformCallHandler);

  static final _uuid = Uuid();

  final StreamController<CustomAudioPlayerState> _playerStateController =
  StreamController<CustomAudioPlayerState>.broadcast();

  final StreamController<CustomAudioPlayerState> _notificationPlayerStateController =
  StreamController<CustomAudioPlayerState>.broadcast();

  final StreamController<Duration> _positionController =
  StreamController<Duration>.broadcast();

  final StreamController<Duration> _durationController =
  StreamController<Duration>.broadcast();

  final StreamController<void> _completionController =
  StreamController<void>.broadcast();

  final StreamController<bool> _seekCompleteController =
  StreamController<bool>.broadcast();

  final StreamController<String> _errorController =
  StreamController<String>.broadcast();

  final StreamController<PlayerControlCommand> _commandController =
  StreamController<PlayerControlCommand>.broadcast();

  PlayingRouteState _playingRouteState = PlayingRouteState.SPEAKERS;


  static final players = Map<String, CustomAudioPlayer>();


  static bool logEnabled = false;

  CustomAudioPlayerState _audioPlayerState;

  CustomAudioPlayerState get state => _audioPlayerState;

  set state(CustomAudioPlayerState state) {
    _playerStateController.add(state);
    audioPlayerStateChangeHandler?.call(state);
    _audioPlayerState = state;
  }

  set playingRouteState(PlayingRouteState routeState) {
    _playingRouteState = routeState;
  }

  set notificationState(CustomAudioPlayerState state) {
    _notificationPlayerStateController.add(state);
    _audioPlayerState = state;
  }


  Stream<CustomAudioPlayerState> get onPlayerStateChanged =>
      _playerStateController.stream;
  Stream<CustomAudioPlayerState> get onNotificationPlayerStateChanged =>
      _notificationPlayerStateController.stream;
  Stream<Duration> get onAudioPositionChanged => _positionController.stream;
  Stream<Duration> get onDurationChanged => _durationController.stream;
  Stream<void> get onPlayerCompletion => _completionController.stream;
  Stream<void> get onSeekComplete => _seekCompleteController.stream;
  Stream<String> get onPlayerError => _errorController.stream;
  Stream<PlayerControlCommand> get onPlayerCommand => _commandController.stream;

  @deprecated
  AudioPlayerStateChangeHandler audioPlayerStateChangeHandler;
  @deprecated
  TimeChangeHandler positionHandler;
  @deprecated
  TimeChangeHandler durationHandler;
  @deprecated
  VoidCallback completionHandler;
  @deprecated
  SeekHandler seekCompleteHandler;
  @deprecated
  ErrorHandler errorHandler;
  String playerId;
  PlayerMode mode;

  CustomAudioPlayer({this.mode = PlayerMode.MEDIA_PLAYER, this.playerId}) {
    this.mode ??= PlayerMode.MEDIA_PLAYER;
    this.playerId ??= _uuid.v4();
    players[playerId] = this;
  }

  Future<int> _invokeMethod(
      String method, [
        Map<String, dynamic> arguments,
      ]) {
    arguments ??= const {};

    final Map<String, dynamic> withPlayerId = Map.of(arguments)
      ..['playerId'] = playerId
      ..['mode'] = mode.toString();

    return _channel
        .invokeMethod(method, withPlayerId)
        .then((result) => (result as int));
  }

  Future<bool> monitorNotificationStateChanges(
      void Function(CustomAudioPlayerState value) callback,
      ) async {
    if (callback == null) {
      throw ArgumentError.notNull('callback');
    }
    final CallbackHandle handle = PluginUtilities.getCallbackHandle(callback);

    await _invokeMethod('monitorNotificationStateChanges', {
      'handleMonitorKey': <dynamic>[handle.toRawHandle()]
    });

    return true;
  }

  Future<int> play(
      String url, {
        double volume = 1.0,
        // position must be null by default to be compatible with radio streams
        Duration position,
        bool respectSilence = false,
        bool stayAwake = false,
        bool duckAudio = false,
        bool recordingActive = false,
      }) async {
    volume ??= 1.0;
    respectSilence ??= false;
    stayAwake ??= false;

    final int result = await _invokeMethod('play', {
      'url': url,
      'volume': volume,
      'position': position?.inMilliseconds,
      'respectSilence': respectSilence ?? false,
      'stayAwake': stayAwake ?? false,
      'duckAudio': duckAudio ?? false,
      'recordingActive': recordingActive ?? false,
    });

    if (result == 1) {
      state = CustomAudioPlayerState.PLAYING;
    }

    return result;
  }

  Future<int> playBytes(
      Uint8List bytes, {
        double volume = 1.0,
        // position must be null by default to be compatible with radio streams
        Duration position,
        bool respectSilence = false,
        bool stayAwake = false,
        bool duckAudio = false,
        bool recordingActive = false,
      }) async {
    volume ??= 1.0;
    respectSilence ??= false;
    stayAwake ??= false;

    if (!Platform.isAndroid) {
      throw PlatformException(
        code: 'Not supported',
        message: 'Only Android is currently supported',
      );
    }

    final int result = await _invokeMethod('playBytes', {
      'bytes': bytes,
      'volume': volume,
      'position': position?.inMilliseconds,
      'respectSilence': respectSilence,
      'stayAwake': stayAwake,
      'duckAudio': duckAudio,
      'recordingActive': recordingActive,
    });

    if (result == 1) {
      state = CustomAudioPlayerState.PLAYING;
    }

    return result;
  }


  Future<int> pause() async {
    final int result = await _invokeMethod('pause');

    if (result == 1) {
      state = CustomAudioPlayerState.PAUSED;
    }

    return result;
  }

  Future<int> stop() async {
    final int result = await _invokeMethod('stop');

    if (result == 1) {
      state = CustomAudioPlayerState.STOPPED;
    }

    return result;
  }

  Future<int> resume() async {
    final int result = await _invokeMethod('resume');

    if (result == 1) {
      state = CustomAudioPlayerState.PLAYING;
    }

    return result;
  }

  Future<int> release() async {
    final int result = await _invokeMethod('release');

    if (result == 1) {
      state = CustomAudioPlayerState.STOPPED;
    }

    return result;
  }

  Future<int> seek(Duration position) {
    _positionController.add(position);
    return _invokeMethod('seek', {'position': position.inMilliseconds});
  }

  Future<int> setVolume(double volume) {
    return _invokeMethod('setVolume', {'volume': volume});
  }

  Future<int> setReleaseMode(ReleaseMode releaseMode) {
    return _invokeMethod(
      'setReleaseMode',
      {'releaseMode': releaseMode.toString()},
    );
  }

  Future<int> setPlaybackRate({double playbackRate = 1.0}) {
    return _invokeMethod('setPlaybackRate', {'playbackRate': playbackRate});
  }

  Future<dynamic> setNotification({
    String title,
    String albumTitle,
    String artist,
    String imageUrl,
    Duration forwardSkipInterval = Duration.zero,
    Duration backwardSkipInterval = Duration.zero,
    Duration duration = Duration.zero,
    Duration elapsedTime = Duration.zero,
    bool hasPreviousTrack = false,
    bool hasNextTrack = false,
  }) {
    return _invokeMethod('setNotification', {
      'title': title ?? '',
      'albumTitle': albumTitle ?? '',
      'artist': artist ?? '',
      'imageUrl': imageUrl ?? '',
      'forwardSkipInterval': forwardSkipInterval.inSeconds,
      'backwardSkipInterval': backwardSkipInterval.inSeconds,
      'duration': duration.inSeconds,
      'elapsedTime': elapsedTime.inSeconds,
      'hasPreviousTrack': hasPreviousTrack,
      'hasNextTrack': hasNextTrack
    });
  }

  Future<int> getDuration() {
    return _invokeMethod('getDuration');
  }

  // Gets audio current playing position
  Future<int> getCurrentPosition() async {
    return _invokeMethod('getCurrentPosition');
  }

  static Future<void> platformCallHandler(MethodCall call) async {
    try {
      _doHandlePlatformCall(call);
    } catch (ex) {
      _log('Unexpected error: $ex');
    }
  }

  static Future<void> _doHandlePlatformCall(MethodCall call) async {
    final Map<dynamic, dynamic> callArgs = call.arguments as Map;
    _log('_platformCallHandler call ${call.method} $callArgs');

    final playerId = callArgs['playerId'] as String;
    final CustomAudioPlayer player = players[playerId];

    if (!kReleaseMode && Platform.isAndroid && player == null) {
      final oldPlayer = CustomAudioPlayer(playerId: playerId);
      await oldPlayer.release();
      oldPlayer.dispose();
      players.remove(playerId);
      return;
    }
    if (player == null) return;

    final value = callArgs['value'];

    switch (call.method) {
      case 'audio.onNotificationPlayerStateChanged':
        final bool isPlaying = value;
        player.notificationState =
        isPlaying ? CustomAudioPlayerState.PLAYING : CustomAudioPlayerState.PAUSED;
        break;
      case 'audio.onDuration':
        Duration newDuration = Duration(milliseconds: value);
        player._durationController.add(newDuration);
        // ignore: deprecated_member_use_from_same_package
        player.durationHandler?.call(newDuration);
        break;
      case 'audio.onCurrentPosition':
        Duration newDuration = Duration(milliseconds: value);
        player._positionController.add(newDuration);
        // ignore: deprecated_member_use_from_same_package
        player.positionHandler?.call(newDuration);
        break;
      case 'audio.onComplete':
        player.state = CustomAudioPlayerState.COMPLETED;
        player._completionController.add(null);
        // ignore: deprecated_member_use_from_same_package
        player.completionHandler?.call();
        break;
      case 'audio.onSeekComplete':
        player._seekCompleteController.add(value);
        // ignore: deprecated_member_use_from_same_package
        player.seekCompleteHandler?.call(value);
        break;
      case 'audio.onError':
        player.state = CustomAudioPlayerState.STOPPED;
        player._errorController.add(value);
        // ignore: deprecated_member_use_from_same_package
        player.errorHandler?.call(value);
        break;
      case 'audio.onGotNextTrackCommand':
        player._commandController.add(PlayerControlCommand.NEXT_TRACK);
        break;
      case 'audio.onGotPreviousTrackCommand':
        player._commandController.add(PlayerControlCommand.PREVIOUS_TRACK);
        break;
      default:
        _log('Unknown method ${call.method} ');
    }
  }

  static void _log(String param) {
    if (logEnabled) {
      print(param);
    }
  }

  Future<void> dispose() async {
    // First stop and release all native resources.
    await this.release();

    List<Future> futures = [];

    if (!_playerStateController.isClosed)
      futures.add(_playerStateController.close());
    if (!_notificationPlayerStateController.isClosed)
      futures.add(_notificationPlayerStateController.close());
    if (!_positionController.isClosed) futures.add(_positionController.close());
    if (!_durationController.isClosed) futures.add(_durationController.close());
    if (!_completionController.isClosed)
      futures.add(_completionController.close());
    if (!_seekCompleteController.isClosed)
      futures.add(_seekCompleteController.close());
    if (!_errorController.isClosed) futures.add(_errorController.close());

    await Future.wait(futures);
    players.remove(playerId);
  }
}
