import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';
import 'package:tima_app/app/feature/Auth/loginPages/screen/loginPage.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5 * _fadeAnimation.value,
            sigmaY: 5 * _fadeAnimation.value,
          ),
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 0.8.sw,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: colorConst.primarycolor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.logout_rounded,
                          color: colorConst.primarycolor,
                          size: 40.sp,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Are you sure you want to logout?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black54,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildButton(
                              title: 'Cancel',
                              onTap: () => Navigator.of(context).pop(),
                              isOutlined: true,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: _buildButton(
                              title: 'Logout',
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PhoneEmailLogin(),
                                  ),
                                  (route) => false,
                                );
                              },
                              isOutlined: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton({
    required String title,
    required VoidCallback onTap,
    required bool isOutlined,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            gradient:
                isOutlined
                    ? null
                    : LinearGradient(
                      colors: [colorConst.primarycolor, Colors.blue.shade400],
                    ),
            borderRadius: BorderRadius.circular(12.r),
            border:
                isOutlined
                    ? Border.all(color: colorConst.primarycolor, width: 2)
                    : null,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isOutlined ? colorConst.primarycolor : Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
