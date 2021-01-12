
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class AudioPlayerPage extends StatefulWidget {
  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: IconButton(icon: Icon(Icons.play_arrow), onPressed: () async{
        AudioPlayer audioPlayer = AudioPlayer();
        int result = await audioPlayer.play('assets/audio2.mp3', isLocal: true);
      }),),
    );
  }
}

//
// class Test {
//
//   double octet;
//
//   double fromOctetToKilOctet(double octet) => octet / math.pow(10, 3);
//   double fromOctetToMegaOctet(double octet) => octet / math.pow(10, 6);
//   double fromOctetToGigaOctet(double octet) => octet / math.pow(10, 9);
//   double fromOctetToTeraOctet(double octet) => octet / math.pow(10, 12);
//   double fromOctetToPetaOctet(double octet) => octet / math.pow(10, 15);
//
//   double fromOctetToKilOctet(double octet) => octet / math.pow(10, 3);
//   double fromOctetToMegaOctet(double octet) => octet / math.pow(10, 6);
//   double fromOctetToGigaOctet(double octet) => octet / math.pow(10, 9);
//   double fromOctetToTeraOctet(double octet) => octet / math.pow(10, 12);
//   double fromOctetToPetaOctet(double octet) => octet / math.pow(10, 15);
//
//
//   void tambouille()
//
// }