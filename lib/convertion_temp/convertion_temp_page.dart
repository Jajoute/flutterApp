import 'package:flutter/material.dart';

class ConvertionTempPage extends StatefulWidget {
  final String title;

  ConvertionTempPage(this.title);

  @override
  _ConvertionTempPage createState() => _ConvertionTempPage();
}

class _ConvertionTempPage extends State<ConvertionTempPage> {
  String inLabelValue, outLabelValue;
  TextEditingController inController, outController;
  double inRes, outRes;

  List<String> labels = [
    'Celsius',
    'Fahrenheit',
    'Kelvin',
  ];

  @override
  void initState() {
    super.initState();
    inLabelValue = labels[0];
    outLabelValue = labels[1];
    inController = TextEditingController();
    outController = TextEditingController();
    inController.value = TextEditingValue();
    inRes = 0;
    outRes = 0;
  }

  void fromInToOut() {
    double resInCelsius = toCelsius(inRes, inLabelValue);
    outController.text = toConvert(resInCelsius, outLabelValue).toString();
    outRes = double.parse(outController.text);
  }

  void fromOutToIn() {
    double resInOctet = toCelsius(outRes, outLabelValue);
    inController.text = toConvert(resInOctet, inLabelValue).toString();
    inRes = double.parse(inController.text);
  }

  double toCelsius(double value, String label) {
    if (value != null) {
      switch (label) {
        case 'Celsius':
          return value;
        case 'Fahrenheit':
          return (value - 32) * 5/9;
        case 'Kelvin':
          return value - 273.15;
      }
    }
  }

  double toConvert(double value, String label) {
    if (value != null) {
      switch (label) {
        case 'Celsius':
          return value;
        case 'Fahrenheit':
          return (value * 9/5) + 32;
        case 'Kelvin':
          return value + 273.15;
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
//////////////////////////////////////////////////////
//DROP DOWN BUTTON FOR INPUT VALUE
/////////////////////////////////////////////////////
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
//////////////////////////////////////////////////////
//TEXT FIELD FOR INPUT VALUE
/////////////////////////////////////////////////////
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
                    new InputDecoration(labelText: "$inLabelValue"),
                  ),
                ),
//////////////////////////////////////////////////////
//DROP DOWN BUTTON FOR OUTPUT VALUE
/////////////////////////////////////////////////////
                DropdownButton<String>(
                  value: outLabelValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  autofocus: true,
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
//TEXT FIELD WITH NUMBER
///////////////////////////////////////////////////// 
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
                    new InputDecoration(labelText: "$outLabelValue"),
                  ),
                ),
              ],
            )));
  }


}
