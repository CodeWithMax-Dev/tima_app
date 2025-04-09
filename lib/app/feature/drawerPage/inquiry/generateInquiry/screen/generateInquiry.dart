// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';
import 'package:tima_app/app/core/constants/textconst.dart';
import 'package:tima_app/app/feature/NavBar/home/homeNavBar.dart';
import 'package:tima_app/app/feature/drawerPage/inquiry/generateInquiry/builder/genEnqBuilder.dart';

class Generateinquiry extends StatefulWidget {
  const Generateinquiry({super.key});

  @override
  State<Generateinquiry> createState() => _GenerateinquiryState();
}

class _GenerateinquiryState extends GenEnqBuilder {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                // GoRouter.of(context).pushNamed(routerConst.homeNavBar);
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => HomeNavBar()));
              },
            ),
          ),
        ),
        centerTitle: true,
        title: txtHelper().heading1Text('GENERATED ENQUIRY', 21, blueColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.h),
            const Text('OP Status'),
            SizedBox(height: 10.h),
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
                                    getSelectOpStatusGenEnqDetails(
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
            SizedBox(height: 20.h),
            getEnqLoad
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
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: getEnqDetailModel.data!.length,
                    itemBuilder: (context, index) {
                      var genEnqList = getEnqDetailModel.data![index];
                      return Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: tfColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Generated On : ${genEnqList.dateTime}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Generated By : ${genEnqList.userName}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Contact No. : ${genEnqList.userMobile}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Enquery Type : ${genEnqList.enqTypeName}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Enquiry For : ${genEnqList.personName},${genEnqList.branchName}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Contact No.: ${genEnqList.personMobile}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Product/Service : ${genEnqList.productServiceType} (${genEnqList.productServiceName})",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Client: ${genEnqList.client} ",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Contact Person : ${genEnqList.personName} ",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Contact No.: ${genEnqList.contactNo} ",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Client/Vendor Name : ${genEnqList.currentVendor}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Current price : ${genEnqList.currentPrice}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Target Buisness : ${genEnqList.targetBusiness}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Remark: ${genEnqList.remark} ",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Status: ${genEnqList.opStatus} ",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              ),
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
