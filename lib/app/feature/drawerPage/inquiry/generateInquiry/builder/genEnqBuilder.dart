import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tima_app/app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/app/DataBase/keys/keys.dart';
import 'package:tima_app/app/core/constants/apiUrlConst.dart';
import 'package:tima_app/app/core/models/enquirydetailmodel.dart';
import 'package:tima_app/app/core/models/generatedinquirymodel.dart';
import 'package:tima_app/app/feature/drawerPage/inquiry/generateInquiry/screen/generateInquiry.dart';

abstract class GenEnqBuilder extends State<Generateinquiry> {
  bool generateenquiryload = true;

  GenerateEnquiryModel generatedInqModel = GenerateEnquiryModel();
  final SecureStorageService secureStorageService = SecureStorageService();
  String? selectedOpStatus;
  String getEnqDetailsMsg = '';
  bool getEnqLoad = true;
  List op_status = ['all', 'open', 'closed', 'rejected'];
  GetEnquiryDetailModel getEnqDetailModel = GetEnquiryDetailModel();

  var branchesid;
  var branchesname;
  List branches = [];

  getSelectOpStatusGenEnqDetails(String selectedOpStatus) async {
    getEnqLoad = true;
    String? userID = await secureStorageService.getUserID(
      key: StorageKeys.userIDKey,
    );
    var url = Uri.parse(Get_Enquiry_details_url);
    var body = ({
      'filter': 'user',
      'user_id': userID,
      'enq_id': '0',
      'op_status': selectedOpStatus,
    });
    try {
      var response = await ApiBaseHelper().postAPICall(url, body);
      var responsedata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        log("client getenquiry_detail body =>$body");
        log("client getenquiry_detail response =>${response.body}");
        getEnqDetailModel = GetEnquiryDetailModel.fromJson(responsedata);
        getEnqDetailsMsg = responsedata['message'];
        setState(() {});
        Fluttertoast.showToast(msg: responsedata['message']);

        getEnqLoad = false;
      }
    } catch (error) {
      log("Select Get Enquiry Details Error =>$error");
      print("Select Get Enquiry Details Error =>$error");
    }
  }
}
