import 'package:flutter/material.dart';

class ConvertionDistancePage extends StatefulWidget {
  final String title;

  ConvertionDistancePage(this.title);

  @override
  _ConvertionDistance createState() => _ConvertionDistance();
}

class _ConvertionDistance extends State<ConvertionDistancePage> {
  List<String> labels = [
    'Nanomètre – nm',
    'Millimètre – mm',
    'Centimètre – cm',
    'Décimètre – dm',
    'Mètre – m',
    'Kilomètre – km',
    'Yard – yd',
    'Pied – ft',
    'Pouce – in'
  ];
  String inLabelValue, outLabelValue;
  TextEditingController inController, outController;
  double inRes, outRes;

  @override
  void initState() {
    super.initState();
    inLabelValue = labels[1];
    outLabelValue = labels[2];
    inController = TextEditingController(text: '');
    outController = TextEditingController(text: '');
    inRes = 0;
    outRes = 0;
  }

  //Call to change the outController value and update outRes
  void fromInToOut() {
    double resInOctet = toMeter(inRes, inLabelValue);
    outController.text = resInOctet != null
        ? toConvert(resInOctet, outLabelValue).toString()
        : '';
    outRes = double.parse(outController.text);
  }

  //Call to change the inController value and update intRes
  void fromOutToIn() {
    double resInOctet = toMeter(outRes, outLabelValue);
    inController.text = resInOctet != null
        ? toConvert(resInOctet, inLabelValue).toString()
        : '';
    inRes = double.parse(inController.text);
  }

  //Convert every value into meter
  double toMeter(double value, String label) {
    if (value != null) {
      switch (label) {
        case 'Nanomètre – nm':
          return value / 10000;
        case 'Millimètre – mm':
          return value / 1000;
        case 'Centimètre – cm':
          return value / 100;
        case 'Décimètre – dm':
          return value / 10;
        case 'Mètre – m':
          return value;
        case 'Kilomètre – km':
          return value * 10;
        case 'Yard – yd':
          return value * 0.9144;
        case 'Pied – ft':
          return value * 0.3048;
        case 'Pouce – in':
          return value * 0.0254;
      }
    }
  }

  //Convert meter values to all other distance values
  double toConvert(double value, String label) {
    if (value != null) {
      switch (label) {
        case 'Nanomètre – nm':
          return value * 10000;
        case 'Millimètre – mm':
          return value * 1000;
        case 'Centimètre – cm':
          return value * 100;
        case 'Décimètre – dm':
          return value * 10;
        case 'Mètre – m':
          return value;
        case 'Kilomètre – km':
          return value / 10;
        case 'Yard – yd':
          return value / 0.9144;
        case 'Pied – ft':
          return value / 0.3048;
        case 'Pouce – in':
          return value / 0.0254;
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
            //Unit of measure to convert
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

            SizedBox(
              width: 200,
              height: 60,
              //Value to convert 
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    inRes = double.parse(val);
                    fromInToOut();
                  });
                },
                controller: inController,
                decoration: new InputDecoration(labelText: "Valeur Entrante: "),
              ),
            ),

            //Unit of measure to convert to
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

            SizedBox(
              width: 200,
              height: 60,
              //Value to convert to
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    outRes = double.parse(val);
                    fromOutToIn();
                  });
                },
                controller: outController,
                decoration: new InputDecoration(labelText: "Valeur Sortante: "),
              ),
            ),
          ],
        )));
  }
}
