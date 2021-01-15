import 'package:flutter/material.dart';



class ConvertionAires extends StatefulWidget {

  final String title;
  ConvertionAires(this.title);

  @override
  _ConvertionAires createState() => _ConvertionAires();
}

class _ConvertionAires extends State<ConvertionAires> {
  String inLabelValue, outLabelValue;
  List<String> labels =['cm²','m²','km²','hectare','acre'];
  TextEditingController inController, outController;
  double inRes, outRes;

  @override
  void initState() {
    super.initState();
    inLabelValue = labels[0];
    outLabelValue = labels[1];
    inController = TextEditingController();
    outController = TextEditingController();
    inRes = 0;
    outRes = 0;
  }

  void fromInToOut() {
    double resInOctet = toMeter(inRes, inLabelValue);
    outController.text = toConvert(resInOctet, outLabelValue).toString();
    outRes = double.parse(outController.text);
  }

  void fromOutToIn() {
    double resInOctet = toMeter(outRes, outLabelValue);
    inController.text = toConvert(resInOctet, inLabelValue).toString();
    inRes = double.parse(inController.text);
  }

  double toMeter(double entryValue, String label) {
    if (entryValue != null) {
      switch (label) {
        case "km²": return entryValue * 1000000;
        case "m²": return entryValue;
        case "cm²": return entryValue * 0.001;
        case "hectare": return entryValue * 10000;
        case "acre": return entryValue * 4046.85642;
      }
    }
  }

  double toConvert(double result, String label) {
    if (result != null){
      switch (label) {
        case "km²": return result * 0.000001;
        case "m²": return result;
        case "cm²": return result * 1000;
        case "hectare": return result * 0.00010;
        case "acre": return result * 0.00025;
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
          children: <Widget>[
//////////////////////////////////////////////////////
//DROP DOWN BUTTON WITH INPUT VALUE
/////////////////////////////////////////////////////
            DropdownButton(
              value : inLabelValue,
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
//////////////////////////////////////////////////////
//TEXT FIELD WITH INPUT VALUE
/////////////////////////////////////////////////////
            SizedBox(
              width: 200,
              height: 60,
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Valeur à convertir'
                ),
                onChanged: (v){
                  setState(() {
                    inRes = double.parse(v);
                    fromInToOut();
                  });
                },
                controller: inController,
              ),
            ),
//////////////////////////////////////////////////////
//DROP DOWN BUTTON WITH INPUT VALUE
/////////////////////////////////////////////////////
            DropdownButton(
              value : outLabelValue,
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
//////////////////////////////////////////////////////
//TEXT FIELD WITH OUTPUT VALUE
/////////////////////////////////////////////////////
            SizedBox(
              width: 200,
              height: 60,
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Résultat'
                ),
                onChanged: (v){
                  setState(() {
                    outRes = double.parse(v);
                    fromOutToIn();
                  });
                },
                controller: outController,
              ),
            ),

          ],

        ),
      ),
    );
  }
}
