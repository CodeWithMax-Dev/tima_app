import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:tima_app/app/core/constants/apiUrlConst.dart';
import 'package:tima_app/app/router/routes/routerConst.dart';

class LoginRepo {
  // final String baseUrl;

  // ApiService({required this.baseUrl});

  Future<void> loginUser({
    String? email,
    required String mobile,
    required String password,
    context,
  }) async {
    final url = Uri.parse(login_url);
    final Map<String, dynamic> requestBody = {
      'mobile': mobile,
      'password': password,
    };

    if (email != null && email.isNotEmpty) {
      requestBody['email'] = email;
    }

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final status = responseData['status'];
        final message = responseData['message'];

        // final prefs = await SharedPreferences.getInstance();
        // prefs.setString('apiResponse', response.body);

        if (status == 1) {
          // Navigate to Home Page
          GoRouter.of(context).goNamed(routerConst.navBar);
        } else if (status == 0) {
          // Show failure message
          _showDialog(context, 'Login Failed', message);
        } else if (status == 3) {
          // Show device-specific message
          _showDialog(context, 'Device Message', message);
        }
      } else {
        _showDialog(context, 'Error', 'Unknown Device');
      }
    } catch (error) {
      _showDialog(context, 'Error', 'An error occurred: $error');
    }
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
