// // ignore_for_file: unused_local_variable

// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:tima_app/app/ApiService/postApiBaseHelper.dart';
// import 'package:tima_app/app/DataBase/dataHub/secureStorageService.dart';
// import 'package:tima_app/app/DataBase/keys/keys.dart';
// import 'package:tima_app/app/core/constants/apiUrlConst.dart';
// import 'package:tima_app/app/core/models/attendancemodel.dart';
// import 'package:tima_app/app/core/models/enquiryviewdetailmodel.dart';
// import 'package:tima_app/app/core/models/next_visit_model.dart';
// import 'package:tima_app/app/core/models/nextvisitmodel.dart';
// import 'package:tima_app/app/feature/NavBar/report/screen/reportList.dart';

// abstract class ReportScreenBuilder extends State<Reportlist> {
//   final SecureStorageService _secureStorageService = SecureStorageService();

//   final client = http.Client();
//   dynamic startDateController;
//   dynamic endDateController;
//   var nextVisitLoad = false;

//   List<DatumNextVisit> nextVisitDataModelList = [];

//   DateTime selectedDate = DateTime.now();
//   DateTime selectedEndDate = DateTime.now();
//   String nextVisitMessage = '';
//   List<Datum> nextVisitDataList = [];

//   List<DataList> inquiryVisitDetailList = [];
//   String inquiryVisitMessage = '';
//   // * attendence tab

//   List<AttDatum> attendanceDataList = [];
//   var attendanceDataLoad = false;
//   String attendanceMessage = '';

//   var enquiryVisitDetailLoad = false;

//   @override
//   void initState() {
//     startDateController = DateFormat('yyyy-MM-dd').format(selectedDate);
//     endDateController = DateFormat('yyyy-MM-dd').format(selectedEndDate);
//     getNextVisitApi();
//     getEnquiryDetailApi();
//     getAttendance();
//     super.initState();
//   }

//   Future<void> selectStartDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//       initialDatePickerMode: DatePickerMode.day,
//     );

//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//         var date = DateFormat.yMd().format(selectedDate);
//         startDateController = DateFormat('yyyy-MM-dd').format(selectedDate);
//         if (endDateController != "") {
//           getNextVisitApi();
//           getEnquiryDetailApi();
//           getAttendance();
//         }
//       });
//     }
//   }

//   Future<void> selectEndDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//       initialDatePickerMode: DatePickerMode.day,
//     );
//     if (picked != null) {
//       setState(() {
//         selectedEndDate = picked;
//         endDateController = DateFormat('yyyy-MM-dd').format(selectedEndDate);
//         getNextVisitApi();
//         getEnquiryDetailApi();
//         getAttendance();
//       });
//     }
//   }

//   void getNextVisitApi() async {
//     nextVisitLoad = true;
//     setState(() {});
//     String? userID = await _secureStorageService.getUserID(
//       key: StorageKeys.userIDKey,
//     );
//     var body = ({
//       'user_id': userID.toString(),
//       'from_date': startDateController.toString(),
//       'to_date': endDateController.toString(),
//     });
//     var url = show_next_visit_app_url;

//     var response = await ApiBaseHelper().postAPICall(Uri.parse(url), body);

//     if (response.statusCode == 200) {
//       var decodedResponse = jsonDecode(response.body);

//       log("client NextVisitModel body -->body");
//       log("client NextVisitModel response -->${response.body}");
//       print("client NextVisitModel response -->${response.body}");

//       NextVisitModel nextVisitModel = NextVisitModel.fromJson(decodedResponse);

//       nextVisitMessage = nextVisitModel.message;

//       nextVisitDataModelList = nextVisitModel.data;

//       Fluttertoast.showToast(msg: decodedResponse['message']);
//     }
//     nextVisitLoad = false;
//     setState(() {});
//   }

//   Future<void> getEnquiryDetailApi() async {
//     enquiryVisitDetailLoad = true;

//     setState(() {});

