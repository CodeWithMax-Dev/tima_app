// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tima_app/app/core/service/connection.dart';
import 'package:tima_app/app/core/service/navigation_service.dart';
import 'package:tima_app/app/feature/home/bloc/notification_bloc.dart';
import 'package:tima_app/app/feature/splashScreen/splashScreen.dart';
import 'package:tima_app/app/providers/LocationProvider/location_provider.dart';
import 'package:tima_app/app/providers/inquireyProvider/inquiry_provider.dart';

//! current tima project

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(BlocProvider(create: (context) => NotificationBloc(), child: MyApp()));
  initNoInternetListener();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // * dependency injection for mulitblocproviders
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocationProvider()),
          ChangeNotifierProvider(create: (_) => InquiryProvider()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          builder: FToastBuilder(),
          navigatorKey: NavigationService().navigationKey,
        ),
      ),
    );
  }
}
