import 'package:flutter/material.dart';

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
          '/us8': (context) => ConvertionAires('Convertion Aires'),
        },
      debugShowCheckedModeBanner: false,

    );
  }
}

