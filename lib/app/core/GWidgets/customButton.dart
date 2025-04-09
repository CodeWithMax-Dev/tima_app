// ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types, must_be_immutable
import 'package:flutter/material.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';

class appButton extends StatelessWidget {
  VoidCallback onPressed;
  final String text;
  double height;
  double width;
  appButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: blueColor,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
