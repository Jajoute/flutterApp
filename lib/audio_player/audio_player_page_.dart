import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projet/audio_player/widget/player_control_button_widget.dart';

import 'model/music.dart';


class AudioPlayerPage extends StatefulWidget {
  final String title;

  const AudioPlayerPage({Key key, this.title}) : super(key: key);

  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  List<Music> _musics = [
    Music('Musique 1', 'San Goku', 'images/sangoku.png', 'musics/2.mp3'),
    Music('Musique 2', 'San Gohan', 'images/sangohan.jpg', 'musics/1.mp3'),
    Music('Musique 3', 'Broly', 'images/broly.jpg', 'musics/3.mp3'),
  ];
  AudioCache _cache;
  AudioPlayer _player;
  int _index = 0;
  bool _isPlaying = false;
  bool _isPaused = false;
  IconData _icon = Icons.play_arrow;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayerState _playerState;

  String _formatTime(Duration duration) =>
      "${duration.inMinutes.remainder(60)}:${(duration.inSeconds.remainder(60))}";

  void _play() async {
    if (_isPlaying) {
      _player.stop();
    } else {
      _player = await _cache.play(_musics[_index].musicPath);
    }

    setState(() {
      if (_isPaused) {
        _isPlaying = false;
        _isPaused = false;
        _icon = Icons.play_arrow;
      } else {
        _isPlaying = !_isPlaying;
        _icon = Icons.stop;
      }
    });
  }

  void _pause() {
    if (_isPaused && _isPlaying) {
      _player.resume();
    } else {
      _player.pause();
    }
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused && _isPlaying) {
        _icon = Icons.pause;
      } else {
        _icon = Icons.play_arrow;
      }
    });
  }

  void _next() async {
    if (_player != null) {
      _player.stop();
    }
    if (_index == _musics.length - 1) {
      _index = 0;
    } else {
      _index++;
    }
    setState(() {
      _isPlaying = false;
      _isPaused = false;
    });
  }

  void _previous() async {
    if (_player != null) {
      _player.stop();
    }
    if (_index == 0) {
      _index = _musics.length - 1;
    } else {
      _index--;
    }
    setState(() {
      _isPlaying = false;
      _isPaused = false;
    });
  }


  void _seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    _player.seek(newDuration);
  }

  void _initAudioPlayer() {
    _player = new AudioPlayer();
    _cache = new AudioCache(fixedPlayer: _player);
    _player.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });
    _player.onAudioPositionChanged.listen((Duration p) {
      setState(() => _position = p);
    });
    _player.onPlayerStateChanged.listen((AudioPlayerState s) {
      setState(() {
        _playerState = s;
        if (_playerState == AudioPlayerState.COMPLETED) {
          _next();
          Future.delayed(Duration(seconds: 1), () => _play());
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }


  @override
  Widget build(BuildContext context) {
    final item = _musics[_index];
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {
          _play();
          Navigator.pop(context);
        }
        ,),
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
                  width: 400,
                  height: 400,
                  child: Image.asset("assets/${item.imagePath}", fit: BoxFit.cover,),
                ),
              ),
              SizedBox(height: 50),
////////////////////////////////////////////////////////////////////////////////
// ARTIST & TITLE
////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////
// PLAYER DURATION SLIDER
////////////////////////////////////////////////////////////////////////////////
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
                            _seekToSecond(value.toInt());
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
////////////////////////////////////////////////////////////////////////////////
// PLAYER CONTROL BUTTONS BAR
////////////////////////////////////////////////////////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: _previous,
                      child: Icon(
                        Icons.fast_rewind,
                        color: Colors.white,
                        size: 30,
                      )),
                  PlayerControlButtonWidget(
                    onPressed: _play,
                    isTrue: _isPlaying,
                    trueIcon: Icons.stop,
                    falseIcon: Icons.play_arrow,
                  ),
                  PlayerControlButtonWidget(
                    onPressed: _isPlaying ? _pause : null,
                    isTrue: _isPaused,
                    trueIcon: Icons.play_arrow,
                    falseIcon: Icons.pause,
                  ),
                  TextButton(
                      onPressed: _next,
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

