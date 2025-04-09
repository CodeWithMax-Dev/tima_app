import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tima_app/app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/app/core/models/enquirydetailviewmodel.dart';
import 'package:tima_app/app/core/models/enquiryviewdetailmodel.dart';
import 'package:tima_app/app/core/models/generatedinquirymodel.dart';

class InquiryProvider with ChangeNotifier {
  List enquirydetailList = [];
  var enquiryvisiDetail = GetEnquiryViewDetailModel(
    data: [],
    message: '',
    status: DateTime.april,
  );

  List dataList = [];
  var inquirydetail = GetEnquiryDetailViewModel();
  bool enquiryvisitdetailload = false;
  bool rejectenquiryload = false;
  bool enquirydetailload = false;
  bool generateenquiryload = false;
  bool getenquirydetailload = false;
  List enquirytype = [];
  String startDateController = "";
  String endDateController = "";
  String startgeneratedDateController = "";
  String endgeneratedDateController = "";
  List<EnquiryData>? enquiryList;

  List<dynamic> responseList = [];

  Future<void> rejectenquiryapi(String url, dynamic body) async {
    rejectenquiryload = true;
    notifyListeners();

    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      log("client getenquiry_detail body: $body");
      log("client getenquiry_detail response: ${result.body}");
      Fluttertoast.showToast(msg: responsedata['message']);
    }

    rejectenquiryload = false;
    notifyListeners();
  }

  Future<void> getVisitDetailapi(String url, dynamic body) async {
    enquiryvisitdetailload = true;
    notifyListeners();

    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      log("client getenquiry_detail body :$body ");
      log("client getenquiry_detail response: $result.body");
      var data = GetEnquiryViewDetailModel.fromJson(responsedata);
      enquiryvisiDetail = data;
      log(
        "client getenquiryView_detail response: ${enquiryvisiDetail.data.length} ",
      );
      Fluttertoast.showToast(msg: responsedata['message']);
    }

    enquiryvisitdetailload = false;
    notifyListeners();
  }

  Future<void> getEnquiryDetailapi(String url, dynamic body) async {
    getenquirydetailload = true;
    notifyListeners();

    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      var data = GetEnquiryDetailViewModel.fromJson(responsedata);
      inquirydetail = data;
    }

    getenquirydetailload = false;
    notifyListeners();
  }

  Future<void> getGenerateEnquiryApi(String url, dynamic body) async {
    generateenquiryload = true;
    notifyListeners();

    try {
      var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

      if (result.statusCode == 200) {
        var responseData = jsonDecode(result.body);
        print("client getGenerateEnquiryApi body: $body");
        print("client getGenerateEnquiryApi response: ${result.body}");

        GenerateEnquiryModel generatedInqModel = GenerateEnquiryModel.fromJson(
          responseData,
        );
        Fluttertoast.showToast(msg: responseData['message']);
        generateenquiryload = false;

        enquiryList = generatedInqModel.data; // Store the list of EnquiryData
        notifyListeners();
      } else {
        _handleError(result.statusCode, result.body);
      }
    } catch (e) {
      print("Error in getGenerateEnquiryApi: $e");
      Fluttertoast.showToast(msg: "An error occurred. Please try again.");
    }
  }

  void _handleError(int statusCode, String responseBody) {
    print(
      "Error in getGenerateEnquiryApi - Status Code: $statusCode, Response: $responseBody",
    );
    Fluttertoast.showToast(
      msg: "Failed to load data. Status Code: $statusCode",
    );
  }
}
