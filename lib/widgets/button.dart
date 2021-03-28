import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final VoidCallback buttonFunction;

  const Button(
      {Key key, this.buttonText, this.buttonColor, this.buttonFunction})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      height: 60,
      width: 400,
      child: ElevatedButton(
        child: Text(buttonText),
        onPressed: buttonFunction,
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
