import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import 'custom_audio_player.dart';


class CustomAudioCache {
  Map<String, File> loadedFiles = {};
  CustomAudioPlayer fixedPlayer;


  CustomAudioCache({
    this.fixedPlayer,
  });

  void clear(String fileName) {
    final file = loadedFiles.remove(fileName);
    file?.delete();
  }

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

  CustomAudioPlayer _player(PlayerMode mode) {
    return fixedPlayer ?? new CustomAudioPlayer(mode: mode);
  }

  Future<CustomAudioPlayer> play(
      String fileName, {
        double volume = 1.0,
        bool isNotification,
        PlayerMode mode = PlayerMode.MEDIA_PLAYER,
        bool stayAwake = false,
        bool recordingActive = false,
        bool duckAudio,
      }) async {
    String url = await getAbsoluteUrl(fileName);
    CustomAudioPlayer player = _player(mode);
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
