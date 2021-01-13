import 'package:flutter/material.dart';

class DatePage extends StatefulWidget {
  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  Duration _dateTime;
  DateTime _firstDate;
  DateTime _secondDate;
  String message="";
  bool dateTest;

  void difference(){
    if(_firstDate==null || _secondDate==null){
      message='Select 2 date';
    }else{
      dateTest=_firstDate.isBefore(_secondDate);
      if(dateTest==true){
        _dateTime=_secondDate.difference(_firstDate);
        message='La différence est de ${_dateTime.inHours.toString()} heure';
      }else{
        _dateTime=_firstDate.difference(_secondDate);
        message='La différence est de ${_dateTime.inHours.toString()} heure';
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
          Text(message),
          RaisedButton(
            child: Text('firstDate'),
            elevation: 8.0,
            onPressed: ()async{
              final a =
             await showDatePicker( //on affiche le DatePicker
                  context: context,
                  initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2230)
              );
              setState(() {
                _firstDate=a;
              });
            }),
          RaisedButton(
              child: Text('secondDate'),
              elevation: 8.0,
              onPressed: ()async{
                final a =
                await showDatePicker( //on affiche le DatePicker
                    context: context,
                    initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                    firstDate: DateTime(2001),
                    lastDate: DateTime(2230)
                );
                setState(() {
                  _secondDate=a;
                });
              }),
          RaisedButton(
            child: Text('valider'),
            elevation: 8.0,
            onPressed: (){
              setState(() {
                difference();
              });
            },
          ),
        ],
      )),
    );
  }
}
//'${_dateTime.year.toString()}:${_dateTime.month.toString()}:${_dateTime.day.toString()}';