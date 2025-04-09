import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tima_app/app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/app/DataBase/keys/keys.dart';
import 'package:tima_app/app/core/GWidgets/toast.dart';
import 'package:tima_app/app/core/constants/apiUrlConst.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';
import 'package:tima_app/app/feature/NavBar/Admin/model/client_model.dart';
import 'package:tima_app/app/feature/NavBar/Admin/model/get_visit_model.dart';
import 'package:tima_app/app/feature/NavBar/Admin/model/start_visit_model.dart';
import 'package:tima_app/app/feature/NavBar/Admin/model/vendor_model.dart';
import 'package:tima_app/app/feature/NavBar/Admin/screen/requestAdmin.dart';
import 'package:tima_app/app/feature/NavBar/home/homeNavBar.dart';
import 'package:tima_app/app/providers/LocationProvider/location_provider.dart';

abstract class AdminController extends State<RequestAdmin> {
  late LocationProvider locationProvider;
  TextEditingController locationController = TextEditingController();

  // SecureStorageService secureStorageService = SecureStorageService();
  final SecureStorageService secureStorageService = SecureStorageService();
  GetVisitsStatusModel getVisitStatusModel = GetVisitsStatusModel();
  StartVisitModel startVisitModel = StartVisitModel();
  bool formloder = false;
  String? selectedOption = 'no';
  int selectedIndex = 2;
  int selectedRadioTile = 1;
  String? selectedClientid;
  String? selectedVendorid;
  var StartDate;
  var EndDate;
  bool isConnected = false;
  TextEditingController clientController = TextEditingController();
  TextEditingController vendorController = TextEditingController();
  TextEditingController clientControllerV2 = TextEditingController();
  TextEditingController vendorControllerV2 = TextEditingController();
  final personNameController = TextEditingController();
  final personNameController2 = TextEditingController();
  final personDesignationController = TextEditingController();
  final personMobileNoController = TextEditingController();
  final quiryController = TextEditingController();
  final remarkController = TextEditingController();
  List getVisitData = [];

  var productServiceTypeID;
  List productServiceType = [];
  ClientsModel clientsModel = ClientsModel();
  VendorsModel vendorsModel = VendorsModel();
  String? personName;
  String? personDesig;
  String? contactNo;

  List ClientList = [];
  List VendorList = [];
  bool isVisited = false;

  bool isShowUi = false;
  bool isShowUi2 = false;

