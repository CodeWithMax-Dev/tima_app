// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tima_app/app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/app/DataBase/keys/keys.dart';
import 'package:tima_app/app/core/constants/apiUrlConst.dart';
import 'package:tima_app/app/providers/inquireyProvider/inquiry_provider.dart';
import 'package:tima_app/app/router/routeParams/nextVisitParams.dart';
import 'package:tima_app/app/router/routes/routerConst.dart';

class VisitDeatil extends StatefulWidget {
  final VisitDetailScreenParams visitDetailScreenParams;
  const VisitDeatil({super.key, required this.visitDetailScreenParams});

  @override
  State<VisitDeatil> createState() => _VisitDeatilState();
}

class _VisitDeatilState extends State<VisitDeatil> {
  final SecureStorageService _secureStorageService = SecureStorageService();
  InquiryProvider inquiryProvider = InquiryProvider();
  var carres;
  List cardatalist = [];
  List imageSliders = ['assets/banner.jpg', 'assets/banner1.jpg'];

  @override
  void initState() {
    getenquirydataapi();
    super.initState();
  }

  Future<void> getenquirydataapi() async {
    var url = get_visit_data_url;
    String? userID = await _secureStorageService.getUserID(
      key: StorageKeys.userIDKey,
    );
    var body = ({
      'user_id': userID.toString(),
      'id': widget.visitDetailScreenParams.indexlistno,
      'from_date': '',
      'to_date': '',
    });

    inquiryProvider.getVisitDetailapi(url, body);
  }

  @override
  Widget build(BuildContext context) {
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
                GoRouter.of(context).goNamed(routerConst.homeNavBar);
              },
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Visit Detail list',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            'Update of product related enquiry :\n\n${widget.visitDetailScreenParams.name}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              letterSpacing: 1,
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.bold,
            ),
          ),
          Consumer<InquiryProvider>(
            builder: (_, ref, __) {
              if (ref.enquiryvisitdetailload) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ref.enquiryvisiDetail.data.length,
                  itemBuilder: (context, index) {
                    var InquiryDetails = ref.enquiryvisiDetail.data[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: [
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Visit At : ${InquiryDetails.visitAt}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Client/Vendor : ${InquiryDetails.vendor ?? InquiryDetails.client}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Product/Services : ${InquiryDetails.productService}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Visit Date : ${DateFormat.yMMMMd('en_US').format(InquiryDetails.startAt!)}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Person Name : ${InquiryDetails.personName}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "ContactNO : ${InquiryDetails.personMobile}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Duration : ${InquiryDetails.duration}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Order : ${InquiryDetails.orderDone}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Complaints : ${InquiryDetails.queryComplaint}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Remark : ${InquiryDetails.remark}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
