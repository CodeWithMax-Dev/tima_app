import 'package:flutter/material.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';

class customTxtField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const customTxtField({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: seconderyColor.withOpacity(.6),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(border: InputBorder.none, hintText: hint),
      ),
    );
  }
}
