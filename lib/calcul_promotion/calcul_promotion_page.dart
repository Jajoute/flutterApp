import 'package:flutter/material.dart';

class CalculPromotionPage extends StatefulWidget {
  final String title;

  CalculPromotionPage(this.title);

  @override
  _CalculPromotion createState() => _CalculPromotion();
}

class _CalculPromotion extends State<CalculPromotionPage> {
  double inRes, inRes2, outRes, ecoValue;
  TextEditingController inController, inController2, outController;

  @override
  void initState() {
    super.initState();
    inController = TextEditingController();
    inController2 = TextEditingController();
    outController = TextEditingController();
  }

  //Call to change the outController value and ecoValue
  //When you enter your initial price and the promotion
  void fromInToOut() {
    if (inRes != null && inRes2 != null) {
      ecoValue = inRes * (inRes2 / 100);
      outController.text = (inRes - ecoValue).toString();
    }
  }

  //Call to change the inController value and ecoValue 
  //When you enter your final price and the promotion
  void fromOutToIn() {
    if (outRes != null && inRes2 != null) {
      inController.text = (outRes / (1 - (inRes2 / 100))).toString();
      ecoValue = double.parse(inController.text) - outRes;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 60,
                  //Initial price of the product
                  child: TextField(
                    onChanged: (val) {
                      setState(() {});
                      inRes = double.parse(val);
                      fromInToOut();
                    },
                    controller: inController,
                    decoration: new InputDecoration(labelText: "Prix initial:"),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 60,
                  //Percentage of the promotion
                  child: TextField(
                    onChanged: (val) {
                      setState(() {});
                      inRes2 = double.parse(val);
                      fromInToOut();
                    },
                    controller: inController2,
                    decoration:
                        new InputDecoration(labelText: "Réduction en %:"),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 60,
                  //Final price of the product
                  child: TextField(
                    onChanged: (val) {
                      setState(() {});
                      outRes = double.parse(val);
                      fromOutToIn();
                    },
                    controller: outController,
                    decoration: new InputDecoration(labelText: "Prix final:"),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 60,
                  child: Center(
                    //The money you saved with the promotion
                    child: Text("Économie réalisée: ${ecoValue ?? ""}"),
                  ),
                ),
              ],
            ),
          ],
        )));
  }
}
