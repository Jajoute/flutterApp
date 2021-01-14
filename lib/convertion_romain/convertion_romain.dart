import 'package:flutter/material.dart';

class ConvertionRomain extends StatefulWidget {
  final String title;

  ConvertionRomain(this.title);

  @override
  _ConvertionRomain createState() => _ConvertionRomain();
}

class _ConvertionRomain extends State<ConvertionRomain> {

  String inLabelValue, outLabelValue;
  TextEditingController inController, outController;

  int inRes;
  String outRes;

  @override
  void initState() {
    super.initState();
    inController = TextEditingController();
    outController = TextEditingController();
    inController.value = TextEditingValue();
    inRes = 0;
    outRes = '';
  }

  void fromInToOut() {
    //double resInCelsius = toCelsius(inRes, inLabelValue);
    outController.text = toRomain(inRes).toString();
    outRes = outController.text;
  }

  void fromOutToIn() {
    //double resInOctet = toCelsius(outRes, outLabelValue);
    inController.text = toNumber(outRes).toString();
    inRes = int.parse(inController.text);
  }


  String toRomain(int value) {
    int u, d, c, m = 0;

    var unit = ["","I","II","III","IV","V","VI","VII","VIII","IX"];
    var diz = ["","X","XX","XXX","XL","L","LX","LXX","LXXX","XC"];
    var cent = ["","C","CC","CCC","CD","D","DC","DCC","DCCC","CM"];
    var mil = ["","M","MM","MMM"];

    m = value ~/ 1000;
    c = (value ~/ 100) % 10;
    d = (value ~/ 10) % 10;
    u = value - (1000*m) - (100*c) - (10*d);

    return (mil[m]+cent[c]+diz[d]+unit[u]).trim();

  }

  int toNumber(String value) {
    int result = 0;

    var number = [];

    String cleanValue = value.trim();
    Map<String, int> romano = {
      'I': 1,
      'V': 5,
      'X': 10,
      'L': 50,
      'C': 100,
      'D': 500,
      'M': 1000,
    };

    for (int i = 0; i < cleanValue.length; i++){

      number.add(romano[cleanValue[i]]);
    }
    number.add(0);

    for (int j = 0; j < number.length-1; j++){
      print('start');
      print(j);
      if (number[j]>=number[j + 1]){

        result += number[j];
      }else result -= number[j];

      print('result :$result');

    }
    return result;

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
                    decoration:
                    new InputDecoration(labelText: "Chiffre"),
                  ),
                ),

                SizedBox(
                  width: 200,
                  height: 60,
                  child: TextField(
                    onChanged: (val) {
                      setState(() {
                        outRes = val;
                        fromOutToIn();
                      });
                    },
                    controller: outController,
                    decoration:
                    new InputDecoration(labelText: "Chiffre romain"),
                  ),
                ),
              ],
            )));
  }


}
