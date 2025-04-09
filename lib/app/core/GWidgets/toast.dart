import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> toastMsg(var msg, bool iserror) {
  var Msg = Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: iserror == true ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
  return Msg;
}


Future<void> appToastMsg(var msg) {
  var Msg = Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      // backgroundColor:Colors.grey.shade900,
      textColor: Colors.white,
      fontSize: 16.0);
  return Msg;
}

