import 'package:flutter/material.dart';

import 'custom_audio_cache.dart';
import 'custom_audio_player.dart';



class AudioPlayerPage extends StatefulWidget {
  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  CustomAudioCache audioCache = CustomAudioCache();
  CustomAudioPlayer advancedPlayer = CustomAudioPlayer();

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
