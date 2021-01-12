import 'package:flutter/material.dart';
import 'dart:math' as math;

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   String dropDownValueToConvert = 'Unité à convertir';
   String dropDownValueConverted = 'Convertir en';
   double valueToConvert = 0;
   double convertedValue = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            //---Value To Convert---
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Valeur à convertir'
              ),

              onChanged: (value){
                setState(() {
                  valueToConvert = double.parse(value);
                });


              },
            ),

            DropdownButton(
              value : dropDownValueToConvert,
              style: TextStyle(color: Colors.deepPurple),
              onChanged: (String newValue) {
                setState(() {
                  dropDownValueToConvert = newValue;
                });
              },
              items: <String>['Unité à convertir','km²','m²','cm²','hectare','acre'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),



            //----Converted Value----
            DropdownButton(
              value : dropDownValueConverted,
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              onChanged: (String newValue) {
                setState(() {
                  dropDownValueConverted = newValue;
                });
              },
              items: <String>['Convertir en','km²','m²','cm²','hectare','acre'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),


            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'résultat'
              ),

              controller : TextEditingController(text: converter(valueToConvert,dropDownValueToConvert,dropDownValueConverted).toString()),


            ),





          ],

        ),
      ),
    );
    }

    double converter(double entryValue, String toConvert, String converted){
      double result = 0;

      switch(toConvert) {

        case "km²": {
          result = entryValue * 1000000;

        }
        break;

        case "m²": {
          result = entryValue * 1;
        }
        break;

        case "cm²": {
          result = entryValue * 0.001;
        }
        break;

        case "hectare": {
          result = entryValue * 10000;
        }
        break;

        case "acre": {
          result = entryValue * 4046.85642;
        }
        break;


        default: { print("Invalid choice"); }
        break;
      }


      switch(converted) {

        case "km²": {
          return result * 0.000001;
        }
        break;

        case "m²": {
          return result * 1;
        }
        break;

        case "cm²": {
          return result * 1000;
        }
        break;

        case "hectare": {
          return result * 0.00010;
        }

        case "acre": {
          return result * 0.00025;
        }


        break;

        default: {
          return 0 ;
        }
        break;
      }


   }


}
