import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tima_app/app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/app/DataBase/keys/keys.dart';
import 'package:tima_app/app/core/constants/apiUrlConst.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';
import 'package:tima_app/app/feature/NavBar/home/homeNavBar.dart';
import 'package:tima_app/app/providers/LocationProvider/location_provider.dart';

class HomeMapLocation extends StatefulWidget {
  const HomeMapLocation({super.key});

  @override
  State<HomeMapLocation> createState() => _HomeMapLocationState();
}

class _HomeMapLocationState extends State<HomeMapLocation>
    with SingleTickerProviderStateMixin {
  late LocationProvider _locationProvider;
  final SecureStorageService _secureStorageService = SecureStorageService();
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _locationProvider = LocationProvider();
    _locationProvider.updateLocation();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Create pulse animation
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Start repeating animation
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<LocationProvider>(
      builder: (_, ref, __) {
        return Scaffold(
          body: Stack(
            children: [
              // Animated background gradient
              AnimatedContainer(
                duration: const Duration(seconds: 3),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue.shade50,
                      Colors.white,
                      Colors.blue.shade50.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
              // Decorative circles
              Positioned(
                top: -100,
                right: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        colorConst.primarycolor.withOpacity(0.1),
                        Colors.blue.shade100.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -80,
                left: -30,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade100.withOpacity(0.1),
                        colorConst.primarycolor.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
              // Main content
              SafeArea(
                child: Column(
                  children: [
                    // Custom AppBar with glass effect
                    ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: colorConst.primarycolor,
                                  size: 22.sp,
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => HomeNavBar(),
                                    ),
                                  );
                                },
                              ),
                              Expanded(
                                child: Text(
                                  'Home Location',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              SizedBox(width: 40.w),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Main content area
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.all(24.w),
                          child: Column(
                            children: [
                              // Animated location icon
                              ScaleTransition(
                                scale: _pulseAnimation,
                                child: Container(
                                  height: 120.h,
                                  width: 120.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        colorConst.primarycolor.withOpacity(
                                          0.1,
                                        ),
                                        Colors.blue.shade50,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: colorConst.primarycolor
                                            .withOpacity(0.2),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    color: colorConst.primarycolor,
                                    size: 60.sp,
                                  ),
                                ),
                              ),
                              SizedBox(height: 32.h),
                              // Location information card with glass effect
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 5,
                                    sigmaY: 5,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(24.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(20.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Current Location',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        SizedBox(height: 24.h),
                                        // Coordinates display
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            _buildCoordinateCard(
                                              'Latitude',
                                              ref.lat.value.toString(),
                                            ),
                                            SizedBox(width: 16.w),
                                            _buildCoordinateCard(
                                              'Longitude',
                                              ref.lng.value.toString(),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 24.h),
                                        // Address display with animation
                                        AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          padding: EdgeInsets.all(16.w),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade50,
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.blue.withOpacity(
                                                  0.1,
                                                ),
                                                blurRadius: 10,
                                                spreadRadius: 2,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_city_rounded,
                                                color: colorConst.primarycolor,
                                                size: 24.sp,
                                              ),
                                              SizedBox(width: 12.w),
                                              Expanded(
                                                child: Text(
                                                  ref.address.value,
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 16.sp,
                                                    height: 1.5,
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 32.h),
                              // Update location button with hover effect
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Container(
                                  width: double.infinity,
                                  height: 56.h,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        colorConst.primarycolor,
                                        Colors.blue.shade400,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: colorConst.primarycolor
                                            .withOpacity(0.3),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () async {
                                        dynamic isUpdateLoc =
                                            await _secureStorageService
                                                .getUpdateLocation(key: true) ??
                                            false;
                                        if (isUpdateLoc != true) {
                                          ref.updateLocation();
                                          String? userID =
                                              await _secureStorageService
                                                  .getUserID(
                                                    key: StorageKeys.userIDKey,
                                                  );
                                          var url = Uri.parse(
                                            updatehome_location_url,
                                          );
                                          var body = jsonEncode({
                                            'user_id': userID,
                                            'location':
                                                '${ref.lat.value},${ref.lng.value}',
                                          });
                                          var response = await ApiBaseHelper()
                                              .postAPICall(url, body);

                                          if (response.statusCode == 200) {
                                            var responsedata = jsonDecode(
                                              response.body,
                                            );
                                            log("client registration : $body");
                                            log(
                                              "client registration : ${response.body}",
                                            );
                                            Fluttertoast.showToast(
                                              msg: responsedata['message'],
                                            );
                                            _secureStorageService
                                                .saveUpdateLocation(
                                                  key: StorageKeys.updateLocKey,
                                                  value: true,
                                                );
                                          } else {
                                            Fluttertoast.showToast(
                                              msg:
                                                  "Your Location Already Up to Date",
                                            );
                                          }
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(16.r),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.refresh_rounded,
                                            color: Colors.white,
                                            size: 24.sp,
                                          ),
                                          SizedBox(width: 12.w),
                                          Text(
                                            'Update Home Location',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCoordinateCard(String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              value,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
