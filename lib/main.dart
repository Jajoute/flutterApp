import 'package:flutter/material.dart';

import 'package:flutter_projet/date/date_page.dart';

import 'package:flutter_projet/convertion_aires/convertion_aires.dart';
import 'package:flutter_projet/convertion_distance/convertion_distance.dart';

import 'package:flutter_projet/convertion_informatique/convertion_informatique.dart';

import 'package:flutter_projet/home/home_page.dart';
import 'package:flutter_projet/calcul_promotion/calcul_promotion.dart';

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
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/us2': (context) => ConvertionInformatique('Convertion Informatique'),
          '/us4' : (context) => CalculPromotion('Calcul Promotion'),
          '/us6' : (context) => ConvertionDistance('Convertion Distance'),
          '/us8': (context) => ConvertionAires('Convertion Aires'),
          '/us5': (context) => DatePage(),
        },
      debugShowCheckedModeBanner: false,
    );
  }
}

