import 'package:flutter/material.dart';

class ConvertionNumerique extends StatefulWidget {
  final String title;

  ConvertionNumerique(this.title);

  @override
  _ConvertionNumerique createState() => _ConvertionNumerique();
}

class _ConvertionNumerique extends State<ConvertionNumerique> {
  List<String> labels = [
    'Binaire - BIN',
    'Octal - OCT',
    'Décimal - DEC',
    'Hexadécimal - HEX',
  ];
  String inLabelValue, outLabelValue;
  TextEditingController inController, outController;
  int inRes, outRes;

  @override
  void initState() {
    super.initState();
    inLabelValue = labels[2];
    outLabelValue = labels[0];
    inController = TextEditingController(text: '');
    outController = TextEditingController(text: '');
    inRes = 0;
    outRes = 0;
  }

  void fromInToOut() {
    int resInDecimal = int.parse(toDecimal(inRes, inLabelValue));
    outController.text = resInDecimal != null
        ? toConvert(resInDecimal, outLabelValue).toString()
        : '';
    outRes = int.parse(outController.text);
  }

  void fromOutToIn() {
    int resInDecimal = int.parse(toDecimal(outRes, outLabelValue));
    inController.text =
        resInDecimal != null ? toConvert(resInDecimal, inLabelValue) : '';
    inRes = int.parse(inController.text);
  }

  String toDecimal(int value, String label) {
    if (value != null) {
      if (label == 'Décimal - DEC') {
        return value.toString();
      } else if (label == 'Binaire - BIN' ||
          label == 'Octal - OCT' ||
          label == 'Hexadécimal - HEX') {
        return value.toRadixString(0);
      }
    }
  }

  String toConvert(int value, String label) {
    if (value != null) {
      switch (label) {
        case 'Binaire - BIN':
          return value.toRadixString(2);
        case 'Octal - OCT':
          return value.toRadixString(8);
        case 'Décimal - DEC':
          return value.toString();
        case 'Hexadécimal - HEX':
          return (value.toRadixString(16)).toUpperCase();
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
                    inRes = int.parse(val);
                    fromInToOut();
                  });
                },
                controller: inController,
                decoration: new InputDecoration(labelText: "Valeur Entrante: "),
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
                    outRes = int.parse(val);
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