  checkInternetConnectivity() async {
    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      setState(() {
        isConnected = true;
      });
    } else {
      setState(() {
        isConnected = false;
      });
    }
  }

  noConnectionPopup() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Connection'),
            content: Text(
              'Please check your internet connection and try again.',
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  getVisitStatus() async {
    final client = http.Client();

    String? companyID = await secureStorageService.getUserCompanyID(
      key: StorageKeys.companyIdKey,
    );
    String? userID = await secureStorageService.getUserID(
      key: StorageKeys.userIDKey,
    );
    try {
      var url = Uri.parse(getVisitStatusApiUrlEndPoint);
      final response = await client.post(
        url,
        body: {'user_id': userID, 'company_id': companyID},
      );

      if (response.statusCode == 200) {
        var decodedResp = jsonDecode(response.body);
        getVisitStatusModel = GetVisitsStatusModel.fromJson(decodedResp);
        log('getVisitStatusModel => ${getVisitStatusModel.status}');
        log('getVisitStatusModel data => ${getVisitStatusModel.data}');
        personNameController.text =
            getVisitStatusModel.data!.personName.toString();
        setState(() {
          personName = getVisitStatusModel.data!.personName;
          personDesig = getVisitStatusModel.data!.personDesignation;
          contactNo = getVisitStatusModel.data!.contactNo;
        });

        if (getVisitStatusModel.status == 1) {
          toastMsg(getVisitStatusModel.message, false);
          if (getVisitStatusModel.data != null) {
            setState(() {});
          } else {
            toastMsg(getVisitStatusModel.message, true);
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  getProductService() async {
    setState(() {
      productServiceType.clear();
    });

    var url = Uri.parse(product_service_url);
    String? companyID = await secureStorageService.getUserCompanyID(
      key: StorageKeys.companyIdKey,
    );
    var body = ({'type': 'product', "company_id": companyID, 'id': '0'});
    var result = await ApiBaseHelper().postAPICall(url, body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      if (responsedata['status'] == 1) {
        productServiceType.addAll(responsedata['data']);
      }

      //----service----//
      var url = Uri.parse(product_service_url);
      var bodys = ({'type': 'service', "company_id": companyID, 'id': '0'});
      var results = await ApiBaseHelper().postAPICall(url, bodys);
      var responsedatas = jsonDecode(results.body);
      if (results.statusCode == 200) {
        if (responsedatas['status'] == 1) {
          setState(() {
            productServiceType.addAll(responsedatas['data']);
          });
        }
      }
    }
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      isShowUi = false;
      isShowUi2 = false;
    });
  }

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TimeOfDay? selectedStartTime;

  Future<void> selectDateByUser(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> selectTimeByUser(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  Future<void> selectStartTimeByUser(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedStartTime = pickedTime;
      });
    }
  }

  getClientFromApi() async {
    var url = get_client_data_url;
    String? companyID = await secureStorageService.getUserCompanyID(
      key: StorageKeys.companyIdKey,
    );
    String? userID = await secureStorageService.getUserID(
      key: StorageKeys.userIDKey,
    );
    var body = ({'id': '0', "company_id": companyID, "user_id": userID});
    ClientList.clear();
    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      clientsModel = ClientsModel.fromJson(responsedata);
      setState(() {
        ClientList.addAll(responsedata['data']);
        log("ClientList : $ClientList");
      });
    }
  }

  getVendorFromApi() async {
    String? companyID = await secureStorageService.getUserCompanyID(
      key: StorageKeys.companyIdKey,
    );
    String? userID = await secureStorageService.getUserID(
      key: StorageKeys.userIDKey,
    );
    var url = get_vendor_data_url;
    var body = ({'id': '0', "company_id": companyID, "user_id": userID});
    VendorList.clear();
    var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
    if (result.statusCode == 200) {
      var responsedata = jsonDecode(result.body);
      vendorsModel = VendorsModel.fromJson(responsedata);
      setState(() {
        VendorList.addAll(responsedata['data']);
        log("VendorList : $VendorList ");
      });
    }
  }

  Widget get startBtn => Consumer<LocationProvider>(
    builder: (_, ref, __) {
      return SizedBox(
        height: 50,
        width: 140,
        child:
            selectedRadioTile == 1
                ? ElevatedButton(
                  onPressed: () async {
                    ref.updateLocation();
                    locationController = TextEditingController(
                      text: "${ref.lat.value} , ${ref.lng.value}",
                    );
                    if (selectedClientid != null) {
                      final client = http.Client();
                      var url = Uri.parse(startVisitApiUrlEndPoint);
                      String? companyID = await secureStorageService
                          .getUserCompanyID(key: StorageKeys.companyIdKey);
                      String? userID = await secureStorageService.getUserID(
                        key: StorageKeys.userIDKey,
                      );
                      try {
                        var response = await client.post(
                          url,
                          body: {
                            'user_id': userID,
                            'company_id': companyID,
                            'visit_at': 'client',
                            'client_id': selectedClientid.toString(),
                            'vendor_id': '0',
                            'inq_id': getVisitStatusModel.data?.inqId ?? '0',
                            'location': locationController.text,
                          },
                        );

                        if (response.statusCode == 200) {
                          var decodedResp = jsonDecode(response.body);
                          startVisitModel = StartVisitModel.fromJson(
                            decodedResp,
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const HomeNavBar(),
                            ),
                          );
                          // GoRouter.of(context).goNamed(routerConst.homeNavBar);
                          log('Start Visit => ${startVisitModel.status}');
                          log('Start Visit => ${startVisitModel.message}');
                          toastMsg(
                            startVisitModel.message,
                            startVisitModel.status == 1 ? false : true,
                          );
                          log('lat => ${locationController.text}');
                        }
                      } catch (e) {
                        print(e);
                      }
                    } else {
                      toastMsg('Please select client name', true);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                )
                : ElevatedButton(
                  onPressed: () async {
                    ref.updateLocation();
                    locationController = TextEditingController(
                      text: "${ref.lat.value} , ${ref.lng.value}",
                    );
                    if (selectedVendorid != null) {
                      final client = http.Client();
                      var url = Uri.parse(startVisitApiUrlEndPoint);
                      String? companyID = await secureStorageService
                          .getUserCompanyID(key: StorageKeys.companyIdKey);
                      String? userID = await secureStorageService.getUserID(
                        key: StorageKeys.userIDKey,
                      );
                      try {
                        var response = await client.post(
                          url,
                          body: {
                            'user_id': userID,
                            'company_id': companyID,
                            'visit_at': 'vendor',
                            'client_id': '0',
                            'vendor_id': selectedVendorid.toString(),
                            'inq_id': getVisitStatusModel.data?.inqId ?? '0',
                            'location': locationController.text,
                          },
                        );

                        if (response.statusCode == 200) {
                          var decodedResp = jsonDecode(response.body);
                          startVisitModel = StartVisitModel.fromJson(
                            decodedResp,
                          );
                          // GoRouter.of(context).goNamed(routerConst.homeNavBar);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const HomeNavBar(),
                            ),
                          );
                          log('Start Visit => ${startVisitModel.status}');
                          log('Start Visit => ${startVisitModel.message}');
                          toastMsg(
                            startVisitModel.message,
                            startVisitModel.status == 1 ? false : true,
                          );
                          log('lat => ${locationController.text}');

                          // GoRouter.of(context).goNamed(routerConst.homeNavBar);
                        }
                      } catch (e) {
                        print(e);
                      }
                    } else {
                      toastMsg('Please select vendor name', true);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
      );
    },
  );
}
