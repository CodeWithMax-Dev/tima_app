import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tima_app/app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/app/DataBase/keys/keys.dart';
import 'package:tima_app/app/core/constants/apiUrlConst.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';
import 'package:tima_app/app/feature/Auth/loginPages/screen/loginPage.dart';
import 'package:tima_app/app/feature/NavBar/home/homeNavBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  final SecureStorageService _secureStorageService = SecureStorageService();
  bool isLoggedIn = false;
  late var userID;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    injectUserIDs();
    checkLoginStatus();
  }

  Future<void> sendUserAppStatusToServer(var appStatus) async {
    String? userId = await _secureStorageService.getUserData(
      key: StorageKeys.userIDKey,
    );
    setState(() {
      userID = userId;
    });

    final url = Uri.parse(set_user_app_status_url);
    var body = jsonEncode({"user_id": userID, "app_status": appStatus});

    await ApiBaseHelper().postAPICall(url, body);
  }

  Future<void> didChangeAppLifeCycleState(AppLifecycleState state) async {
    var appStatus = "";
    if (state == AppLifecycleState.detached) {
      appStatus = 'logout';
      log("Detached Home your app here Dashboard");
      sendUserAppStatusToServer(appStatus);
    }
    if (state == AppLifecycleState.resumed) {
      appStatus = 'active';
      log("Resume Home your app here Dashboard");
      sendUserAppStatusToServer(appStatus);
    }
  }

  void openUserGmail() {
    const intent = AndroidIntent(
      action: 'android.intent.action.SEND',
      arguments: {'android.intent.extra.SUBJECT': 'I am the subject'},
      arrayArguments: {
        'android.intent.extra.EMAIL': ['eidac@me.com', 'overbom@mac.com'],
        'android.intent.extra.CC': ['john@app.com', 'user@app.com'],
        'android.intent.extra.BCC': ['liam@me.abc', 'abel@me.com'],
      },
      package: 'com.google.android.gm',
      type: 'message/rfc822',
    );
    intent.launch();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool(StorageKeys.loginKey) ?? false;

    Timer(const Duration(seconds: 3), () {
      if (isLoggedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeNavBar()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const PhoneEmailLogin()),
        );
      }
    });
  }

  injectUserIDs() async {
    setState(() {
      _secureStorageService.getUserID(key: StorageKeys.userIDKey);
      _secureStorageService.getUserName(key: StorageKeys.NameKey);
      _secureStorageService.getUserMobile(key: StorageKeys.mobileKey);
      _secureStorageService.getUserEmailID(key: StorageKeys.emailKey);
      _secureStorageService.getUserBranchID(key: StorageKeys.branchKey);
      _secureStorageService.getUserCompanyID(key: StorageKeys.companyIdKey);
      _secureStorageService.getUserCategory(key: StorageKeys.userCategory);
      _secureStorageService.getCategoryName(key: StorageKeys.categoryNameKey);
      _secureStorageService.getUserLogInToken(key: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, // 5% of screen width
          vertical: screenHeight * 0.02, // 2% of screen height
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/timalogo.jpeg',
              height: screenHeight * 0.3, // 30% of screen height
              width: screenWidth,
              fit: BoxFit.contain,
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'VERSION 1.0',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: colorConst.primarycolor,
              ),
            ),
            // SizedBox(height: screenHeight * 0.02),
            // SizedBox(
            //   width: screenWidth * 0.15,
            //   height: screenWidth * 0.15,
            //   child: CircularProgressIndicator(
            //     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            //     strokeWidth: screenWidth * 0.01,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
