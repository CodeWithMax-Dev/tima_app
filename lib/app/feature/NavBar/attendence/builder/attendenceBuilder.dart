import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tima_app/app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/app/DataBase/keys/keys.dart';
import 'package:tima_app/app/core/constants/apiUrlConst.dart';
import 'package:tima_app/app/feature/NavBar/attendence/screen/markAttendenc.dart';

abstract class AttendenceBuilder extends State<Markattendance> {
  SecureStorageService secureStorageService = SecureStorageService();

  var branchesid;
  List branches = [];
  final TextEditingController client_controller = TextEditingController();
  final TextEditingController vendor_controller = TextEditingController();
  String? selectedClientid;
  String? selectedVendorid;
  String? selectedAttendancePlacesid;

  List ClientList = [];
  List VendorList = [];
  List AttendancePlaces = [];
  getbranchescall() async {
    var datetime = DateFormat("yyyy-MM-dd").format(DateTime.now());
    var datetime_t = DateFormat.Hms().format(DateTime.now());
    print("datetime : $datetime");
    print("datetime_t : $datetime_t");
    String? companyId = await secureStorageService.getUserCompanyID(
      key: StorageKeys.companyIdKey,
    );
    var url = getbranchestype_url;
    var body = ({'company_id': companyId, 'branch_id': '0'});

    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      setState(() {
        branches.addAll(responsedata['data']);
        print("branches : $branches");
      });
    }
  }

  getclient() async {
    var url = get_client_data_url;
    String? userId = await secureStorageService.getUserID(
      key: StorageKeys.userIDKey,
    );
    String? companyId = await secureStorageService.getUserCompanyID(
      key: StorageKeys.companyIdKey,
    );
    String? branchID = await secureStorageService.getUserBranchID(
      key: StorageKeys.branchKey,
    );

    var body = ({'id': '0', "company_id": companyId, "user_id": userId});
    ClientList.clear();
    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      setState(() {
        ClientList.addAll(responsedata['data']);
        print("ClientList : $ClientList");
      });
    }
  }

  getplaces() async {
    var url = get_attendance_places_url;
    var body = ({'id': '0'});
    AttendancePlaces.clear();
    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      responsedata['data'].forEach((k, v) {
        print('$k: $v');
        setState(() {
          AttendancePlaces.addAll([
            {"id": "$k", "name": "$v"},
          ]);
          log("AttendancePlaces : $AttendancePlaces");
        });
      });
    }
  }

  getvendor() async {
    String? userId = await secureStorageService.getUserID(
      key: StorageKeys.userIDKey,
    );
    String? companyId = await secureStorageService.getUserCompanyID(
      key: StorageKeys.companyIdKey,
    );
    var url = get_vendor_data_url;
    var body = ({'id': '0', "company_id": companyId, "user_id": userId});
    VendorList.clear();
    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      setState(() {
        VendorList.addAll(responsedata['data']);
        print("VendorList : $VendorList");
      });
    }
  }
}
