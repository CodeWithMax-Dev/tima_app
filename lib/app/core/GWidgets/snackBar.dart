import 'package:flutter/material.dart';

customSnackBar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(duration: const Duration(seconds: 2), content: Text(message)));
}
