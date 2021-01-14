import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'music.dart';

class AudioPlayerPage extends StatefulWidget {
  final String title;

  const AudioPlayerPage({Key key, this.title}) : super(key: key);
  
  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
 List<Music> musics = [
   Music('Musique 1', 'San Goku', 'images/sangoku.png', 'musics/2.mp3'),
   Music('Musique 2', 'San Gohan', 'images/sangohan.jpg', 'musics/1.mp3'),
   Music('Musique 3', 'Broly', 'images/broly.jpg', 'musics/3.mp3'),
 ];
  static AudioCache cache = AudioCache();
  AudioPlayer player;
  int index = 0;
   bool isPlaying = false;
   bool isPaused = false;
   IconData icon = Icons.play_arrow;

 void playHandler() async {
   if (isPlaying) {
     player.stop();
   } else {
     player = await cache.play(musics[index].musicPath);
   }

   setState(() {
     if (isPaused) {
       isPlaying = false;
       isPaused = false;
       icon = Icons.play_arrow;
     } else {
       isPlaying = !isPlaying;
       icon = Icons.stop;
     }
   });
 }

 void pauseHandler() {
   if (isPaused && isPlaying) {
     player.resume();
   } else {
     player.pause();
   }
   setState(() {
     isPaused = !isPaused;
     if (isPaused && isPlaying) {
       icon = Icons.pause;
     } else {
       icon = Icons.play_arrow;
     }
   });
 }

  next() async{
   if(player != null){
     player.stop();
   }
    if(index == musics.length -1){
      index = 0;
    }else{
      index++;
    }
    setState(() {
      isPlaying = false;
      isPaused = false;
    });
  }

  previous() async{
    if(player != null){
      player.stop();
    }
    if(index == 0){
      index = musics.length - 1;
    }else{
      index--;
    }
    setState(() {
      isPlaying = false;
      isPaused = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    final item = musics[index];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 30),),
      ),
      body: Center(
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Material(
                elevation: 10,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
                 child: Image.asset("assets/${item.imagePath}"),
                ),
              ),
              SizedBox(height: 50),
              Text(item.artist, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),),
              SizedBox(height: 20),
              Text(item.title, style: TextStyle(color: Colors.blue),),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: previous , child: Icon(Icons.fast_rewind, color: Colors.blue, size: 30,)),
                  PlayerControlButton(
                    onPressed: playHandler,
                    isTrue: isPlaying,
                    trueIcon: Icons.stop,
                    falseIcon: Icons.play_arrow,
                  ),
                  PlayerControlButton(
                    onPressed: isPlaying ? pauseHandler : null,
                    isTrue: isPaused,
                    trueIcon: Icons.play_arrow,
                    falseIcon: Icons.pause,
                  ),
                  TextButton(
                      onPressed: next , child: Icon(Icons.fast_forward, color: Colors.blue, size: 30,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


class PlayerControlButton extends StatefulWidget {
  final Function() onPressed;
  final bool isTrue;
  final IconData trueIcon;
  final IconData falseIcon;

  PlayerControlButton({
    @required this.onPressed,
    @required this.isTrue,
    @required this.trueIcon,
    @required this.falseIcon,
  });

  @override
  _PlayerControlButtonState createState() => _PlayerControlButtonState();
}

class _PlayerControlButtonState extends State<PlayerControlButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        width: 70,
        height: 70,
        child: TextButton(onPressed: widget.onPressed, child: Icon(widget.isTrue ? widget.trueIcon : widget.falseIcon, color: Colors.blue, size: 50,)),
      ),
    );
  }
}