import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tima_app/app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/app/DataBase/keys/keys.dart';
import 'package:tima_app/app/core/GWidgets/btnText.dart';
import 'package:tima_app/app/core/GWidgets/textfieldsStyle.dart';
import 'package:tima_app/app/core/constants/apiUrlConst.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';
import 'package:tima_app/app/core/models/enquirydetailmodel.dart';
import 'package:tima_app/app/feature/drawerPage/inquiry/reciveInquiry/screen/reciveInquiry.dart';

abstract class RecivedInquiryController extends State<ReciveInquiry> {
  SecureStorageService secureStorageService = SecureStorageService();
  List enquirydetailList = [];
  bool enquirydetailload = true;

  GlobalKey<FormState> creatformkey = GlobalKey<FormState>();

  final rejectMessageController = TextEditingController();
  List<Datum> getEnqList = [];
  String? selectedOpStatus;
  String getEnqDetailsMsg = '';
  List op_status = ['all', 'open', 'closed', 'rejected'];
  GetEnquiryDetailModel getEnqDetailModel = GetEnquiryDetailModel();
  var enq_id;
  bool pageloder = true;
  var enqOPStatus;

  var branchesID;
  var branchesName;
  bool rejectenquiryload = false;
  List branches = [];

  showRejectDialogBoxWidget(enqID) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              children: [
                AlertDialog(
                  insetPadding: const EdgeInsets.only(left: 10, right: 10),
                  contentPadding: EdgeInsets.zero,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  title: const Text("Want to reject Inquiry?"),
                  content: Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 20,
                    ),
                    child: FormField<String>(
                      key: creatformkey,
                      builder: (FormFieldState<String> state) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            left: 5,
                            right: 5,
                          ),
                          child: Container(
                            child: TextFormField(
                              // readOnly: true,
                              maxLines: 5,
                              controller: rejectMessageController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter reason';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Reason",
                                border: boarder,
                                focusedBorder: focusboarder,
                                errorBorder: errorboarder,
                                labelStyle: const TextStyle(fontSize: 14),
                              ),
                              onChanged: (text) {
                                setState(() {});
                              },
                              // maxLength: 10,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        String? userID = await secureStorageService.getUserID(
                          key: StorageKeys.userIDKey,
                        );
                        // setState(() {});
                        if (rejectMessageController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Please Enter Reason");
                        } else {
                          var body = ({
                            'user_id': userID,
                            'enq_id': enqID,
                            'reason': rejectMessageController.text,
                          });
                          var url = reject_enquiry_app_url;
                          var result = await ApiBaseHelper().postAPICall(
                            Uri.parse(url),
                            body,
                          );

                          if (result.statusCode == 200) {
                            var responsedata = jsonDecode(result.body);
                            log("client getenquiry_detail body: $body");
                            log(
                              "client getenquiry_detail response: ${result.body}",
                            );
                            Fluttertoast.showToast(
                              msg: responsedata['message'],
                            );
                          }

                          // await getSelectOpStatusEnqDetails();

                          Navigator.of(context).pop();
                        }
                      },
                      child: lebelText(
                        labelText: 'Ok',
                        size: 17,
                        color: blueColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: lebelText(
                        labelText: 'Back',
                        size: 17,
                        color: blueColor,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 9,
                  right: 9,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: colorConst.primarycolor),
                        color: colorConst.colorWhite,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: colorConst.primarycolor,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Future<void> rejectEnqueyApi(String url, dynamic body) async {
  //   rejectenquiryload = true;

  //   var result = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

  //   if (result.statusCode == 200) {
  //     var responsedata = jsonDecode(result.body);
  //     log("client getenquiry_detail body: $body");
  //     log("client getenquiry_detail response: ${result.body}");
  //     Fluttertoast.showToast(msg: responsedata['message']);
  //   }

  //   rejectenquiryload = false;
  // }

  getSelectOpStatusEnqDetails(String selectedOpStatus) async {
    enquirydetailload = true;
    String? userID = await secureStorageService.getUserID(
      key: StorageKeys.userIDKey,
    );
    var url = Uri.parse(Get_Enquiry_details_url);
    var body = ({
      'filter': 'person',
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
        enquirydetailList.add(responsedata['data']);
        getEnqDetailModel = GetEnquiryDetailModel.fromJson(responsedata);
        getEnqDetailsMsg = responsedata['message'];
        setState(() {});
        Fluttertoast.showToast(msg: responsedata['message']);

        enquirydetailload = false;
      }
    } catch (error) {
      log("Select Get Enquiry Details Error =>$error");
      print("Select Get Enquiry Details Error =>$error");
    }
  }
}
