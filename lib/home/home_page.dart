import 'package:flutter/material.dart';
import 'package:flutter_projet/home/feature.dart';

class HomePage extends StatelessWidget {
  List<Feature> maList = [
    Feature("US2", Icons.ad_units, () {}),
    Feature("US3", Icons.announcement_sharp, () {}),
    Feature("US4", Icons.ad_units, () {}),
    Feature("US5", Icons.ad_units, () {}),
    Feature("US6", Icons.ad_units, () {}),
    Feature("US7", Icons.ad_units, () {}),
    Feature("US8", Icons.ad_units, () {}),
    Feature("US9", Icons.ad_units, () {}),
    Feature("US10", Icons.ad_units, () {}),
    Feature("US11", Icons.ad_units, () {}),
    Feature("US12", Icons.ad_units, () {})
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Le Scaffold c'est la feneêtre de l'appli c'est comme le conteneur principale dans react

        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Accueil"),
        ),
        body: GridView.builder(
          padding: EdgeInsets.all(100),
          itemCount: maList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            final item = maList[index];
            return Container(
              child: Card(
                elevation: 12.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    size: 80,
                    color: Colors.blue,
                  ),
                  Text(item.title, style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0, color: Colors.blue)),
                ],
              )),
            );
          },
        )

        //floatingActionButton: FloatingActionButton(
        //onPressed: null,
        //tooltip: 'Increment',
        //child: Icon(Icons.add),
        //), // This trailing comma makes auto-formatting nicer for build methods.
        );
    //void versNouvellePage(){
    //Navigator.push(context, new MaterialPageRoute(builder: (BuildContext){//ici on dit enregistre une nouvelle route
    //return new NouvellePage('second Page');//ici c'est notre nouvelle page qui prend en paramettre un titre
    //}));//Navigator provient de l'API flutter pour faire les navigation
    //}
  }
}
