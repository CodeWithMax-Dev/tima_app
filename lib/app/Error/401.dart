import 'package:flutter/material.dart';

import 'package:tima_app/app/core/constants/textconst.dart';

class Error401Page extends StatelessWidget {
  const Error401Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            txtHelper().heading1Text('401', 25, Colors.black),
            txtHelper().heading1Text(
              'This page is not working',
              20,
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
