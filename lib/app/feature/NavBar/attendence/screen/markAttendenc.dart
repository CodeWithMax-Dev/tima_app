import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tima_app/app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/app/DataBase/keys/keys.dart';
import 'package:tima_app/app/core/GWidgets/textfieldsStyle.dart';
import 'package:tima_app/app/core/constants/apiUrlConst.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';
import 'package:tima_app/app/core/constants/textconst.dart';
import 'package:tima_app/app/feature/NavBar/attendence/builder/attendenceBuilder.dart';
import 'package:tima_app/app/feature/NavBar/home/homeNavBar.dart';
import 'package:tima_app/app/providers/LocationProvider/location_provider.dart';

class Markattendance extends StatefulWidget {
  const Markattendance({super.key});

  @override
  State<Markattendance> createState() => _MarkattendanceState();
}

class _MarkattendanceState extends AttendenceBuilder {
  @override
  void initState() {
    super.initState();

    getbranchescall();
    getclient();
    getplaces();
    getvendor();
  }

  bool Isshow = false;
  bool Isshow2 = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: txtHelper().heading1Text('MARK ATTENDENCE', 21, blueColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            selectedAttendancePlacesid != null
                ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Place Selected',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: blueColor,
                    ),
                  ),
                )
                : selectedAttendancePlacesid != 'office'
                ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Select Place',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: blueColor,
                    ),
                  ),
                )
                : const SizedBox(),
            SizedBox(height: 8.h),
            Container(
              height: 55,
              padding: const EdgeInsets.only(top: 5, left: 18, right: 20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: tfColor,
              ),
              child: FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: const InputDecoration(border: InputBorder.none),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: const Text("Select Place"),
                        value: selectedAttendancePlacesid,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            selectedAttendancePlacesid = newValue.toString();
                            Isshow = false;
                            Isshow2 = false;
                            client_controller.clear();
                            vendor_controller.clear();
                          });
                          log(selectedAttendancePlacesid.toString());
                        },
                        items:
                            AttendancePlaces.map((value) {
                              return DropdownMenuItem(
                                value: value['id'],
                                child: Text(value['name'].toString()),
                                onTap: () {
                                  setState(() {
                                    selectedAttendancePlacesid = value['id'];
                                    branchesid = null;
                                    selectedClientid = '';
                                    selectedVendorid = '';
                                    Isshow = false;
                                    Isshow2 = false;
                                    client_controller.clear();
                                    vendor_controller.clear();
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
            selectedAttendancePlacesid != "branch"
                ? Container()
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20, top: 20),
                    //   child: Text(
                    //     'Branch',
                    //     style: GoogleFonts.poppins(
                    //         fontWeight: FontWeight.w400,
                    //         fontSize: 16,
                    //         color: blueColor),
                    //   ),
                    // ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 20,
                        right: 20,
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
                                  });
                                  print(branchesid);
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
                  ],
                ),
            selectedAttendancePlacesid != "client"
                ? Container()
                : Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Container(
                    child: TextFormField(
                      // readOnly: true,
                      controller: client_controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter client name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Client Name",
                        border: boarder,
                        focusedBorder: focusboarder,
                        errorBorder: errorboarder,
                        labelStyle: const TextStyle(fontSize: 14),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            getclient();
                            client_controller.clear();
                            selectedClientid = '';
                          },
                          child: const Icon(Icons.refresh),
                        ),
                      ),
                      onChanged: (text) {
                        Isshow = true;
                        setState(() {
                          ClientList =
                              ClientList.where(
                                (item) => item['org_name']
                                    .toLowerCase()
                                    .contains(text.toLowerCase()),
                              ).toList();
                        });
                        if (client_controller.text.isEmpty) {
                          getclient();
                          client_controller.clear();
                          selectedClientid = '';
                          setState(() {});
                          Isshow = false;
                        }
                      },

                      onTap: () {
                        Isshow = true;
                        setState(() {});
                      },
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
                ),
            Isshow != true
                ? Container()
                : Container(
                  height: size.height,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: ListView.builder(
                    itemCount: ClientList.length,
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      var ClientLists = ClientList[index];
                      return Container(
                        // color: Colors.amber,
                        padding: const EdgeInsets.all(8),
                        width: size.width,

                        child: GestureDetector(
                          onTap: () {
                            Isshow = false;
                            setState(() {
                              setState(() {
                                client_controller.text =
                                    ClientLists['org_name'];
                                selectedClientid = ClientLists['id'];
                              });
                            });
                          },
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ClientLists['org_name'],
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            selectedAttendancePlacesid != "vendor"
                ? Container()
                : Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Container(
                    child: TextFormField(
                      // readOnly: true,
                      controller: vendor_controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter vender name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Vendor Name",
                        border: boarder,
                        focusedBorder: focusboarder,
                        errorBorder: errorboarder,
                        labelStyle: const TextStyle(fontSize: 14),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            getvendor();
                            vendor_controller.clear();
                            selectedVendorid = '';
                          },
                          child: const Icon(Icons.refresh),
                        ),
                      ),
                      onChanged: (text) {
                        Isshow2 = true;
                        setState(() {
                          VendorList =
                              VendorList.where(
                                (item) => item['org_name']
                                    .toLowerCase()
                                    .contains(text.toLowerCase()),
                              ).toList();
                        });
                        if (vendor_controller.text.isEmpty) {
                          getvendor();
                          vendor_controller.clear();
                          selectedVendorid = '';
                          setState(() {});
                        }
                      },

                      onTap: () {
                        Isshow2 = true;
                        setState(() {});
                      },
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
                ),
            Isshow2 != true
                ? Container()
                : Container(
                  height: size.height,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: ListView.builder(
                    itemCount: VendorList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      var ClientLists = VendorList[index];
                      return Container(
                        margin: const EdgeInsets.all(2),
                        child: Container(
                          // color: Colors.amber,
                          padding: const EdgeInsets.all(8),

                          width: size.width * 0.6,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: GestureDetector(
                              onTap: () {
                                Isshow2 = false;
                                setState(() {
                                  setState(() {
                                    vendor_controller.text =
                                        ClientLists['org_name'];
                                    selectedVendorid = ClientLists['id'];
                                  });
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ClientLists['org_name'],
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            SizedBox(height: 22.h),
            Consumer<LocationProvider>(
              builder: (_, ref, __) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blueColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            " Check IN  ".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (selectedAttendancePlacesid != '') {
                              if (selectedClientid != '' ||
                                  branchesid != null ||
                                  selectedVendorid != '' ||
                                  selectedAttendancePlacesid == "office") {
                                ref.updateLocation();
                                var datetime = DateFormat(
                                  "yyyy-MM-dd",
                                ).format(DateTime.now());
                                var datetime_t = DateFormat.Hms().format(
                                  DateTime.now(),
                                );
                                String? userId = await secureStorageService
                                    .getUserID(key: StorageKeys.userIDKey);
                                String? companyId = await secureStorageService
                                    .getUserCompanyID(
                                      key: StorageKeys.companyIdKey,
                                    );
                                String? branchID = await secureStorageService
                                    .getUserBranchID(
                                      key: StorageKeys.branchKey,
                                    );

                                var url = Uri.parse(
                                  mark_attendance_in_url.toString(),
                                );
                                var body = ({
                                  "company_id": companyId,
                                  "branch_id": branchID,
                                  "user_id": userId,
                                  "att_place":
                                      selectedAttendancePlacesid.toString(),
                                  "att_branch_id": branchesid.toString(),
                                  "att_client_id": selectedClientid.toString(),
                                  "att_vendor_id": selectedVendorid.toString(),
                                  "att_date": datetime,
                                  "att_time": datetime_t,
                                  "location":
                                      "${ref.lat.value},${ref.lng.value}",
                                });
                                log("Check In$body");

                                var result = await ApiBaseHelper().postAPICall(
                                  url,
                                  body,
                                );
                                if (result.statusCode == 200) {
                                  var responsedata = jsonDecode(result.body);
                                  log("client registration =>${result.body} ");
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => HomeNavBar(),
                                    ),
                                  );
                                  // GoRouter.of(context)
                                  //     .goNamed(routerConst.homeNavBar);
                                  Fluttertoast.showToast(
                                    msg: responsedata['message'],
                                  );
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg:
                                      "Please select $selectedAttendancePlacesid first",
                                );
                              }
                            } else {
                              Fluttertoast.showToast(
                                msg: "Please select place first",
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blueColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            " Check OUT  ".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (selectedAttendancePlacesid != null) {
                              if (selectedClientid != null ||
                                  branchesid != null ||
                                  selectedVendorid != null ||
                                  selectedAttendancePlacesid == "office") {
                                ref.updateLocation();
                                var datetime = DateFormat(
                                  "yyyy-MM-dd",
                                ).format(DateTime.now());
                                var datetime_t = DateFormat.Hms().format(
                                  DateTime.now(),
                                );
                                String? userId = await secureStorageService
                                    .getUserID(key: StorageKeys.userIDKey);
                                String? companyId = await secureStorageService
                                    .getUserCompanyID(
                                      key: StorageKeys.companyIdKey,
                                    );
                                String? branchID = await secureStorageService
                                    .getUserBranchID(
                                      key: StorageKeys.branchKey,
                                    );

                                var url = Uri.parse(
                                  mark_attendance_out_url.toString(),
                                );
                                var body = ({
                                  "company_id": companyId,
                                  "branch_id": branchID,
                                  "user_id": userId,
                                  "att_place":
                                      selectedAttendancePlacesid.toString(),
                                  "att_branch_id": branchesid.toString(),
                                  "att_client_id": selectedClientid.toString(),
                                  "att_vendor_id": selectedVendorid.toString(),
                                  "att_date": datetime,
                                  "att_time": datetime_t,
                                  "location":
                                      "${ref.lat.value},${ref.lng.value}",
                                });
                                print("Check Out$body");

                                var result = await ApiBaseHelper().postAPICall(
                                  url,
                                  body,
                                );
                                if (result.statusCode == 200) {
                                  var responsedata = jsonDecode(result.body);
                                  print("client registration ${result.body}");
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => HomeNavBar(),
                                    ),
                                  );
                                  // GoRouter.of(context)
                                  //     .goNamed(routerConst.homeNavBar);
                                  Fluttertoast.showToast(
                                    msg: responsedata['message'],
                                  );
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg:
                                      "Please select $selectedAttendancePlacesid first",
                                );
                              }
                            } else {
                              Fluttertoast.showToast(
                                msg: "Please select place first",
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
