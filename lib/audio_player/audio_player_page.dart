

import 'dart:io';



import 'package:flutter/material.dart';
import 'dart:math' as math;


import 'custom/audio_cache.dart';
import 'custom/audio_player.dart';




class AudioPlayerPage extends StatefulWidget {
  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();


  // AudioCache audioCache;
  // AudioPlayer audioPlayer;
  // Duration duration = Duration();
  // Duration position = Duration();
  // bool isSongPlaying = false;
  // bool isPlaying = false;
  //
  // void see1ToSeconds(int second){
  //   Duration newDuration = Duration(seconds: second);
  //   audioPlayer.seek(newDuration);
  // }
  //
  // @override
  //   void initState() {
  //     super.initState();
  //     if (Platform.isIOS) {
  //       if (audioCache.fixedPlayer != null) {
  //         audioCache.fixedPlayer.startHeadlessService();
  //       }
  //     }
  //   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Row(
        children: [
          IconButton(icon: Icon(Icons.play_arrow), onPressed: () async{
            audioCache.play('assets/audio.mp3');

          }),
          IconButton(icon: Icon(Icons.play_arrow), onPressed: () async{
            // audioCache.clearCache();
            // await advancedPlayer.stop();
          }),
        ],
      ),),
    );
  }
}
