import 'package:flutter/material.dart';
import 'dart:math' as math;

class ConvertionInformatique extends StatefulWidget {
  String title;

  ConvertionInformatique(this.title);

  @override
  _ConvertionInformatique createState() => _ConvertionInformatique();
}

class _ConvertionInformatique extends State<ConvertionInformatique> {
  String labelToConvert = 'Octet - O', labelConvert = 'Kilooctet - KO';
  double valueToConvert, valueConvert, valueOctet;
  TextEditingController textToConvert, textConvert;

  /*
  @override
  void initState() {
    textToConvert = TextEditingController();
    textConvert = TextEditingController();
    super.initState();
  }
  */



  double _toConvert(double valueToConvert) {
    valueOctet = valueToConvert;
    switch (labelToConvert) {
      case 'Octet - O':
        break;

      case 'Kilooctet - KO':
        valueOctet = valueToConvert * math.pow(10, 3);
        break;

      case 'Mégaoctet - MO':
        valueOctet = valueToConvert * math.pow(10, 6);
        break;

      case 'Gigaoctet - GO':
        valueOctet = valueToConvert * math.pow(10, 9);
        break;

      case 'Téraoctet - TO':
        valueOctet = valueToConvert * math.pow(10, 12);
        break;

      case 'Pétaoctet - PO':
        valueOctet = valueToConvert * math.pow(10, 15);
        break;

      default:
        print("Invalid choice");
        break;
    }
    switch (labelConvert) {
      case 'Octet - O':
        return valueOctet;

      case 'Kilooctet - KO':
        return valueOctet / math.pow(10, 3);

      case 'Mégaoctet - MO':
        return valueOctet / math.pow(10, 6);

      case 'Gigaoctet - GO':
        return valueOctet / math.pow(10, 9);

      case 'Téraoctet - TO':
        return valueOctet / math.pow(10, 12);

      case 'Pétaoctet - PO':
        return valueOctet / math.pow(10, 15);

      default:
        return 0;
    }
  }

  double _convert(double valueConvert) {
    valueOctet = valueConvert;
    switch (labelConvert) {
      case 'Octet - O':
        break;

      case 'Kilooctet - KO':
        valueOctet = valueConvert * math.pow(10, 3);
        break;

      case 'Mégaoctet - MO':
        valueOctet = valueConvert * math.pow(10, 6);
        break;

      case 'Gigaoctet - GO':
        valueOctet = valueConvert * math.pow(10, 9);
        break;

      case 'Téraoctet - TO':
        valueOctet = valueConvert * math.pow(10, 12);
        break;

      case 'Pétaoctet - PO':
        valueOctet = valueConvert * math.pow(10, 15);
        break;

      default:
        print("Invalid choice");
        break;
    }
    switch (labelToConvert) {
      case 'Octet - O':
        return valueOctet;

      case 'Kilooctet - KO':
        return valueOctet / math.pow(10, 3);

      case 'Mégaoctet - MO':
        return valueOctet / math.pow(10, 6);

      case 'Gigaoctet - GO':
        return valueOctet / math.pow(10, 9);

      case 'Téraoctet - TO':
        return valueOctet / math.pow(10, 12);

      case 'Pétaoctet - PO':
        return valueOctet / math.pow(10, 15);

      default:
        return 0;
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
              value: labelToConvert,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.blue),
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (String valueToC) {
                setState(() {
                  labelToConvert = valueToC;
                });
              },
              items: <String>[
                'Octet - O',
                'Kilooctet - KO',
                'Mégaoctet - MO',
                'Gigaoctet - GO',
                'Téraoctet - TO',
                'Pétaoctet - PO'
              ].map<DropdownMenuItem<String>>((String value) {
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
                onChanged: (String valueToC) {
                  setState(() {
                    print(_toConvert(double.parse(valueToC)).toString());
                    textConvert.text = _toConvert(double.parse(valueToC)).toString();
                    print(textConvert.text);
                    textToConvert.selection = TextSelection.fromPosition(TextPosition(offset: textToConvert.text.length));
                  });
                },
                controller:textToConvert,
                decoration: new InputDecoration(labelText: "Valeur Entrante:"),
              ),
            ),

            //Menu déroulant des valeurs sortantes
            DropdownButton<String>(
              value: labelConvert,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.blue),
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (String valueC) {
                setState(() {
                  labelConvert = valueC;
                });
              },
              items: <String>[
                'Octet - O',
                'Kilooctet - KO',
                'Mégaoctet - MO',
                'Gigaoctet - GO',
                'Téraoctet - TO',
                'Pétaoctet - PO'
              ].map<DropdownMenuItem<String>>((String value) {
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
                onChanged: (String valueC) {
                  setState(() {
                    textToConvert.text = _convert(double.parse(valueC)).toString();
                    textConvert.selection = TextSelection.fromPosition(TextPosition(offset: textConvert.text.length));
                  });
                },
                controller:textConvert,
                decoration: new InputDecoration(labelText: "Valeur Sortante:"),
              ),
            ),
          ],
        )));
  }
}
