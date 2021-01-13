import 'package:flutter/material.dart';

class ConvertionTemp extends StatefulWidget {
  final String title;

  ConvertionTemp(this.title);

  @override
  _ConvertionTemp createState() => _ConvertionTemp();
}

class _ConvertionTemp extends State<ConvertionTemp> {
  List<String> labels = [
    'Celsius',
    'Fahrenheit',
    'Kelvin',
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
                    new InputDecoration(labelText: "$inLabelValue"),
                  ),
                ),

                //Menu déroulant des valeurs sortantes
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
                    new InputDecoration(labelText: "$outLabelValue"),
                  ),
                ),
              ],
            )));
  }


}
