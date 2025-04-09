// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double radius;
  Color? color;
  double? fontSize;
  CustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.radius,
      this.color,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)),
            backgroundColor: color),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: fontSize),
        ));
  }
}
