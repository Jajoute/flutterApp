import 'dart:math';

import 'package:flutter/material.dart';

class DatePage extends StatefulWidget {
  final String title;

  DatePage(this.title);

  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  Duration _dateTime;
  DateTime _firstDate;
  DateTime _secondDate;
  DateTime _start;
  String message = "";
  bool dateTest;
  int firstmonth;
  int firstyear;
  int secondmonth;
  int secondyear;
  int firstday;
  int secondday;
  int month;
  int year;
  int day;
  double resultat;

  void secondAfter(DateTime date1, DateTime date2) {
    _dateTime = date1.difference(date2);
    day = _dateTime.inDays;

    year = (day / 365).toInt();
    resultat = (day / 365);
    resultat = resultat - resultat.truncate(); //prendre partie décimale
    month = (resultat * 12).toInt();
    resultat = (resultat * 12);
    resultat = resultat - resultat.truncate(); //prendre partie décimale
    day = (resultat * 31).toInt();
    message =
        'La différence est de ${year} année(s) ${month} mois ${day} jour(s)';
  }

  void difference() {
    if (_firstDate == null || _secondDate == null) {
      message = 'Select 2 date';
    } else {
      dateTest = _firstDate.isBefore(_secondDate);
      if (dateTest == true) {
        secondAfter(_secondDate, _firstDate);
      } else {
        secondAfter(_firstDate, _secondDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Date"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(child: Text(message)),
          SizedBox(
            width: 200,
            height: 60,
            child: RaisedButton(
                child: Text(_firstDate == null
                    ? 'firstDate'
                    : '${_firstDate.year}:${_firstDate.month}:${_firstDate.day}'),
                elevation: 8.0,
                onPressed: () async {
                  final a = await showDatePicker(
                      //on affiche le DatePicker
                      context: context,
                      initialDate: _start == null ? DateTime.now() : _start,
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2230));
                  setState(() {
                    _firstDate = a;
                  });
                }),
          ),
          SizedBox(
            width: 200,
            height: 60,
            child: RaisedButton(
                child: Text(_secondDate == null
                    ? 'secondDate'
                    : '${_secondDate.year}:${_secondDate.month}:${_secondDate.day}'),
                elevation: 8.0,
                onPressed: () async {
                  final a = await showDatePicker(
                      //on affiche le DatePicker
                      context: context,
                      initialDate: _start == null ? DateTime.now() : _start,
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2230));
                  setState(() {
                    _secondDate = a;
                  });
                }),
          ),
          SizedBox(
            width: 200,
            height: 60,
            child: RaisedButton(
              child: Text('valider'),
              elevation: 8.0,
              onPressed: () {
                setState(() {
                  difference();
                });
              },
            ),
          ),
        ],
      )),
    );
  }
}
//'${_dateTime.year.toString()}:${_dateTime.month.toString()}:${_dateTime.day.toString()}';
