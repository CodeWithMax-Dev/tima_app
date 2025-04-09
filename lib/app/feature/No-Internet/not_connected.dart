import 'package:flutter/material.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // No internet illustration
              Icon(
                Icons.signal_wifi_off_rounded,
                size: 120,
                color: Colors.deepPurpleAccent,
              ),
              SizedBox(height: 32),

              // Title
              Text(
                'No Internet Connection',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurpleAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),

              // Description
              Text(
                'Please check your internet connection and try again',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),

            ],
          ),
        ),
      ),
    )
    );
  }
}
