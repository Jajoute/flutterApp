import 'package:flutter/material.dart';
import 'package:flutter_projet/home/feature.dart';
import 'package:flutter_projet/storage/storage_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StorageRepository _storageRepository = StorageRepository();
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
              Text(title, style: TextStyle(fontSize: 12),)
            ],
          ),
        ),
      );

  GridView _buildGrid() => GridView.builder(
    padding: EdgeInsets.all(20),
    itemCount: maList.length,
    gridDelegate:
    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    itemBuilder: (context, index) {
      final item = maList[index];
      return Container(
        color: index % 2 == 0 ? Colors.blue.shade50 : Colors.white,
        child: FittedBox(
          child: GestureDetector(
            onTap: item.destination,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    color: Colors.blue,
                  ),
                  Text(item.title,
                      style: DefaultTextStyle.of(context).style.apply(
                          fontSizeFactor: 0.5, color: Colors.blue)),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );


  GridView _buildCards() => GridView.builder(
        padding: EdgeInsets.all(20),
        itemCount: maList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          final item = maList[index];
          return FittedBox(
            child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 12.0,
                child: InkWell(
                  onTap: item.destination,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          color: Colors.blue,
                        ),
                        Text(item.title,
                            style: DefaultTextStyle.of(context).style.apply(
                                fontSizeFactor: 0.5, color: Colors.blue)),
                      ],
                    ),
                  ),
                )),
          );
        },
      );

  ListView _buildList() => ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        padding: EdgeInsets.all(100),
        itemCount: maList.length,
        itemBuilder: (context, index) {
          final item = maList[index];

          return ListTile(
            trailing: Icon(
              item.icon,
              color: Colors.blue,
            ),
            onTap: () => item.destination,
            title: Text(
              item.title,
              style: DefaultTextStyle.of(context)
                  .style
                  .apply(fontSizeFactor: 1, color: Colors.blue),
            ),
          );
        },
      );

  @override
  void initState() {
    super.initState();
    _findOrigin().then((value) => display = value);
  }

  Future<Widget> _findOrigin() async{
    switch(await _storageRepository.read('homeStyle')){
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
                  display = _buildGrid();
                });
                _storageRepository.upsert('homeStyle', 'grille');
                Navigator.of(context).pop();
              }),
              SizedBox(height: 5),
              _buildDrawerButton('List', Icons.list, () {
                setState(() {
                  display = _buildList();
                });
                _storageRepository.upsert('homeStyle', 'list');
                Navigator.of(context).pop();
              }),
              SizedBox(height: 5),
              _buildDrawerButton('Card', Icons.card_travel_rounded, () {
                setState(() {
                  display = _buildCards();
                });
                _storageRepository.upsert('homeStyle', 'card');
                Navigator.of(context).pop();

              }),
            ],
          ),
        ),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Accueil"),
        ),
        body: Center(child: display ?? CircularProgressIndicator())

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
