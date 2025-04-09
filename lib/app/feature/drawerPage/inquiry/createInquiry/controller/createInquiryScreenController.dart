import 'dart:convert';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:tima_app/app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/app/DataBase/keys/keys.dart';
import 'package:tima_app/app/core/constants/apiUrlConst.dart';
import 'package:tima_app/app/feature/drawerPage/inquiry/createInquiry/screen/createInqueryPage.dart';
import 'package:tima_app/app/providers/LocationProvider/location_provider.dart';

abstract class CreateInquiryController extends State<CreateInquiry> {
  GlobalKey<FormState> creatformkey = GlobalKey<FormState>();
  LocationProvider locationProvider = LocationProvider();
  SecureStorageService secureStorageService = SecureStorageService();
  final clientNameController = TextEditingController();
  final contactPersonController = TextEditingController();
  final contactNoController = TextEditingController();
  final currentVendorController = TextEditingController();
  final currentPriceController = TextEditingController();
  final targetBussinessController = TextEditingController();
  final remarkController = TextEditingController();

  List person = [];
  List enquiryType = [];
  List productserviceType = [];
  List branches = [];
  var personid = "0";
  var inquiryTypeid;
  var productserviceTypeid;
  var branchesid;
  String? userLogedin_id;
  @override
  void initState() {
    super.initState();
    clearControllerData();
  }

  clearControllerData() async {
    locationProvider.updateLocation();
    String? userID = await secureStorageService.getUserID(
      key: StorageKeys.userIDKey,
    );

    setState(() {
      userLogedin_id = userID;

      person = [];
      enquiryType = [];
      productserviceType = [];
      branches = [];
      personid = "0";
      inquiryTypeid = null;
      productserviceTypeid = null;
      branchesid = null;
      getenquirytypecall();
      getbranchescall();
      getproductservice();
    });
  }

  getenquirytypecall() async {
    String? companyid = await secureStorageService.getUserCompanyID(
      key: StorageKeys.companyIdKey,
    );
    var url = getenquirytype_url;
    var body = ({'id': '0', 'company': companyid});

    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      setState(() {
        enquiryType.addAll(responsedata['data']);
        print("enquiryType : $enquiryType");
      });
    }
  }

  getbranchescall() async {
    String? companyid = await secureStorageService.getUserCompanyID(
      key: StorageKeys.companyIdKey,
    );
    var url = getbranchestype_url;
    var body = ({'company_id': companyid, 'branch_id': '0'});

    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      setState(() {
        branches.addAll(responsedata['data']);
        log("branches : => $branches");
        print("branches : => $branches");
      });
    }
  }

  getUserCall(branchid) async {
    String? companyID = await secureStorageService.getUserCompanyID(
      key: StorageKeys.companyIdKey,
    );
    person.clear();
    personid = '';
    var url = getusers_url;
    var body = ({
      'company_id': companyID.toString(),
      'branch_id': branchid.toString(),
      'user_id': "0",
    });
    print("person body: =>$body");
    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      setState(() {
        var firstdata = [
          {
            "user_id": "0",
            "name": "--Select User--",
            "city_name": "Jodhpur",
            "state_name": "Rajasthan",
          },
        ];
        person.addAll(firstdata);

        person.addAll(responsedata['data']);
        print("person : 1$person");
        person.removeWhere((element) => element['user_id'] == userLogedin_id);
        print("person : 2$person");
        personid = person[0]["user_id"];
        print("person : $person");
      });
    }
  }

  getproductservice() async {
    setState(() {
      productserviceType.clear();
    });
    String? companyid = await secureStorageService.getUserCompanyID(
      key: StorageKeys.companyIdKey,
    );

    var url = Uri.parse(product_service_url);
    var body = ({'type': 'product', "company_id": companyid, 'id': '0'});
    var result = await ApiBaseHelper().postAPICall(url, body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      if (responsedata['status'] == 1) {
        productserviceType.addAll(responsedata['data']);
      }

      //----service----//
      var url = Uri.parse(product_service_url);
      var bodys = ({'type': 'service', "company_id": companyid, 'id': '0'});
      var results = await ApiBaseHelper().postAPICall(url, bodys);
      var responsedatas = jsonDecode(results.body);
      if (results.statusCode == 200) {
        if (responsedatas['status'] == 1) {
          setState(() {
            productserviceType.addAll(responsedatas['data']);
          });
        }
      }
    }
  }
}
