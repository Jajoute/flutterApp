import 'package:flutter/cupertino.dart';

class Feature{
  String _title;
  IconData _icon;

  set title(String value) {
    _title = value;
  }
  set icon(IconData value) {
    _icon = value;
  }

  String get title => _title;
  IconData get icon => _icon;


  Feature(this._title, this._icon);


  void navigateTo(BuildContext context) => Navigator.pushNamed(context, '/${title.toLowerCase()}');
}