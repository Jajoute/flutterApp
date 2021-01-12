import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import 'audio_player.dart';

class AudioCache {
  Map<String, File> loadedFiles = {};
  AudioPlayer fixedPlayer;


  AudioCache({
    this.fixedPlayer,
  });

  void clear(String fileName) {
    final file = loadedFiles.remove(fileName);
    file?.delete();
  }

  /// Clears the whole cache.
  void clearCache() {
    for (final file in loadedFiles.values) {
      file.delete();
    }
    loadedFiles.clear();
  }

  Future<ByteData> _fetchAsset(String fileName) async => await rootBundle.load(fileName);

  Future<File> fetchToMemory(String fileName) async {
    final file = File('${(await getTemporaryDirectory()).path}/$fileName');
    await file.create(recursive: true);
    return await file
        .writeAsBytes((await _fetchAsset(fileName)).buffer.asUint8List());
  }


  Future<File> load(String fileName) async {
    if (!loadedFiles.containsKey(fileName)) {
      loadedFiles[fileName] = await fetchToMemory(fileName);
    }
    return loadedFiles[fileName];
  }

  AudioPlayer _player(PlayerMode mode) {
    return fixedPlayer ?? new AudioPlayer(mode: mode);
  }

  /// Plays the given [fileName].
  ///
  /// If the file is already cached, it plays immediately. Otherwise, first waits for the file to load (might take a few milliseconds).
  /// It creates a new instance of [AudioPlayer], so it does not affect other audios playing (unless you specify a [fixedPlayer], in which case it always use the same).
  /// The instance is returned, to allow later access (either way), like pausing and resuming.
  ///
  /// isNotification and stayAwake are not implemented on macOS
  Future<AudioPlayer> play(
      String fileName, {
        double volume = 1.0,
        bool isNotification,
        PlayerMode mode = PlayerMode.MEDIA_PLAYER,
        bool stayAwake = false,
        bool recordingActive = false,
        bool duckAudio,
      }) async {
    String url = await getAbsoluteUrl(fileName);
    AudioPlayer player = _player(mode);
    player.setReleaseMode(ReleaseMode.STOP);
    await player.play(
      url,
      volume: volume,
      stayAwake: stayAwake,
      recordingActive: recordingActive,
    );
    return player;
  }

  Future<String> getAbsoluteUrl(String fileName) async {
    if (kIsWeb) {
      return 'assets/$fileName';
    }
    File file = await load(fileName);
    return file.path;
  }
}
