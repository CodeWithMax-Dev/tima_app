// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tima_app/app/core/constants/colorConst.dart';

// Widget buildInfoRow(String label, String value) {
//   return Padding(
//     padding: EdgeInsets.only(bottom: 8.h),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: 120.w,
//           child: Text(
//             label,
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         SizedBox(width: 8.w),
//         Expanded(
//           child: Text(
//             value,
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: Colors.black87,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget buildTabContent(
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
//           buildDateSelectors(size, isStartDate, isEndDate),
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
