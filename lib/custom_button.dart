import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const CustomButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.blueGrey,
      splashColor: Colors.black26,
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          text,
          maxLines: 1,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