//     String? userID = await _secureStorageService.getUserID(
//       key: StorageKeys.userIDKey,
//     );
//     var body = ({
//       'user_id': userID.toString(),
//       'id': "0",
//       'from_date': startDateController,
//       'to_date': endDateController,
//     });

//     var url = get_visit_data_url;
//     log("client getenquiry_detail body --$url");
//     log("client getenquiry_detail body -->$body ");

//     var response = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
//     log("client getenquiry_detail response --> ${response.body}");
//     if (response.statusCode == 200) {
//       var responseData = jsonDecode(response.body);
//       var enquiryVisitDetail = GetEnquiryViewDetailModel.fromJson(responseData);
//       inquiryVisitDetailList = enquiryVisitDetail.data;
//       inquiryVisitMessage = enquiryVisitDetail.message;

//       log(
//         "client getenquiryView_detail response -->${nextVisitDataList.length} ",
//       );
//       enquiryVisitDetailLoad = false;

//       // Fluttertoast.showToast(msg: responseData['message']);
//     }
//     enquiryVisitDetailLoad = false;
//     setState(() {});
//   }

//   void getAttendance() async {
//     attendanceDataLoad = true;
//     setState(() {});
//     String? userID = await _secureStorageService.getUserID(
//       key: StorageKeys.userIDKey,
//     );
//     var body = ({
//       'user_id': userID.toString(),
//       'from_date': startDateController,
//       'to_date': endDateController,
//     });

//     var url = show_attendance_app_url;
//     log("client attendancedata body $body");
//     var response = await ApiBaseHelper().postAPICall(Uri.parse(url), body);
//     log("client attendancedata response $response.body");
//     if (response.statusCode == 200) {
//       var responseData = jsonDecode(response.body);
//       var attendanceData = AttendanceModel.fromJson(responseData);
//       attendanceMessage = attendanceData.message;
//       attendanceDataList = attendanceData.data;
//     }
//     attendanceDataLoad = false;
//     setState(() {});
//   }

