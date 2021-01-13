import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_projet/convertion_aires/convertion_aires.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ConvertionAires('Convertion de tes morts'),
    );
  }
}