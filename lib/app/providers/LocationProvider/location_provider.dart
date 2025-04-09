import 'dart:async';

import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tima_app/app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/app/core/constants/apiUrlConst.dart';
import 'package:tima_app/app/core/helper/permissionToUser.dart';

class LocationProvider extends ChangeNotifier with WidgetsBindingObserver {
  final SecureStorageService _secureStorageService = SecureStorageService();
  Timer? timer;
  Position? initialPosition;
  final lat = ValueNotifier<double>(0.0);
  final lng = ValueNotifier<double>(0.0);
  final address = ValueNotifier<String>('Getting Address..');
  final cron = Cron();

  LocationProvider() {
    WidgetsBinding.instance.addObserver(this);
    initLocation();
    liveLocationShooterWithCron();
  }

  void initLocation() async {
    try {
      await GetPermissionToUser.permissionForLocation();
      initialPosition = await GetPermissionToUser.determinePosition();
      if (initialPosition != null) {
        getPositionData();
        getAddressFromLatLang(initialPosition);
      } else {
        debugPrint('Failed to get initial position');
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
      // Handle the error appropriately
    }
  }

  Future<void> liveLocationShooterWithCron() async {
    cron.schedule(Schedule.parse('*/15 * * * *'), () async {
      String? userId = await _secureStorageService.getUserData(key: 'userId');
      var url = Uri.parse(updatecurrent_location_url);
      updateLocation();
      var body = {"user_id": userId, "location": "${lat.value},${lng.value}"};
      await ApiBaseHelper().postAPICall(url, body);
    });
  }

  void getPositionData() {
    if (initialPosition != null) {
      lat.value = initialPosition!.latitude;
      lng.value = initialPosition!.longitude;
      debugPrint('Location updated - Lat: ${lat.value}, Lng: ${lng.value}');
    } else {
      debugPrint('Position data is null');
    }
  }

  Future<void> getAddressFromLatLang(Position? position) async {
    if (position == null) {
      address.value = 'Unable to get address';
      return;
    }

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        address.value =
            '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      } else {
        address.value = 'Address not found';
      }
    } catch (e) {
      debugPrint('Error getting address: $e');
      address.value = 'Error getting address';
    }
  }

  Future<void> updateLocation() async {
    try {
      Position? newPosition = await GetPermissionToUser.determinePosition();
      if (newPosition != '') {
        initialPosition = newPosition;
        getPositionData();
        getAddressFromLatLang(initialPosition);
      }
    } catch (e) {
      debugPrint('Error updating location: $e');
    }
  }

  void stopTimer() {
    timer?.cancel();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    stopTimer();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    var appStatus = "";
    if (state == AppLifecycleState.resumed) {
      appStatus = "active";
      sendAppStatusToServer(appStatus);
    }
    if (state == AppLifecycleState.paused) {
      appStatus = "minimize";
      sendAppStatusToServer(appStatus);
    }
    if (state == AppLifecycleState.inactive) {
      appStatus = "minimize";
      sendAppStatusToServer(appStatus);
    }
    if (state == AppLifecycleState.detached) {
      appStatus = "logout";
      sendAppStatusToServer(appStatus);
    }
  }

  void sendAppStatusToServer(appStatus) async {
    final userId = await _secureStorageService.getUserData(key: 'userId');
    var url = Uri.parse(set_user_app_status_url);
    var body = {"user_id": userId, "app_status": appStatus};
    await ApiBaseHelper().postAPICall(url, body);
  }
}
