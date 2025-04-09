import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';

class ApiBaseHelper {
  Future<Response> postAPICall(Uri url, body) async {
    // ignore: unused_local_variable
    var headers = {
      // 'Content-Type': 'application/json',
    };
    log("url -> ${url.toString()}");
    log("body -> ${body.toString()}");
    try {
      final response =
          await post(url, body: body).timeout(const Duration(seconds: 10));
      log("Response -> ${response.body.toString()}");
      return response;
    } on SocketException {
      rethrow;
    }
  }
}
