import 'package:flutter/material.dart';

class RadiusButton extends StatelessWidget {
  final Function() action;
  final String text;
  final Color color;

  const RadiusButton(this.text, this.action, this.color, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MaterialButton(
        onPressed: action,
        height: 45,
        color: color,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
