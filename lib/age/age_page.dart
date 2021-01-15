import 'package:flutter/material.dart';

class AgePage extends StatefulWidget {
  final String title;
  AgePage(this.title);
  @override
  _AgePageState createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  //////////////////////////////////////////////////////////////////////////////
  // Create variable
  //////////////////////////////////////////////////////////////////////////////
  Duration _dateTime;
  DateTime _firstDate;
  DateTime _temporaire;
  DateTime _start;
  String message="";
  String messageSecond="";
  String messageTrois="";
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

  //////////////////////////////////////////////////////////////////////////////
  // methode to calcul birthday
  //////////////////////////////////////////////////////////////////////////////
  void secondAfter(DateTime date1,DateTime date2,int N){
      _dateTime=date1.difference(date2);
      day=_dateTime.inDays;

      year=(day/365).toInt();
      resultat=(day/365);
      resultat = resultat - resultat.truncate();//prendre partie décimale
      month=(resultat*12).toInt();
      resultat=(resultat*12);
      resultat = resultat - resultat.truncate();//prendre partie décimale
      day=(resultat*31).toInt();
      if(N==1){
        message='Le temps vécu est de ${year} année(s), ${month} mois et ${day} jour(s)';
        messageSecond="";
        messageTrois="";
      }
      if(N==2){
        if(month<0){
          month=month*(-1);
        }if(day<0){
          day=day*(-1);
        }
        messageSecond='Le prochain anniversaire est dans ${month} mois et ${day} jour(s)';
        message="";
        messageTrois="";
      }
      if(N==3){
        month=(_dateTime.inDays/31).toInt();
        messageTrois='La différence est de  ${month} mois ou ${_dateTime.inDays} jour(s) ou ${_dateTime.inHours} heure(s)';
        messageSecond="";
        message="";

      }

  }
  void difference(int n){
    if(_firstDate==null){
      message='Select 2 date';
    }else{
        if(n==1){
          secondAfter(DateTime.now(), _firstDate, 1);
        }
        if(n==2){
          //messageSecond="jjjj ${DateTime.now().add(Duration(days: 365))}";
          if(_firstDate.year==DateTime.now().year){
            _temporaire=new DateTime(DateTime.now().year+1, _firstDate.month, _firstDate.day);
          }
          else{
            _temporaire=new DateTime(DateTime.now().year, _firstDate.month, _firstDate.day);
          }
          secondAfter(_temporaire, DateTime.now(),2);
        }
        if(n==3){
          secondAfter(DateTime.now(), _firstDate, 3);
        }
    }
  }

  //////////////////////////////////////////////////////////////////////////////
  //UI
  //////////////////////////////////////////////////////////////////////////////
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
            SizedBox(child: Text(message)),
            SizedBox(child: Text(messageSecond)),
            SizedBox(child: Text(messageTrois)),
            SizedBox(
              width: 200,
              height: 60,
              child: RaisedButton(
                  child: Text(_firstDate==null?'aucune date':'${_firstDate.year}:${_firstDate.month}:${_firstDate.day}'),
                  elevation: 8.0,
                  onPressed: ()async{
                    final a =
                    await showDatePicker( //on affiche le DatePicker
                        context: context,
                        initialDate: _start == null ? DateTime.now() : _start,
                        firstDate: DateTime(2001),
                        lastDate: DateTime.now()
                    );
                    setState(() {
                      _firstDate=a;
                    });
                  }),
            ),
            SizedBox(
              width: 200,
              height: 60,
              child: RaisedButton(
                child: Text('Temps vécu'),
                elevation: 8.0,
                onPressed: (){
                  setState(() {
                    difference(1);
                  });
                },
              ),
            ),
            SizedBox(
              width: 200,
              height: 60,
              child: RaisedButton(
                child: Text('Prochain anniversaire'),
                elevation: 8.0,
                onPressed: (){
                  setState(() {
                    difference(2);
                  });
                },
              ),
            ),
            SizedBox(
              width: 200,
              height: 60,
              child: RaisedButton(
                child: Text('Mois, jour, heure vécus'),
                elevation: 8.0,
                onPressed: (){
                  setState(() {
                    difference(3);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//flutter config --enable-macos-desktop
//flutter create .
//flutter run -d macos