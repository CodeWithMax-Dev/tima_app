// ignore_for_file: unused_label
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';
import 'package:tima_app/app/feature/LogOut/logout.dart';
import 'package:tima_app/app/feature/home/bloc/notification_bloc.dart';
import 'package:tima_app/app/feature/home/builder/homeBuilder.dart';
import 'package:tima_app/app/providers/LocationProvider/location_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends HomeBuilder {
  final LocationProvider _locationProvider = LocationProvider();
  late NotificationBloc _notificationBloc;

  // Get responsive width based on screen size
  double _getResponsiveWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  // Get responsive height based on screen size
  double _getResponsiveHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }

  // Get responsive font size
  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    double scale = screenWidth / 375; // Base width for scaling
    return baseSize *
        scale.clamp(0.8, 1.4); // Limit scaling between 0.8 and 1.4
  }

  @override
  void initState() {
    _notificationBloc = NotificationBloc();
    _notificationBloc.add(LoadUserNotificationEvent());
    // WidgetsBinding.instance.addObserver(this);
    callHomeBannerFromApi();
    _locationProvider.liveLocationShooterWithCron();
    usreInit();
    disabledSkeleton();
    super.initState();
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width >= 600;
    final isDesktop = screenSize.width >= 1024;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(isTablet ? 70 : 60),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Skeletonizer(
              enabled: isHomeSkeletonON,
              enableSwitchAnimation: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'app_logo',
                    child: Container(
                      padding: EdgeInsets.all(isTablet ? 10 : 8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: blueColor.withOpacity(0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/timaApplogo.jpg',
                        height: isTablet ? 40 : 32,
                        width: isTablet ? 40 : 32,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: isTablet ? 15 : 10),
                  Text(
                    'TIMA',
                    style: GoogleFonts.poppins(
                      fontSize: _getResponsiveFontSize(
                        context,
                        isTablet ? 28 : 24,
                      ),
                      fontWeight: FontWeight.bold,
                      color: blueColor,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Skeletonizer(
                enabled: isHomeSkeletonON,
                enableSwitchAnimation: true,
                child: Container(
                  margin: EdgeInsets.only(right: isTablet ? 16 : 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[100],
                  ),
                  child: IconButton(
                    onPressed:
                        () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CustomDialog();
                          },
                        ),
                    icon: Icon(
                      CupertinoIcons.settings_solid,
                      color: blueColor,
                      size: isTablet ? 28 : 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Skeletonizer(
          enabled: isHomeSkeletonON,
          enableSwitchAnimation: true,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Slider Section
                Container(
                  margin: EdgeInsets.only(
                    top: _getResponsiveHeight(context, 0.02),
                    left: _getResponsiveWidth(context, 0.04),
                    right: _getResponsiveWidth(context, 0.04),
                  ),
                  child:
                      homeSliderImage != ''
                          ? Container(
                            height: _getResponsiveHeight(
                              context,
                              isTablet ? 0.3 : 0.25,
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                isTablet ? 25 : 20,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                isTablet ? 25 : 20,
                              ),
                              child: ImageSlider(),
                            ),
                          )
                          : Container(
                            height: _getResponsiveHeight(context, 0.08),
                            padding: EdgeInsets.symmetric(
                              horizontal: _getResponsiveWidth(context, 0.04),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                isTablet ? 20 : 15,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Marquee(
                              text:
                                  'One Step Towards Solution to all field Employees Problems',
                              style: GoogleFonts.poppins(
                                fontSize: _getResponsiveFontSize(
                                  context,
                                  isTablet ? 18 : 16,
                                ),
                                fontWeight: FontWeight.w500,
                                color: blueColor,
                              ),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              blankSpace: 40.0,
                              velocity: 50.0,
                              pauseAfterRound: Duration(seconds: 1),
                              startPadding: 10.0,
                              accelerationDuration: Duration(seconds: 1),
                              accelerationCurve: Curves.easeInOut,
                              decelerationDuration: Duration(milliseconds: 500),
                              decelerationCurve: Curves.easeOut,
                            ),
                          ),
                ),

                // Notifications Section
                Container(
                  margin: EdgeInsets.only(
                    top: _getResponsiveHeight(context, 0.03),
                    left: _getResponsiveWidth(context, 0.04),
                    right: _getResponsiveWidth(context, 0.04),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.notifications_active_outlined,
                            size: isTablet ? 28 : 24,
                            color: blueColor,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Notifications',
                            style: GoogleFonts.poppins(
                              fontSize: _getResponsiveFontSize(
                                context,
                                isTablet ? 24 : 20,
                              ),
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: _getResponsiveHeight(context, 0.02)),
                      BlocBuilder(
                        bloc: _notificationBloc,
                        builder: (_, state) {
                          switch (state.runtimeType) {
                            case NotificationLoadingState:
                              return Center(
                                child: Container(
                                  padding: EdgeInsets.all(
                                    _getResponsiveWidth(context, 0.04),
                                  ),
                                  child: CircularProgressIndicator(
                                    color: blueColor,
                                    strokeWidth: isTablet ? 3 : 2,
                                  ),
                                ),
                              );
                            case NotificationLoadedSuccessState:
                              final successState =
                                  state as NotificationLoadedSuccessState;
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    isTablet ? 25 : 20,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                        _getResponsiveWidth(context, 0.04),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(
                                              isTablet ? 12 : 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: blueColor.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    isTablet ? 15 : 12,
                                                  ),
                                            ),
                                            child: Icon(
                                              Icons.mail_outline_rounded,
                                              color: blueColor,
                                              size: isTablet ? 28 : 24,
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            'Open Received Enquiry',
                                            style: GoogleFonts.poppins(
                                              fontSize: _getResponsiveFontSize(
                                                context,
                                                isTablet ? 18 : 16,
                                              ),
                                              fontWeight: FontWeight.w600,
                                              color: blueColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AnimatedSwitcher(
                                      duration: Duration(milliseconds: 300),
                                      child:
                                          successState
                                                  .notificationModel
                                                  .enquiryData!
                                                  .isNotEmpty
                                              ? Container(
                                                height: _getResponsiveHeight(
                                                  context,
                                                  isTablet ? 0.5 : 0.45,
                                                ),
                                                child: ListView.builder(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        _getResponsiveWidth(
                                                          context,
                                                          0.04,
                                                        ),
                                                  ),
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  itemCount:
                                                      successState
                                                          .notificationModel
                                                          .enquiryData!
                                                          .length,
                                                  itemBuilder: (_, index) {
                                                    return AnimatedContainer(
                                                      duration: Duration(
                                                        milliseconds: 300,
                                                      ),
                                                      margin: EdgeInsets.only(
                                                        bottom: 12,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[50],
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              isTablet
                                                                  ? 18
                                                                  : 15,
                                                            ),
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[200]!,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      child: ListTile(
                                                        contentPadding:
                                                            EdgeInsets.symmetric(
                                                              horizontal:
                                                                  _getResponsiveWidth(
                                                                    context,
                                                                    0.04,
                                                                  ),
                                                              vertical:
                                                                  isTablet
                                                                      ? 12
                                                                      : 8,
                                                            ),
                                                        leading: Container(
                                                          width:
                                                              isTablet
                                                                  ? 48
                                                                  : 40,
                                                          height:
                                                              isTablet
                                                                  ? 48
                                                                  : 40,
                                                          decoration:
                                                              BoxDecoration(
                                                                shape:
                                                                    BoxShape
                                                                        .circle,
                                                                color: blueColor
                                                                    .withOpacity(
                                                                      0.1,
                                                                    ),
                                                              ),
                                                          child: Center(
                                                            child: Text(
                                                              '${index + 1}',
                                                              style: GoogleFonts.poppins(
                                                                fontSize:
                                                                    _getResponsiveFontSize(
                                                                      context,
                                                                      isTablet
                                                                          ? 18
                                                                          : 16,
                                                                    ),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color:
                                                                    blueColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        title: Text(
                                                          successState
                                                              .notificationModel
                                                              .enquiryData![index],
                                                          style: GoogleFonts.poppins(
                                                            fontSize:
                                                                _getResponsiveFontSize(
                                                                  context,
                                                                  isTablet
                                                                      ? 16
                                                                      : 14,
                                                                ),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black87,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                              : Container(
                                                padding: EdgeInsets.all(
                                                  _getResponsiveWidth(
                                                    context,
                                                    0.06,
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .notifications_off_outlined,
                                                      size: isTablet ? 64 : 48,
                                                      color: Colors.grey[400],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          _getResponsiveHeight(
                                                            context,
                                                            0.02,
                                                          ),
                                                    ),
                                                    Text(
                                                      'No New Notifications',
                                                      style: GoogleFonts.poppins(
                                                        fontSize:
                                                            _getResponsiveFontSize(
                                                              context,
                                                              isTablet
                                                                  ? 18
                                                                  : 16,
                                                            ),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey[600],
                                                      ),
                                                    ),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      'You\'re all caught up!',
                                                      style: GoogleFonts.poppins(
                                                        fontSize:
                                                            _getResponsiveFontSize(
                                                              context,
                                                              isTablet
                                                                  ? 14
                                                                  : 12,
                                                            ),
                                                        color: Colors.grey[500],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                    ),
                                  ],
                                ),
                              );
                            case NotificationFailedErrorState:
                              return Container(
                                padding: EdgeInsets.all(
                                  _getResponsiveWidth(context, 0.06),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    isTablet ? 25 : 20,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.error_outline_rounded,
                                      color: Colors.red[400],
                                      size: isTablet ? 64 : 48,
                                    ),
                                    SizedBox(
                                      height: _getResponsiveHeight(
                                        context,
                                        0.02,
                                      ),
                                    ),
                                    Text(
                                      'Server Not Responding',
                                      style: GoogleFonts.poppins(
                                        fontSize: _getResponsiveFontSize(
                                          context,
                                          isTablet ? 18 : 16,
                                        ),
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red[400],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Please try again later',
                                      style: GoogleFonts.poppins(
                                        fontSize: _getResponsiveFontSize(
                                          context,
                                          isTablet ? 14 : 12,
                                        ),
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(
                                      height: _getResponsiveHeight(
                                        context,
                                        0.02,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Add refresh functionality
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: blueColor,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: _getResponsiveWidth(
                                            context,
                                            0.08,
                                          ),
                                          vertical: _getResponsiveHeight(
                                            context,
                                            0.015,
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            isTablet ? 15 : 12,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Retry',
                                        style: GoogleFonts.poppins(
                                          fontSize: _getResponsiveFontSize(
                                            context,
                                            isTablet ? 16 : 14,
                                          ),
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            default:
                              return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: _getResponsiveHeight(context, 0.03)),
              ],
            ),
          ),
        ),
        drawer: TimaAppDrawer,
      ),
    );
  }
}
