import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';
import 'package:tima_app/app/feature/Auth/loginPages/controller/loginController.dart';

class PhoneEmailLogin extends StatefulWidget {
  const PhoneEmailLogin({super.key});

  @override
  State<PhoneEmailLogin> createState() => _PhoneEmailLoginState();
}

class _PhoneEmailLoginState extends LoginController {
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> mobileKey = GlobalKey<FormState>();
  GlobalKey<FormState> passKey = GlobalKey<FormState>();

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
                            'Welcome Back',
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
                            'Sign in to continue',
                            style: GoogleFonts.poppins(
                              fontSize: constraints.maxWidth * 0.035,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.03),

                          // Login Card
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
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildInputField(
                                  title: 'Email',
                                  hint: 'Enter your email',
                                  icon: Icons.email_outlined,
                                  controller: emailController,
                                  constraints: constraints,
                                ),
                                SizedBox(height: isSmallScreen ? 12.h : 15.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        color: blueColor.withOpacity(0.2),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: constraints.maxWidth * 0.04,
                                      ),
                                      child: Text(
                                        'OR',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              constraints.maxWidth * 0.035,
                                          color: blueColor.withOpacity(0.7),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: blueColor.withOpacity(0.2),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: isSmallScreen ? 12.h : 15.h),
                                _buildInputField(
                                  title: 'Mobile Number',
                                  hint: 'Enter your mobile number',
                                  icon: Icons.phone_android_outlined,
                                  controller: mobileController,
                                  keyboardType: TextInputType.number,
                                  constraints: constraints,
                                ),
                                SizedBox(height: isSmallScreen ? 12.h : 15.h),
                                _buildInputField(
                                  title: 'Password',
                                  hint: 'Enter your password',
                                  icon: Icons.lock_outline,
                                  controller: passController,
                                  isPassword: true,
                                  obscureText: rePasswordVisible,
                                  constraints: constraints,
                                  suffixIcon: IconButton(
                                    onPressed:
                                        () => setState(() {
                                          rePasswordVisible =
                                              !rePasswordVisible;
                                        }),
                                    icon: Icon(
                                      rePasswordVisible
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
                                      appLogInAuthentication();
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
                                          'Login',
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
    required IconData icon,
    required TextEditingController controller,
    required BoxConstraints constraints,
    bool isPassword = false,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: constraints.maxWidth * 0.02),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: constraints.maxWidth * 0.04,
              fontWeight: FontWeight.w600,
              color: blueColor,
            ),
          ),
        ),
        SizedBox(height: constraints.maxHeight * 0.01),
        Container(
          decoration: BoxDecoration(
            color: tfColor,
            borderRadius: BorderRadius.circular(constraints.maxWidth * 0.04),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: isPassword ? obscureText : false,
            keyboardType: keyboardType,
            style: GoogleFonts.poppins(
              color: colorConst.loginbuttoncolor,
              fontSize: constraints.maxWidth * 0.035,
            ),
            cursorColor: blueColor,
            decoration: InputDecoration(
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
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                color: Colors.grey.withOpacity(0.7),
                fontSize: constraints.maxWidth * 0.035,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  constraints.maxWidth * 0.04,
                ),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  constraints.maxWidth * 0.04,
                ),
                borderSide: BorderSide(color: blueColor, width: 1),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.05,
                vertical: constraints.maxHeight * 0.02,
              ),
              filled: true,
              fillColor: tfColor,
            ),
          ),
        ),
      ],
    );
  }
}
