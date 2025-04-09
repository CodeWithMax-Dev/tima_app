// ignore_for_file: unused_field, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:tima_app/app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/app/DataBase/keys/keys.dart';
import 'package:tima_app/app/core/GWidgets/toast.dart';
import 'package:tima_app/app/core/constants/apiUrlConst.dart';
import 'package:tima_app/app/feature/Auth/forgotPassword/screen/forgotPassword.dart';
import 'package:tima_app/app/feature/NavBar/home/homeNavBar.dart';

abstract class ForgotPasswordController extends State<ForgotPasswordScreen> {
  final SecureStorageService _secureStorageService = SecureStorageService();
  dynamic isLoggedIn;
  final httpClient = http.Client();

  final existingPassController = TextEditingController();
  final newPassController = TextEditingController();
  final rePassController = TextEditingController();

  GlobalKey<FormState> changePassKey = GlobalKey<FormState>();
  bool existingPassVisible = true;
  bool newpasswordVisible = true;
  bool confirmpasswordVisible = true;
  bool isloading = false;
  bool errorcurrentpass = true,
      errornewpassword = true,
      errorExistingPassword = true,
      errorconfirmpassword = true;

  Future<void> resetUserPassword() async {
    String? userId = await _secureStorageService.getUserID(
      key: StorageKeys.userIDKey,
    );
    log(userId.toString());
    log('Your UserID--> ${userId.toString()}');
    if (userId == null || userId.isEmpty) {
      toastMsg('User ID not found', true);
      return;
    }
    try {
      final url = Uri.parse(cp_url);
      var body = ({
        'user_id': userId.toString(),
        'existing_password': existingPassController.text,
        'password': newPassController.text,
        're_password': rePassController.text,
      });

      var response = await httpClient.post(url, body: body);
      var cpDecodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        log('Reset Password Success: ${cpDecodedResponse.toString()}');
        toastMsg(cpDecodedResponse['message'].toString(), false);
        if (cpDecodedResponse['message'] == 'Password Successfully Changed') {
          QuickAlert.show(
            context: context,
            title: 'Change Password',
            type: QuickAlertType.success,
            text: cpDecodedResponse['message'],
            confirmBtnText: 'okey',
            confirmBtnColor: Colors.green,
          );
        } else {
          QuickAlert.show(
            context: context,
            title: 'Change Password',
            type: QuickAlertType.error,
            text: cpDecodedResponse['message'],
            confirmBtnText: 'okey',
            confirmBtnColor: Colors.red,
          );
        }
        // GoRouter.of(context).goNamed(routerConst.navBar);
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => HomeNavBar()));
      } else if (response.statusCode == 401) {
        toastMsg('Unauthorized access', false);
      } else {
        toastMsg('Something went wrong', true);
      }
    } on TimeoutException catch (e) {
      toastMsg('Request timeout, please try again', true);
      log('TimeoutException: $e');
    } on SocketException catch (e) {
      toastMsg('No internet connection, please try again', true);
      log('SocketException: $e');
    } catch (e) {
      log('Exception: $e');
    }
  }
}
