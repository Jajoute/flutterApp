import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_projet/age/age_page.dart';
import 'package:flutter_projet/audio_player/audio_player_page_.dart';
import 'package:flutter_projet/calcul_promotion/calcul_promotion.dart';
import 'package:flutter_projet/convertion_aires/convertion_aires.dart';
import 'package:flutter_projet/convertion_distance/convertion_distance.dart';
import 'package:flutter_projet/convertion_informatique/convertion_informatique.dart';
import 'package:flutter_projet/convertion_numerique/convertion_numerique.dart';
import 'package:flutter_projet/convertion_temp/convertion_temp.dart';
import 'package:flutter_projet/date/date_page.dart';
import 'package:flutter_projet/home/feature.dart';
import 'package:flutter_projet/storage/shared_pref_storage_repository.dart';
import 'package:flutter_projet/storage/storage_repository.dart';
import 'package:flutter_projet/convertion_romain/convertion_romain.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPrefStorageRepository _storageRepository =
      SharedPrefStorageRepository();
  List<Feature> maList = [
    Feature(
        "Convertion Informatique",
        Icons.sd_storage_outlined,
        ConvertionInformatique('Convertion Informatique'),
        TransitionType.scale),
    Feature("Calcul Date de Naissance", Icons.cake_outlined,
        AgePage("Calcul Date de Naissance"), TransitionType.fade),
    Feature("Calcul de Promotion", Icons.wallet_giftcard_outlined,
        CalculPromotion('Calcul de Promotion'), TransitionType.slide),
    Feature("Différence de Date", Icons.today_outlined,
        DatePage("Différence de Date"), TransitionType.fade),
    Feature("Convertion de Distance", Icons.architecture,
        ConvertionDistance('Convertion de Distance'), TransitionType.slide),
    Feature("Convertion Numérique", Icons.calculate_outlined,
        ConvertionNumerique("Convertion Numérique"), TransitionType.scale),
    Feature("Convertion d\'Aires", Icons.map_outlined,
        ConvertionAires('Convertion d\'Aires'), TransitionType.fade),
    Feature("Convertion de Température", Icons.device_thermostat,
        ConvertionTempPage("Convertion de Température"), TransitionType.slide),
    Feature("Convertion en Chiffre Romain", Icons.history_edu,
        ConvertionRomainPage("Convertion en Chiffre Romain"), TransitionType.scale),
    Feature(
        "Lecteur de Musique",
        Icons.music_note,
        AudioPlayerPage(
          title: 'Lecture de Musique',
        ),
        TransitionType.fade)
  ];
  Widget display;

  ElevatedButton _buildDrawerButton(
          String title, IconData icon, Function() onPressed) =>
      ElevatedButton(
        onPressed: onPressed,
        child: Container(
          width: 55,
          height: 65,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(icon),
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
      );

  GridView _buildGrid({BuildContext context}) => GridView.builder(
        padding: EdgeInsets.all(20),
        itemCount: maList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          final item = maList[index];
          return FittedBox(
            fit: BoxFit.fill,
            child: Container(
              color: index % 2 == 0 ? Colors.blue.shade50 : Colors.blue,
              height: 110,
              width: 110,
              child: GestureDetector(
                onTap: () => item.navigateTo(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.icon,
                      color: index % 2 == 0 ? Colors.blue : Colors.white,
                      size: 40,
                    ),
                    // Text(item.title,
                    //     style: DefaultTextStyle.of(context)
                    //         .style
                    //         .apply(fontSizeFactor: 0.5, color: Colors.blue)),
                  ],
                ),
              ),
            ),
          );
        },
      );

  GridView _buildCards({BuildContext context}) => GridView.builder(
        padding: EdgeInsets.all(20),
        itemCount: maList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          final item = maList[index];
          return FittedBox(
            child: SizedBox(
              height: 110,
              width: 110,
              child: Card(
                color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  elevation: 12.0,
                  child: InkWell(
                    onTap: () => item.navigateTo(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item.icon,
                            color: Colors.blue,
                            size: 40,
                          ),
                          Text(item.title,
                              textAlign: TextAlign.center,
                              style: DefaultTextStyle.of(context).style.apply(
                                  fontSizeFactor: 1, color: Colors.blue)),
                        ],
                      ),
                    ),
                  )),
            ),
          );
        },
      );

  ListView _buildList({BuildContext context}) => ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        padding: EdgeInsets.all(50),
        itemCount: maList.length,
        itemBuilder: (context, index) {
          final item = maList[index];

          return FittedBox(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15)
              ),
              width: MediaQuery.of(context).size.width,
              child: Material(
                color: Colors.white,
                child: ListTile(
                  trailing: Icon(
                    item.icon,
                    color: Colors.blue.shade400,
                    size: 30,
                  ),
                  onTap: () => item.navigateTo(context),
                  title: Text(
                    item.title,
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.50, fontWeightDelta: 2, color: Colors.blue.shade400),
                  ),
                ),
              ),
            ),
          );
        },
      );

  @override
  void initState() {
    super.initState();
    display = _buildGrid();
    _findOrigin().then((value) {
      display = value;
    });
  }

  Future<Widget> _findOrigin() async {
    switch (await _storageRepository.read('homeStyle')) {
      case 'grille':
        return _buildGrid();
      case 'list':
        return _buildList();
      case 'card':
        return _buildCards();
      default:
        return _buildList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Le Scaffold c'est la feneêtre de l'appli c'est comme le conteneur principale dans react
      drawer: Container(
        width: 80,
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildDrawerButton('Grille', Icons.grid_view, () {
              setState(() {
                display = _buildGrid(context: context);
              });
              _storageRepository.upsert('homeStyle', 'grille');
              Navigator.of(context).pop();
            }),
            SizedBox(height: 5),
            _buildDrawerButton('Liste', Icons.list, () {
              setState(() {
                display = _buildList(context: context);
              });
              _storageRepository.upsert('homeStyle', 'list');
              Navigator.of(context).pop();
            }),
            SizedBox(height: 5),
            _buildDrawerButton('Card', Icons.card_travel_rounded, () {
              setState(() {
                display = _buildCards(context: context);
              });
              _storageRepository.upsert('homeStyle', 'card');
              Navigator.of(context).pop();
            }),
          ],
        ),
      ),
      backgroundColor: Colors.blue,

      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Accueil"),
        elevation: 0,
      ),
      body: Center(
        child: display ?? CircularProgressIndicator(),
      ),
    );
  }
}
