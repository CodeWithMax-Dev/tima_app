import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tima_app/app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/app/DataBase/keys/keys.dart';
import 'package:tima_app/app/core/GWidgets/btnText.dart';
import 'package:tima_app/app/core/GWidgets/customButton.dart';
import 'package:tima_app/app/core/GWidgets/textfieldsStyle.dart';
import 'package:tima_app/app/core/GWidgets/toast.dart';
import 'package:tima_app/app/core/constants/apiUrlConst.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';
import 'package:tima_app/app/core/constants/textconst.dart';
import 'package:tima_app/app/feature/NavBar/home/homeNavBar.dart';
import 'package:tima_app/app/feature/drawerPage/inquiry/createInquiry/controller/createInquiryScreenController.dart';

class CreateInquiry extends StatefulWidget {
  const CreateInquiry({super.key});

  @override
  State<CreateInquiry> createState() => _CreateInquiryState();
}

class _CreateInquiryState extends CreateInquiryController {
  bool isLoader = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: txtHelper().heading1Text('CREATE ENQUIRY', 21, blueColor),
        ),
      ),
      body: Form(
        key: creatformkey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                lebelText(
                  labelText: 'Select Enquiry Type',
                  size: 14.2,
                  color: blueColor,
                ),
                SizedBox(height: 10.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: tfColor,
                  ),
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: const Text("Select Enquiry Type"),
                            value: inquiryTypeid,
                            isDense: true,
                            onChanged: (newValue) {
                              setState(() {
                                inquiryTypeid = newValue;
                              });
                              log(inquiryTypeid);
                            },
                            items:
                                enquiryType.map((value) {
                                  return DropdownMenuItem(
                                    value: value['id'],
                                    child: Text(value['enq_type']),
                                    onTap: () {
                                      setState(() {
                                        inquiryTypeid = value['id'];
                                      });
                                    },
                                  );
                                }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                lebelText(
                  labelText: 'Select Branch',
                  size: 14.2,
                  color: blueColor,
                ),
                SizedBox(height: 10.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: tfColor,
                  ),
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: const Text("Select Branch"),
                            value: branchesid,
                            isDense: true,
                            onChanged: (newValue) {
                              setState(() {
                                branchesid = newValue;

                                getUserCall(branchesid);
                              });
                              log(branchesid);
                            },
                            items:
                                branches.map((value) {
                                  return DropdownMenuItem(
                                    value: value['branch_id'],
                                    child: Text(
                                      value['branch_name'].toString(),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        branchesid = value['branch_id'];
                                      });
                                    },
                                  );
                                }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                lebelText(
                  labelText: 'Select User',
                  size: 14.2,
                  color: blueColor,
                ),
                SizedBox(height: 8.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: tfColor,
                  ),
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: const Text("Select User"),
                            value: personid,
                            isDense: true,
                            onChanged: (dynamic newValue) {
                              setState(() {
                                if (newValue != "0") {
                                  personid = newValue;
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "--Not Selectable--",
                                  );
                                  personid = "0";
                                }
                              });
                              log(personid);
                            },
                            items:
                                person.map((value) {
                                  return DropdownMenuItem(
                                    value: value['user_id'],
                                    onTap:
                                        value['user_id'] == userLogedin_id
                                            ? () {
                                              Fluttertoast.showToast(
                                                msg: "You Self not selectable",
                                              );
                                            }
                                            : () {
                                              setState(() {
                                                personid = value['user_id'];
                                              });
                                            },
                                    child: Text(value['name'].toString()),
                                  );
                                }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                lebelText(
                  labelText: 'Select Services',
                  size: 14.2,
                  color: blueColor,
                ),
                SizedBox(height: 8.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: tfColor,
                  ),
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: const Text("Select Services"),
                            value: productserviceTypeid,
                            isDense: true,
                            onChanged: (newValue) {
                              setState(() {
                                productserviceTypeid = newValue;
                              });
                              log(productserviceTypeid);
                            },
                            items:
                                productserviceType.map((value) {
                                  return DropdownMenuItem(
                                    value: value['id'],
                                    child: Text(value['name'].toString()),
                                    onTap: () {
                                      setState(() {
                                        productserviceTypeid = value['id'];
                                      });
                                    },
                                  );
                                }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                lebelText(
                  labelText: 'Client Name',
                  size: 14.2,
                  color: blueColor,
                ),
                SizedBox(height: 8.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: tfColor,
                  ),
                  width: size.width,
                  child: TextFormField(
                    // readOnly: true,
                    controller: clientNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Client Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Client Name",
                      border: boarder,
                      focusedBorder: focusboarder,
                      errorBorder: errorboarder,
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
                SizedBox(height: 10.h),
                lebelText(
                  labelText: 'Contact Person',
                  size: 14.2,
                  color: blueColor,
                ),
                SizedBox(height: 8.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: tfColor,
                  ),
                  width: size.width,
                  child: TextFormField(
                    // readOnly: true,
                    controller: contactPersonController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Contact Person Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Contact Person",
                      border: boarder,
                      focusedBorder: focusboarder,
                      errorBorder: errorboarder,
                    ),
                    onChanged: (text) {},
                    // maxLength: 10,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontFamily: 'Barlow',
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                lebelText(
                  labelText: 'Contact Number',
                  size: 14.2,
                  color: blueColor,
                ),
                SizedBox(height: 10.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: tfColor,
                  ),
                  width: size.width,
                  child: TextFormField(
                    // readOnly: true,
                    controller: contactNoController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,

                    validator: (value) {
                      RegExp regex = RegExp(r'^[6-9][0-9]{9}$');
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Phone Number';
                      } else if (!regex.hasMatch(value)) {
                        return 'Invalid Contact No';
                      } else if (value.length != 10) {
                        return 'Phone Number is not valid';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "Contact Number",
                      border: boarder,
                      focusedBorder: focusboarder,
                      errorBorder: errorboarder,
                    ),
                    onChanged: (text) {},
                    style: const TextStyle(
                      fontFamily: 'Barlow',
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                lebelText(
                  labelText: 'Vendor Name',
                  size: 14.2,
                  color: blueColor,
                ),
                SizedBox(height: 8.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: tfColor,
                  ),
                  width: size.width,
                  child: TextFormField(
                    // readOnly: true,
                    controller: currentVendorController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Vendor Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Vendor Name",
                      border: boarder,
                      focusedBorder: focusboarder,
                      errorBorder: errorboarder,
                    ),
                    onChanged: (text) {},
                    // maxLength: 10,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                lebelText(labelText: 'Price', size: 14.2, color: blueColor),
                SizedBox(height: 8.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: tfColor,
                  ),
                  width: size.width,
                  child: TextFormField(
                    // readOnly: true,
                    controller: currentPriceController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Price';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Price",
                      border: boarder,
                      focusedBorder: focusboarder,
                      errorBorder: errorboarder,
                      counterText: "",
                    ),
                    onChanged: (text) {},
                    // maxLength: 10,
                    maxLength: 10,
                    keyboardType: TextInputType.number,

                    style: const TextStyle(
                      fontFamily: 'Barlow',
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                lebelText(
                  labelText: 'Target Bussiness',
                  size: 14.2,
                  color: blueColor,
                ),
                SizedBox(height: 8.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: tfColor,
                  ),
                  width: size.width,
                  child: TextFormField(
                    // readOnly: true,
                    controller: targetBussinessController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Target Business';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Target Business",
                      border: boarder,
                      focusedBorder: focusboarder,
                      errorBorder: errorboarder,
                    ),
                    onChanged: (text) {},
                    // maxLength: 10,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontFamily: 'Barlow',
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                lebelText(labelText: 'Remark', size: 14.2, color: blueColor),
                SizedBox(height: 8.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: tfColor,
                  ),
                  width: size.width,
                  child: TextFormField(
                    // readOnly: true,
                    controller: remarkController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Remark';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Remark",
                      border: boarder,
                      focusedBorder: focusboarder,
                      errorBorder: errorboarder,
                    ),
                    onChanged: (text) {},
                    // maxLength: 10,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                appButton(
                  onPressed: () async {
                    if (creatformkey.currentState!.validate()) {
                      if (inquiryTypeid != null) {
                        if (branchesid != null) {
                          if (personid != '0') {
                            if (productserviceTypeid != null) {
                              setState(() {
                                isLoader = true;
                              });
                              String? userID = await secureStorageService
                                  .getUserID(key: StorageKeys.userIDKey);
                              String? companyID = await secureStorageService
                                  .getUserCompanyID(
                                    key: StorageKeys.companyIdKey,
                                  );
                              var url = Uri.parse(save_enquiry_url);
                              var body = ({
                                'user_id': userID,
                                'enq_type': inquiryTypeid,
                                'branch_id': branchesid,
                                'person_id': personid,
                                'product_service_id': productserviceTypeid,
                                'client': clientNameController.text,
                                'contact_person': contactPersonController.text,
                                'contact_no': contactNoController.text,
                                'current_vendor': currentVendorController.text,
                                'current_price': currentPriceController.text,
                                'target_business':
                                    targetBussinessController.text,
                                'remark': remarkController.text,
                                'company': companyID,
                              });
                              log('userID: $userID');
                              log('companyID : $companyID');
                              var result = await ApiBaseHelper().postAPICall(
                                url,
                                body,
                              );
                              if (result.statusCode == 200) {
                                var responsedata = jsonDecode(result.body);
                                log("Create Enquiry registration -->$body ");
                                log(
                                  "Create Enquiry registration --> ${result.body}",
                                );
                                // status = responsedata['status'];
                                setState(() {
                                  isLoader = false;
                                });
                                // GoRouter.of(context)
                                //     .goNamed(routerConst.homeNavBar);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => HomeNavBar(),
                                  ),
                                );
                                Fluttertoast.showToast(
                                  msg: responsedata['message'],
                                );
                                toastMsg("${responsedata['message']}", false);
                                clearControllerData();
                              }
                            } else {
                              toastMsg("Please Select Services", true);
                            }
                          } else {
                            toastMsg("Please Select Person", true);
                          }
                        } else {
                          toastMsg("Please Select Branch", true);
                        }
                      } else {
                        toastMsg("Please Select Enquiry", true);
                      }
                    }
                  },
                  text: isLoader ? 'SUBMIT' : 'Please Wait',
                  height: 50,
                  width: double.infinity,
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
