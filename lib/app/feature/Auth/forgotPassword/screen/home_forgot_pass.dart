// ignore_for_file: prefer_final_fields, unused_field

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tima_app/app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/app/DataBase/keys/keys.dart';
import 'package:tima_app/app/core/GWidgets/toast.dart';
import 'package:tima_app/app/core/constants/apiUrlConst.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';
import 'package:tima_app/app/feature/NavBar/home/homeNavBar.dart';

class HomeForgotPass extends StatefulWidget {
  const HomeForgotPass({super.key});

  static const String routeName = '/home-forgot-pass-view';

  @override
  State<HomeForgotPass> createState() => _HomeForgotPassState();
}

class _HomeForgotPassState extends State<HomeForgotPass> {
  GlobalKey<FormState> changePassKey = GlobalKey<FormState>();
  bool _newpasswordVisible = true;
  bool _confirmpasswordVisible = true;
  bool isloading = false;
  bool errorcurrentpass = true,
      errornewpassword = true,
      errorconfirmpassword = true;

  SecureStorageService _secureStorageService = SecureStorageService();
  dynamic isLoggedIn;

  final httpClient = http.Client();

  final existingPassController = TextEditingController();
  final newPassController = TextEditingController();
  final rePassController = TextEditingController();

  bool existingPassVisible = true;
  bool newpasswordVisible = true;
  bool confirmpasswordVisible = true;
  bool errorExistingPassword = true;

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
        // QuickAlert.show(
        //   context: context,
        //   title: 'Change Password',
        //   type: QuickAlertType.success,
        //   text: cpDecodedResponse['message'],
        //   confirmBtnText: 'okey',
        //   confirmBtnColor: Colors.green,
        // );
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

  @override
  void dispose() {
    newPassController.dispose();
    rePassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      blueColor.withOpacity(0.1),
                      Colors.white,
                      blueColor.withOpacity(0.05),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Background design elements
                    Positioned(
                      top: -100,
                      right: -100,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              blueColor.withOpacity(0.2),
                              blueColor.withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -80,
                      left: -80,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              blueColor.withOpacity(0.2),
                              blueColor.withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Main Content
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.06,
                        vertical: constraints.maxHeight * 0.04,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Logo and Welcome Section
                          Hero(
                            tag: 'logo',
                            child: Container(
                              padding: EdgeInsets.all(
                                constraints.maxWidth * 0.04,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: blueColor.withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                'assets/timaApplogo.jpg',
                                height: constraints.maxHeight * 0.10,
                                width: constraints.maxWidth * 0.20,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.02),
                          Text(
                            'Change Password',
                            style: GoogleFonts.poppins(
                              fontSize: constraints.maxWidth * 0.07,
                              fontWeight: FontWeight.bold,
                              color: blueColor,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Enter your new password',
                            style: GoogleFonts.poppins(
                              fontSize: constraints.maxWidth * 0.035,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.03),

                          // Password Change Card
                          Container(
                            padding: EdgeInsets.all(
                              constraints.maxWidth * 0.05,
                            ),
                            margin: EdgeInsets.only(
                              bottom: constraints.maxHeight * 0.02,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                constraints.maxWidth * 0.05,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Form(
                              key: changePassKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildInputField(
                                    title: 'Current Password',
                                    hint: 'Enter your current password',
                                    controller: existingPassController,
                                    isPassword: true,
                                    obscureText: existingPassVisible,
                                    icon: Icons.lock_outline,
                                    constraints: constraints,
                                    suffixIcon: IconButton(
                                      onPressed:
                                          () => setState(() {
                                            existingPassVisible =
                                                !existingPassVisible;
                                          }),
                                      icon: Icon(
                                        existingPassVisible
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: blueColor,
                                        size: constraints.maxWidth * 0.05,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: isSmallScreen ? 12.h : 15.h),
                                  _buildInputField(
                                    title: 'New Password',
                                    hint: 'Enter your new password',
                                    controller: newPassController,
                                    isPassword: true,
                                    obscureText: newpasswordVisible,
                                    icon: Icons.lock_outline,
                                    constraints: constraints,
                                    suffixIcon: IconButton(
                                      onPressed:
                                          () => setState(() {
                                            newpasswordVisible =
                                                !newpasswordVisible;
                                          }),
                                      icon: Icon(
                                        newpasswordVisible
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: blueColor,
                                        size: constraints.maxWidth * 0.05,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: isSmallScreen ? 12.h : 15.h),
                                  _buildInputField(
                                    title: 'Confirm Password',
                                    hint: 'Confirm your new password',
                                    controller: rePassController,
                                    isPassword: true,
                                    obscureText: confirmpasswordVisible,
                                    icon: Icons.lock_outline,
                                    constraints: constraints,
                                    suffixIcon: IconButton(
                                      onPressed:
                                          () => setState(() {
                                            confirmpasswordVisible =
                                                !confirmpasswordVisible;
                                          }),
                                      icon: Icon(
                                        confirmpasswordVisible
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: blueColor,
                                        size: constraints.maxWidth * 0.05,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: isSmallScreen ? 20.h : 25.h),
                                  Container(
                                    width: double.infinity,
                                    height: constraints.maxHeight * 0.065,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          blueColor,
                                          blueColor.withOpacity(0.8),
                                          blueColor,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        constraints.maxWidth * 0.04,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: blueColor.withOpacity(0.3),
                                          spreadRadius: 0,
                                          blurRadius: 12,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: MaterialButton(
                                      onPressed: () {
                                        if (changePassKey.currentState!
                                            .validate()) {
                                          resetUserPassword();
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          constraints.maxWidth * 0.04,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Change Password',
                                            style: GoogleFonts.poppins(
                                              fontSize:
                                                  constraints.maxWidth * 0.045,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * 0.02,
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: constraints.maxWidth * 0.05,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String title,
    required String hint,
    required TextEditingController controller,
    required BoxConstraints constraints,
    bool isPassword = false,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: constraints.maxWidth * 0.035,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: constraints.maxHeight * 0.01),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter $title';
            }

            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            hintText: hint,
            prefixIcon: Container(
              margin: EdgeInsets.all(constraints.maxWidth * 0.02),
              padding: EdgeInsets.all(constraints.maxWidth * 0.02),
              decoration: BoxDecoration(
                color: blueColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                  constraints.maxWidth * 0.02,
                ),
              ),
              child: Icon(
                icon,
                color: blueColor,
                size: constraints.maxWidth * 0.05,
              ),
            ),
            suffixIcon: suffixIcon,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: constraints.maxWidth * 0.035,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(constraints.maxWidth * 0.04),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(constraints.maxWidth * 0.04),
              borderSide: BorderSide(color: blueColor, width: 1),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.04,
              vertical: constraints.maxHeight * 0.02,
            ),
          ),
        ),
      ],
    );
  }
}
