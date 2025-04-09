// ignore_for_file: must_be_immutable
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';
import 'package:tima_app/app/core/constants/textconst.dart';
import 'package:tima_app/app/core/models/lat_lng_model.dart';
import 'package:tima_app/app/feature/Auth/register/screen/register.dart';
import 'package:tima_app/app/feature/NavBar/Admin/screen/requestAdmin.dart';
import 'package:tima_app/app/feature/NavBar/home/homeNavBar.dart';
import 'package:tima_app/app/feature/drawerPage/inquiry/reciveInquiry/controller/recivedInquiryController.dart';
import 'package:tima_app/app/feature/visit/visitDetails/visitDetail.dart';
import 'package:tima_app/app/providers/LocationProvider/location_provider.dart';
import 'package:tima_app/app/router/routeParams/nextVisitParams.dart';

class ReciveInquiry extends StatefulWidget {
  const ReciveInquiry({super.key});

  @override
  State<ReciveInquiry> createState() => _ReciveInquiryState();
}

class _ReciveInquiryState extends RecivedInquiryController {
  // @override
  // void initState() {
  //   getSelectOpStatusEnqDetails();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 10, bottom: 3),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_outlined, color: Colors.black),
              padding: const EdgeInsets.all(0),
              onPressed: () {
                // GoRouter.of(context).goNamed(routerConst.homeNavBar);
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => HomeNavBar()));
              },
            ),
          ),
        ),
        centerTitle: true,
        title: txtHelper().heading1Text('RECEIVED ENQUIRY', 21, blueColor),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Container(
              height: 55,
              padding: const EdgeInsets.only(top: 5, left: 18, right: 20),
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
                        hint: const Text("Select Status"),
                        value: selectedOpStatus,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedOpStatus = newValue;
                            log('$selectedOpStatus');
                          });
                        },
                        items:
                            op_status.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                                onTap: () {
                                  setState(() {
                                    selectedOpStatus = value;
                                    getSelectOpStatusEnqDetails(
                                      selectedOpStatus.toString(),
                                    );
                                    log('$selectedOpStatus');
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
            SizedBox(height: 15.h),
            enquirydetailload
                ? Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      'Please Select Status for Enquiry Details',
                    ),
                  ),
                )
                : Expanded(
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: getEnqDetailModel.data!.length,
                    itemBuilder: (context, index) {
                      var getEnqDetailList = getEnqDetailModel.data![index];
                      enq_id = getEnqDetailList.id;
                      return Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: tfColor,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Generated On : ${getEnqDetailList.dateTime}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Generated By : ${getEnqDetailList.userName}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Contact No.: ${getEnqDetailList.userMobile} ",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Enquery Type : ${getEnqDetailList.enqTypeName}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Enquiry For : ${getEnqDetailList.personName},${getEnqDetailList.branchName}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Contact No.: ${getEnqDetailList.personMobile} ",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Product/Service : ${getEnqDetailList.productServiceType} (${getEnqDetailList.productServiceName})",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Client: ${getEnqDetailList.client} ",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Contact Person : ${getEnqDetailList.contactPerson} ",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Contact No.: ${getEnqDetailList.contactNo} ",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                //========-
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Client/Vendor Name : ${getEnqDetailList.currentVendor}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Current price : ${getEnqDetailList.currentPrice}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Target Buisness : ${getEnqDetailList.targetBusiness}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Remark: ${getEnqDetailList.remark} ",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Status: ${getEnqDetailList.opStatus} ",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    getEnqDetailList.opStatus == "closed"
                                        ? GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (_) => VisitDeatil(
                                                      visitDetailScreenParams:
                                                          VisitDetailScreenParams(
                                                            indexlistno:
                                                                getEnqList[index]
                                                                    .id,
                                                            name:
                                                                getEnqList[index]
                                                                    .personName,
                                                          ),
                                                    ),
                                              ),
                                            );
                                            // GoRouter.of(context).pushNamed(
                                            //     routerConst
                                            //         .visitDetailScreen,
                                            //     extra: VisitDetailScreenParams(
                                            //         indexlistno:
                                            //             getEnqList[
                                            //                     index]
                                            //                 .id,
                                            //         name: getEnqList[
                                            //                 index]
                                            //             .personName));
                                          },
                                          child: Container(
                                            height: 40,
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.4,
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(8.0),
                                            color: colorConst.orangeColour,
                                            child: const Text(
                                              "View Detail",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.8,
                                              ),
                                            ),
                                          ),
                                        )
                                        : getEnqDetailList.clientId == null &&
                                            getEnqDetailList.vendorId == null
                                        ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              spacing: 8,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Consumer<LocationProvider>(
                                                  builder: (_, ref, __) {
                                                    return SizedBox(
                                                      height: 40,
                                                      width: 120,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          ref.updateLocation();
                                                          Navigator.of(
                                                            context,
                                                          ).push(
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (
                                                                    _,
                                                                  ) => RegisterScreen(
                                                                    latLng: LatLng(
                                                                      lat:
                                                                          ref
                                                                              .lat
                                                                              .value
                                                                              .toString(),
                                                                      lng:
                                                                          ref
                                                                              .lng
                                                                              .value
                                                                              .toString(),
                                                                      address:
                                                                          ref
                                                                              .address
                                                                              .value,
                                                                    ),
                                                                    inqId:
                                                                        getEnqDetailList
                                                                            .id,
                                                                  ),
                                                            ),
                                                          );
                                                          // GoRouter.of(context).pushNamed(
                                                          //     routerConst
                                                          //         .register,
                                                          //     extra: getEnqDetailList
                                                          //         .id);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  6,
                                                                ),
                                                          ),
                                                          backgroundColor:
                                                              const Color.fromARGB(
                                                                255,
                                                                94,
                                                                113,
                                                                94,
                                                              ),
                                                        ),
                                                        child: const Text(
                                                          "Map Client",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),

                                                // SizedBox(
                                                //   height: 15.h,
                                                // ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder:
                                                            (_) => RequestAdmin(
                                                              inqId:
                                                                  getEnqDetailList
                                                                      .id,
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 80,
                                                    alignment: Alignment.center,
                                                    padding:
                                                        const EdgeInsets.all(
                                                          8.0,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                      color:
                                                          colorConst
                                                              .primarycolor,
                                                    ),
                                                    child: const Text(
                                                      "Visit",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing: 0.8,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // SizedBox(
                                                //   width: 25.w,
                                                // ),
                                                SizedBox(
                                                  height: 40,
                                                  width: 97,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        showRejectDialogBoxWidget(
                                                          getEnqDetailList.id,
                                                        );
                                                      });
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              6,
                                                            ),
                                                      ),
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                    child: const Text(
                                                      "Reject",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing: 0.8,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                        : Container(),
                                    // getEnqDetailList.opStatus == "closed"
                                    //     ? Container()
                                    //     :
                                    // getEnqDetailList.clientId ==
                                    //             null &&
                                    //         getEnqDetailList
                                    //                 .vendorId ==
                                    //             null
                                    //     ? Container()
                                    //     : GestureDetector(
                                    //         onTap: () {
                                    //           GoRouter.of(context)
                                    //               .pushNamed(
                                    //             routerConst
                                    //                 .requestAdmin,
                                    //             extra:
                                    //                 getEnqDetailList
                                    //                     .id,
                                    //           );
                                    //         },
                                    //         child: Container(
                                    //           height: 40,
                                    //           width: MediaQuery.of(
                                    //                       context)
                                    //                   .size
                                    //                   .width *
                                    //               0.4,
                                    //           alignment:
                                    //               Alignment.center,
                                    //           padding:
                                    //               const EdgeInsets
                                    //                   .all(8.0),
                                    //           color: colorConst
                                    //               .primarycolor,
                                    //           child: const Text(
                                    //             "Visit",
                                    //             style: TextStyle(
                                    //                 color:
                                    //                     Colors.white,
                                    //                 fontWeight:
                                    //                     FontWeight
                                    //                         .bold,
                                    //                 letterSpacing:
                                    //                     0.8),
                                    //           ),
                                    //         ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
