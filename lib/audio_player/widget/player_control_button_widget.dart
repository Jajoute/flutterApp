import 'package:flutter/material.dart';

class PlayerControlButtonWidget extends StatefulWidget {
  final Function() onPressed;
  final bool isTrue;
  final IconData trueIcon;
  final IconData falseIcon;

  PlayerControlButtonWidget({
    @required this.onPressed,
    @required this.isTrue,
    @required this.trueIcon,
    @required this.falseIcon,
  });

  @override
  _PlayerControlButtonWidgetState createState() => _PlayerControlButtonWidgetState();
}

class _PlayerControlButtonWidgetState extends State<PlayerControlButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        width: 70,
        height: 70,
        child: TextButton(
            onPressed: widget.onPressed,
            child: Icon(
              widget.isTrue ? widget.trueIcon : widget.falseIcon,
              color: Colors.white,
              size: 50,
            )),
      ),
    );
  }
}
