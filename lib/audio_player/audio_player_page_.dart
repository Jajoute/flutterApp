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
  AudioCache cache;
  AudioPlayer player;
  int index = 0;
  bool isPlaying = false;
  bool isPaused = false;
  IconData icon = Icons.play_arrow;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayerState playerState;

  String _formatTime(Duration duration) =>
      "${duration.inMinutes.remainder(60)}:${(duration.inSeconds.remainder(60))}";

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

  next() async {
    if (player != null) {
      player.stop();
    }
    if (index == musics.length - 1) {
      index = 0;
    } else {
      index++;
    }
    setState(() {
      isPlaying = false;
      isPaused = false;
    });
  }

  previous() async {
    if (player != null) {
      player.stop();
    }
    if (index == 0) {
      index = musics.length - 1;
    } else {
      index--;
    }
    setState(() {
      isPlaying = false;
      isPaused = false;
    });
  }


  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    player.seek(newDuration);
  }

  void initAudioPlayer() {
    player = new AudioPlayer();
    cache = new AudioCache(fixedPlayer: player);
    player.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });
    player.onAudioPositionChanged.listen((Duration p) {
      setState(() => _position = p);
    });
    player.onPlayerStateChanged.listen((AudioPlayerState s) {
      setState(() {
        playerState = s;
        if (playerState == AudioPlayerState.COMPLETED) {
          next();
          Future.delayed(Duration(seconds: 1), () => playHandler());
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }


  @override
  Widget build(BuildContext context) {
    final item = musics[index];
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 30),
        ),
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
              Text(
                item.artist,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                item.title,
                style: TextStyle(color: Colors.white),
              ),
              Divider(),
              Stack(
                children: [
                  SizedBox(
                    width: 400,
                    child: Slider(
                        activeColor: Colors.white,
                        inactiveColor: Colors.grey,
                        value: _position.inSeconds.toDouble(),
                        min: 0.0,
                        max: _duration.inSeconds.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            seekToSecond(value.toInt());
                            value = value;
                          });
                        }),
                  ),
                  Positioned(
                      left: 0,
                      child: Text(
                        _formatTime(_position),
                        style: TextStyle(color: Colors.white),
                      )),
                  Positioned(
                      right: 0,
                      child: Text(
                        _formatTime(_duration),
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: previous,
                      child: Icon(
                        Icons.fast_rewind,
                        color: Colors.white,
                        size: 30,
                      )),
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
                      onPressed: next,
                      child: Icon(
                        Icons.fast_forward,
                        color: Colors.white,
                        size: 30,
                      )),
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
        child: TextButton(
            onPressed: widget.onPressed,
            child: Icon(
              widget.isTrue ? widget.trueIcon : widget.falseIcon,
              color: Colors.white,
              size: 50,
            )),
      ),
    );
  }
}
