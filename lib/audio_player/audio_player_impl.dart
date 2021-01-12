

import 'package:flutter/services.dart';
import 'package:flutter_projet/audio_player/i_audio_player.dart';

class AudioPlayerImpl implements IAudioPlayer{

  @override
  void pause() {
    // TODO: implement pause
  }

  @override
  void play() async{
    ByteData byteData= await rootBundle.load('assets/audio.mp3');
    byteData.buffer.asByteData();

  }

  @override
  void stop() {
    // TODO: implement stop
  }




}


