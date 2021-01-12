import 'package:flutter/cupertino.dart';

class Feature{
  String _title;

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  IconData _icon;
  Function() _destination;

  Feature(this._title, this._icon, this._destination);

  IconData get icon => _icon;

  set icon(IconData value) {
    _icon = value;
  }

  Function get destination => _destination;

  set destination(Function value) {
    _destination = value;
  }
}