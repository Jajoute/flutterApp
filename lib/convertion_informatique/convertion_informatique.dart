import 'dart:math';
import 'package:flutter/material.dart';

class ConvertionInformatique extends StatefulWidget {
  final String title;

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
    inController = TextEditingController(text: '');
    outController = TextEditingController(text: '');
    inRes = 0;
    outRes = 0;
  }

  void fromInToOut() {
    double resInOctet = toOctet(inRes, inLabelValue);
    outController.text = resInOctet != null ? toConvert(resInOctet, outLabelValue).toString() : '';
    outRes = double.parse(outController.text);
  }

  void fromOutToIn() {
    double resInOctet = toOctet(outRes, outLabelValue);
    inController.text = resInOctet != null ? toConvert(resInOctet, inLabelValue).toString() : '';
    inRes = double.parse(inController.text);
  }

  double toOctet(double value, String label) {
    if (value != null) {
      switch (label) {
        case 'Octet - O':
          return value;
        case 'Kilooctet - KO':
          return value * pow(10, 3);
        case 'Mégaoctet - MO':
          return value * pow(10, 6);
        case 'Gigaoctet - GO':
          return value * pow(10, 9);
        case 'Téraoctet - TO':
          return value * pow(10, 12);
        case 'Pétaoctet - PO':
          return value * pow(10, 15);
      }
    }
  }

  double toConvert(double value, String label) {
    if (value != null) {
      switch (label) {
        case 'Octet - O':
          return value;
        case 'Kilooctet - KO':
          return value / pow(10, 3);
        case 'Mégaoctet - MO':
          return value / pow(10, 6);
        case 'Gigaoctet - GO':
          return value / pow(10, 9);
        case 'Téraoctet - TO':
          return value / pow(10, 12);
        case 'Pétaoctet - PO':
          return value / pow(10, 15);
      }
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
              icon: Icon(Icons.arrow_drop_down),
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
                controller: inController,
                decoration:
                    new InputDecoration(labelText: "Valeur Entrante: "),
              ),
            ),

            //Menu déroulant des valeurs sortantes
            DropdownButton<String>(
              value: outLabelValue,
              icon: Icon(Icons.arrow_drop_down),
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
                controller: outController,
                decoration:
                    new InputDecoration(labelText: "Valeur Sortante: "),
              ),
            ),
          ],
        )));
  }
}
