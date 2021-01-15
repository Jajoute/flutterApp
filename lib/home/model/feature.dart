import 'package:flutter/cupertino.dart';

class Feature {
  String _title;
  IconData _icon;
  Widget _page;
  TransitionType _transition;

  set transition(TransitionType value) {
    _transition = value;
  }

  set page(Widget value) {
    _page = value;
  }

  set title(String value) {
    _title = value;
  }

  set icon(IconData value) {
    _icon = value;
  }

  String get title => _title;
  IconData get icon => _icon;
  Widget get page => _page;
  TransitionType get transition => _transition;

  Feature(this._title, this._icon, this._page, this._transition);

  void navigateTo(BuildContext context) => Navigator.of(context)
      .push(createRouteTransition(child: _page, type: _transition));

////////////////////////////////////////////////////////////////////////////////
// NAVIGATION TRANSITION (slide, scale, fade)
////////////////////////////////////////////////////////////////////////////////
  Route createRouteTransition(
      {@required Widget child, @required TransitionType type}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (type) {
          case TransitionType.slide:
            var begin = Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.decelerate;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          case TransitionType.scale:
            var begin = 0.0;
            var end = 1.0;
            var curve = Curves.bounceInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return ScaleTransition(
              scale: animation.drive(tween),
              child: child,
            );
          default:
            var begin = 0.0;
            var end = 1.0;
            var curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
        }
      },
    );
  }
}

enum TransitionType { slide, fade, scale }
