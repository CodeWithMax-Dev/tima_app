// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tima_app/app/core/GWidgets/textfieldsStyle.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';
import 'package:tima_app/app/core/constants/formValidation.dart';
import 'package:tima_app/app/core/constants/textconst.dart';
import 'package:tima_app/app/feature/Auth/forgotPassword/builder/forgotPassController.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ForgotPasswordController {
  @override
  void dispose() {
    newPassController.dispose();
    rePassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: txtHelper().heading1Text('CHANGE PASSWORD', 20, Colors.white),
          backgroundColor: blueColor,
        ),
        backgroundColor: Colors.white,
        body:
            isloading
                ? const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator.adaptive(),
                )
                : Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 60,
                      child: Container(
                        height: 120,
                        width: 100,
                        color: blueColor,
                      ),
                    ),
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(70),
                        ),
                        color: blueColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                        alignment: Alignment.center,
                        height: double.infinity,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(70),
                          ),
                          color: Colors.white,
                        ),
                        child: SingleChildScrollView(
                          child: Form(
                            key: changePassKey,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    txtHelper().heading1Text(
                                      'CHANGE PASSWORD',
                                      23,
                                      blueColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Existing Password',
                                      style: GoogleFonts.aBeeZee(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: blueColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: tfColor,
                                  ),
                                  width: size.width,
                                  child: TextFormField(
                                    controller: existingPassController,
                                    validator:
                                        form_validation.validatenewpassword,
                                    obscureText: existingPassVisible,
                                    decoration: InputDecoration(
                                      border: boarder,
                                      focusedBorder: focusboarder,
                                      errorBorder: errorboarder,
                                      hintText: "Existing Password",
                                      prefixIcon: const Icon(Icons.password),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            existingPassVisible =
                                                !existingPassVisible;
                                          });
                                        },
                                        icon: Icon(
                                          existingPassVisible
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                      ),
                                    ),
                                    onChanged: (text) {
                                      setState(() {
                                        if (text.isEmpty) {
                                          errorExistingPassword = true;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'New Password',
                                      style: GoogleFonts.aBeeZee(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: blueColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: tfColor,
                                  ),
                                  width: size.width,
                                  child: TextFormField(
                                    controller: newPassController,
                                    validator:
                                        form_validation.validatenewpassword,
                                    obscureText: newpasswordVisible,
                                    decoration: InputDecoration(
                                      border: boarder,
                                      focusedBorder: focusboarder,
                                      errorBorder: errorboarder,
                                      hintText: "New Password",
                                      prefixIcon: const Icon(Icons.password),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            newpasswordVisible =
                                                !newpasswordVisible;
                                          });
                                        },
                                        icon: Icon(
                                          newpasswordVisible
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                      ),
                                    ),
                                    onChanged: (text) {
                                      setState(() {
                                        if (text.isEmpty) {
                                          errornewpassword = true;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Confirm Password',
                                      style: GoogleFonts.aBeeZee(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: blueColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: tfColor,
                                  ),
                                  width: size.width,
                                  child: TextFormField(
                                    controller: rePassController,
                                    obscureText: confirmpasswordVisible,
                                    decoration: InputDecoration(
                                      border: boarder,
                                      focusedBorder: focusboarder,
                                      errorBorder: errorboarder,
                                      hintText: "Confirm Password",
                                      prefixIcon: const Icon(Icons.password),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            confirmpasswordVisible =
                                                !confirmpasswordVisible;
                                          });
                                        },
                                        icon: Icon(
                                          confirmpasswordVisible
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                      ),
                                    ),
                                    onChanged: (text) {
                                      setState(() {
                                        if (text.isNotEmpty) {
                                          errornewpassword = true;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 30),
                                GestureDetector(
                                  onTap: () {
                                    resetUserPassword();
                                    // if (changePassKey.currentState!.validate()) {

                                    // }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    height: 50,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: blueColor,
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Confirm',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 120.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 10,
                    //   left: 10,
                    //   child: Container(
                    //     height: 50,
                    //     width: 50,
                    //     decoration: const BoxDecoration(
                    //         shape: BoxShape.circle, color: Colors.white),
                    //     child: IconButton(
                    //       icon: const Icon(
                    //         Icons.arrow_back_ios_new,
                    //         color: blueColor,
                    //       ),
                    //       onPressed: () {
                    //         GoRouter.of(context).goNamed(routerConst.loginScreen);
                    //       },
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      top: 10,
                      left: 140,
                      child: txtHelper().heading1Text('TIMA', 27, Colors.white),
                    ),
                  ],
                ),
      ),
    );
  }
}
