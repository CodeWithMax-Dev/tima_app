import 'dart:core';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionToUserRepo {
  static Future<bool> permissionForLocation() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      status = await Permission.location.request();
    }
    return status.isGranted;
  }

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    // * Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // * Location services are not enabled, don't continue
      return Future.error('Location Service are Disabled.');
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location Permission are denied');
      }
    }
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(
          'Location Permissions are Premanently Denied , we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
