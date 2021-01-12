import 'package:flutter/material.dart';
import 'dart:math' as math;

class ConvertionInformatique extends StatefulWidget {
  String title;

  ConvertionInformatique(this.title);

  @override
  _ConvertionInformatique createState() => _ConvertionInformatique();
}

class _ConvertionInformatique extends State<ConvertionInformatique> {
List<String> labels = [
    'Octet - O',
    'Kilooctet - KO',
    'Mégaoctet - MO',
    'Gigaoctet - GO',
    'Téraoctet - TO',
    'Pétaoctet - PO'
  ];
  String inLabelValue, outLabelValue;
  TextEditingController inController, outController;
  double inRes, outRes;

  @override
  void initState() {
    super.initState();
     inLabelValue = labels[0];
     outLabelValue = labels[1];
     inController = TextEditingController();
     outController = TextEditingController();
  }

  void fromInToOut(){
    double resInOctet = toOctet(inRes, inLabelValue);
    outController.text = toConvert(resInOctet, outLabelValue).toString();
  }

  void fromOutToIn(){
    double resInOctet = toOctet(outRes, outLabelValue);
    inController.text = toConvert(resInOctet, inLabelValue).toString();
  }

  double toOctet(double value, String label){
    switch (label) {
      case 'Kilooctet - KO':
        return value * math.pow(10, 3);
      case 'Mégaoctet - MO':
        return value * math.pow(10, 6);
      case 'Gigaoctet - GO':
        return value * math.pow(10, 9);
      case 'Téraoctet - TO':
        return value * math.pow(10, 12);
      case 'Pétaoctet - PO':
        return value * math.pow(10, 15);
      default:
       return value;
    }
  }

  double toConvert(double value, String label){
    switch (label) {
      case 'Kilooctet - KO':
        return value / math.pow(10, 3);
      case 'Mégaoctet - MO':
        return value / math.pow(10, 6);
      case 'Gigaoctet - GO':
        return value / math.pow(10, 9);
      case 'Téraoctet - TO':
        return value / math.pow(10, 12);
      case 'Pétaoctet - PO':
        return value / math.pow(10, 15);
      default:
        return value;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Menu déroulant des valeurs entrantes
            DropdownButton<String>(
              value: inLabelValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.blue),
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (v) {
                setState(() {
                  inLabelValue = v;
                  fromInToOut();
                });
              },
              items: labels.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            //Textfield pour entrer des valeurs entrantes
            SizedBox(
              width: 200,
              height: 60,
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    inRes = double.parse(val);
                    fromInToOut();
                  });
                },
                controller:inController,
                decoration: new InputDecoration(labelText: "Valeur Entrante:"),
              ),
            ),

            //Menu déroulant des valeurs sortantes
            DropdownButton<String>(
              value: outLabelValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.blue),
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (v) {
                setState(() {
                  outLabelValue = v;
                  fromOutToIn();
                });
              },
              items: labels.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            //Textfield pour entrer des valeurs sortantes
            SizedBox(
              width: 200,
              height: 60,
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    outRes = double.parse(val);
                    fromOutToIn();
                  });
                },
                controller:outController,
                decoration: new InputDecoration(labelText: "Valeur Sortante:"),
              ),
            ),
          ],
        )));
  }
}