//    Widget _buildTabContent(
//     Size size, {
//     required bool isStartDate,
//     required bool isEndDate,
//     required bool isLoading,
//     required bool isEmpty,
//     required String emptyMessage,
//     required int itemCount,
//     required Widget Function(BuildContext, int) itemBuilder,
//   }) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//       child: Column(
//         children: [
//           _buildDateSelectors(size, isStartDate, isEndDate),
//           SizedBox(height: 16.h),
//           Expanded(
//             child:
//                 isLoading
//                     ? const Center(child: CircularProgressIndicator.adaptive())
//                     : isEmpty
//                     ? Center(
//                       child: Text(
//                         emptyMessage,
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w500,
//                           color: colorConst.primarycolor,
//                         ),
//                       ),
//                     )
//                     : ListView.builder(
//                       physics: const BouncingScrollPhysics(),
//                       itemCount: itemCount,
//                       itemBuilder: itemBuilder,
//                     ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDateSelectors(Size size, bool showStart, bool showEnd) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (showStart) ...[
//             Text(
//               'Start Date',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w600,
//                 color: colorConst.primarycolor,
//               ),
//             ),
//             SizedBox(height: 8.h),
//             _buildDateSelector(
//               size,
//               startDateController.toString(),
//               () => selectStartDate(context),
//             ),
//           ],
//           if (showEnd) ...[
//             SizedBox(height: 16.h),
//             Text(
//               'End Date',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w600,
//                 color: colorConst.primarycolor,
//               ),
//             ),
//             SizedBox(height: 8.h),
//             _buildDateSelector(
//               size,
//               endDateController.toString(),
//               () => selectEndDate(context),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildDateSelector(Size size, String date, VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(10.r),
//       child: Container(
//         height: 50.h,
//         width: size.width,
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         decoration: BoxDecoration(
//           color: Colors.grey[50],
//           borderRadius: BorderRadius.circular(10.r),
//           border: Border.all(color: Colors.grey[200]!),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               Icons.calendar_today_rounded,
//               size: 20.sp,
//               color: colorConst.primarycolor,
//             ),
//             SizedBox(width: 12.w),
//             Text(
//               date,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.black87,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNextVisitCard(dynamic details) {
//     return Card(
//       margin: EdgeInsets.only(bottom: 12.h),
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         side: BorderSide(color: Colors.grey[200]!),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildInfoRow("Client/Vendor", details.client ?? 'N/A'),
//             _buildInfoRow("Product/Service", details.productService ?? 'N/A'),
//             _buildInfoRow(
//               "Last Visit",
//               DateFormat.yMd().add_jm().format(details.startAt ?? 'N/A'),
//             ),
//             _buildInfoRow(
//               "Next Visit",
//               DateFormat.yMd().add_jm().format(details.nextVisit ?? 'N/A'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildVisitCard(dynamic details) {
//     return Card(
//       margin: EdgeInsets.only(bottom: 12.h),
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         side: BorderSide(color: Colors.grey[200]!),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildInfoRow("Visit At", details.visitAt ?? 'N/A'),
//             _buildInfoRow(
//               "Client/Vendor",
//               details.vendor ?? details.client ?? 'N/A',
//             ),
//             _buildInfoRow("Product/Services", details.productService ?? 'N/A'),
//             _buildInfoRow(
//               "Visit Date",
//               DateFormat.yMMMMd('en_US').format(details.startAt! ?? 'N/A'),
//             ),
//             _buildInfoRow("Person Name", details.personName ?? 'N/A'),
//             _buildInfoRow("Person Mobile", details.personMobile ?? 'N/A'),
//             _buildInfoRow("Duration", details.duration ?? 'N/A'),
//             _buildInfoRow("Order", details.orderDone ?? 'N/A'),
//             _buildInfoRow("Complaints", details.queryComplaint ?? 'N/A'),
//             _buildInfoRow("Remark", details.remark ?? 'N/A'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAttendanceCard(dynamic details) {
//     return Card(
//       margin: EdgeInsets.only(bottom: 12.h),
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         side: BorderSide(color: Colors.grey[200]!),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildInfoRow("Date", details.attDate ?? 'N/A'),
//             _buildInfoRow("Check In", details.inTime ?? "N/A"),
//             _buildInfoRow("Check Out", details.outTime ?? "N/A"),
//             _buildInfoRow("Status", details.status ?? 'N/A'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 8.h),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 120.w,
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.grey[600],
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           SizedBox(width: 8.w),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.black87,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }









  // _buildTabContent(
            //   size,
            //   isStartDate: isShowNxtVisitStartLabel,
            //   isEndDate: isShowNxtVisitEndLabel,
            //   isLoading: nextVisitLoad,
            //   isEmpty: nextVisitDataModelList.isEmpty,
            //   emptyMessage: nextVisitMessage,
            //   itemCount: nextVisitDataModelList.length,
            //   itemBuilder:
            //       (context, index) =>
            //           _buildNextVisitCard(nextVisitDataModelList[index]),
            // ),
            // _buildTabContent(
            //   size,
            //   isStartDate: isShowInquriyStartLabel,
            //   isEndDate: isShowInquiryEndLabel,
            //   isLoading: enquiryVisitDetailLoad,
            //   isEmpty: inquiryVisitDetailList.isEmpty,
            //   emptyMessage: inquiryVisitMessage.toString(),
            //   itemCount: inquiryVisitDetailList.length,
            //   itemBuilder:
            //       (context, index) =>
            //           _buildVisitCard(inquiryVisitDetailList[index]),
            // ),
            // _buildTabContent(
            //   size,
            //   isStartDate: isShowAttendencStartLabel,
            //   isEndDate: isShowAttendenceEndLabel,
            //   isLoading: attendanceDataLoad,
            //   isEmpty: attendanceDataList.isEmpty,
            //   emptyMessage: attendanceMessage,
            //   itemCount: attendanceDataList.length,
            //   itemBuilder:
            //       (context, index) =>
            //           _buildAttendanceCard(attendanceDataList[index]),
            // ),