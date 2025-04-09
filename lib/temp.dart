// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:tima_app/app/DataBase/keys/keys.dart';
// import 'package:tima_app/app/core/GWidgets/btnText.dart';
// import 'package:tima_app/app/core/GWidgets/textfieldsStyle.dart';
// import 'package:tima_app/app/core/GWidgets/toast.dart';
// import 'package:tima_app/app/core/constants/apiUrlConst.dart';
// import 'package:tima_app/app/core/constants/colorConst.dart';
// import 'package:tima_app/app/core/constants/textconst.dart';
// import 'package:tima_app/app/feature/NavBar/Admin/controller/adminController.dart';
// import 'package:tima_app/app/feature/NavBar/home/homeNavBar.dart';
// import 'package:tima_app/app/providers/LocationProvider/location_provider.dart';

// class RequestAdmin extends StatefulWidget {
//   const RequestAdmin({Key? key, this.inqId}) : super(key: key);
//   final String? inqId;

//   @override
//   State<RequestAdmin> createState() => _RequestAdminState();
// }

// class _RequestAdminState extends AdminController {
//   String? personName;
//   bool isNO = true;
//   bool isEnqEndTime = false;
//   @override
//   void initState() {
//     super.initState();
//     locationProvider = LocationProvider();
//     clientController.addListener(_checkClientController);
//     vendorController.addListener(_checkVendorController);
//     locationProvider.updateLocation();
//     setState(() {
//       locationController = TextEditingController(
//         text: "${locationProvider.lat.value} , ${locationProvider.lng.value}",
//       );
//     });
//     getVisitStatus();
//     getClientFromApi();
//     getVendorFromApi();
//     getProductService();
//   }

//   @override
//   void dispose() {
//     clientController.removeListener(_checkClientController);
//     vendorController.removeListener(_checkVendorController);
//     super.dispose();
//   }

//   void _checkClientController() {
//     if (clientController.text.isEmpty) {
//       getClientFromApi();
//       setState(() {
//         selectedClientid = null;
//       });
//     }
//   }

//   void _checkVendorController() {
//     if (vendorController.text.isEmpty) {
//       getVendorFromApi();
//       setState(() {
//         selectedVendorid = null;
//       });
//     }
//   }

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       // backgroundColor: colorConst.backgroundcolor,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: txtHelper().heading1Text('VISIT', 23, blueColor),
//       ),
//       body: SingleChildScrollView(
//         child:
//          Container(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//           child: Column(
//             children: [
//               getVisitStatusModel.status != 0
//                   ? Column(
//                     children: [

//                       SizedBox(height: 10.h),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           lebelText(
//                             labelText:
//                                 selectedRadioTile == 1
//                                     ? 'Client Name'
//                                     : 'Vendor Name',
//                             size: 14.2,
//                             color: blueColor,
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 5.h),
//                       selectedRadioTile == 1
//                           ? Container(
//                             alignment: Alignment.centerLeft,
//                             width: size.width,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               color: tfColor,
//                             ),
//                             child: TextFormField(
//                               // readOnly: true,
//                               controller: clientController,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter client name';
//                                 }
//                                 return null;
//                               },
//                               decoration: InputDecoration(
//                                 hintText: "Client Name",
//                                 border: boarder,
//                                 focusedBorder: focusboarder,
//                                 errorBorder: errorboarder,
//                                 labelStyle: const TextStyle(fontSize: 14),
//                                 suffixIcon: GestureDetector(
//                                   onTap: () {
//                                     getClientFromApi();
//                                     clientController.clear();
//                                     selectedClientid = null;
//                                   },
//                                   child: const Icon(Icons.refresh),
//                                 ),
//                               ),
//                               onChanged: (text) {
//                                 isShowUi = true;
//                                 setState(() {
//                                   ClientList =
//                                       ClientList.where(
//                                         (item) => item['org_name']
//                                             .toLowerCase()
//                                             .contains(text.toLowerCase()),
//                                       ).toList();
//                                 });
//                                 log('${ClientList.first['id']}');
//                                 if (clientController.text.isEmpty) {
//                                   getClientFromApi();
//                                   clientController.clear();
//                                   selectedClientid = null;
//                                   setState(() {});
//                                 }
//                               },

//                               onTap: () {
//                                 isShowUi = true;
//                                 setState(() {});
//                               },
//                               // maxLength: 10,
//                               keyboardType: TextInputType.text,
//                               style: const TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           )
//                           : Container(),
//                       isShowUi != true
//                           ? Container()
//                           : ListView.builder(
//                             itemCount: ClientList.length,
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             scrollDirection: Axis.vertical,
//                             itemBuilder: (BuildContext context, int index) {
//                               var ClientLists = ClientList[index];
//                               return ListTile(
//                                 onTap: () {
//                                   isShowUi = false;
//                                   clientController.text =
//                                       ClientLists['org_name'].toString();
//                                   selectedClientid =
//                                       ClientLists['id'].toString();
//                                   log(
//                                     'ClientIDLB= >${selectedClientid = ClientLists['id']}',
//                                   );
//                                   setState(() {});
//                                 },
//                                 title: Text(
//                                   ClientLists['org_name'].toString(),
//                                   style: const TextStyle(
//                                     color: Colors.black54,
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 14.2,
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                       selectedRadioTile == 1
//                           ? SizedBox(height: 5.h)
//                           : Container(),
//                       selectedRadioTile == 2
//                           ? SizedBox(height: 5.h)
//                           : Container(),
//                       // SizedBox(
//                       //   height: 10.h,
//                       // ),
//                       selectedRadioTile == 2
//                           ? Container(
//                             alignment: Alignment.centerLeft,
//                             width: size.width,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               color: tfColor,
//                             ),
//                             child: TextFormField(
//                               // readOnly: true,
//                               controller: vendorController,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter vendor name';
//                                 }
//                                 return null;
//                               },
//                               decoration: InputDecoration(
//                                 hintText: "Vendor Name",
//                                 border: boarder,
//                                 focusedBorder: focusboarder,
//                                 errorBorder: errorboarder,
//                                 hintStyle: const TextStyle(fontSize: 14.5),
//                                 suffixIcon: GestureDetector(
//                                   onTap: () {
//                                     getVendorFromApi();
//                                     vendorController.clear();
//                                     selectedVendorid = null;
//                                   },
//                                   child: const Icon(Icons.refresh),
//                                 ),
//                               ),
//                               onChanged: (text) {
//                                 isShowUi2 = true;
//                                 setState(() {
//                                   VendorList =
//                                       VendorList.where(
//                                         (item) => item['org_name']
//                                             .toLowerCase()
//                                             .contains(text.toLowerCase()),
//                                       ).toList();
//                                 });
//                                 if (vendorController.text.isEmpty) {
//                                   getVendorFromApi();
//                                   vendorController.clear();
//                                   selectedVendorid = null;
//                                   setState(() {});
//                                 }
//                               },

//                               onTap: () {
//                                 isShowUi2 = true;
//                                 setState(() {});
//                               },
//                               // maxLength: 10,
//                               keyboardType: TextInputType.text,
//                               style: const TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           )
//                           : Container(),
//                       isShowUi2 != true
//                           ? Container()
//                           : ListView.builder(
//                             itemCount: VendorList.length,
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             scrollDirection: Axis.vertical,
//                             itemBuilder: (BuildContext context, int index) {
//                               var VendorLists = VendorList[index];
//                               return ListTile(
//                                 onTap: () {
//                                   isShowUi2 = false;
//                                   vendorController.text =
//                                       VendorLists['org_name'];
//                                   selectedVendorid = VendorLists['id'];
//                                   log(
//                                     'VendorID => ${selectedVendorid = VendorLists['id']}',
//                                   );
//                                   setState(() {});
//                                 },
//                                 title: Text(
//                                   VendorLists['org_name'],
//                                   style: const TextStyle(
//                                     color: Colors.black54,
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                       SizedBox(height: 20.h),
//                       startBtn, //*! start visit button
//                     ],
//                   )
//                   : Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 40,
//                           width: size.width,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: tfColor,
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Flexible(
//                                 fit: FlexFit.loose,
//                                 child: RadioListTile(
//                                   visualDensity: const VisualDensity(
//                                     vertical: -4,
//                                     horizontal: -4,
//                                   ),
//                                   value: 1,
//                                   activeColor: colorConst.primarycolor,
//                                   groupValue: selectedRadioTile,
//                                   title: const Text(
//                                     "Client",
//                                     style: TextStyle(
//                                       fontSize: 14.2,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   onChanged: (dynamic val) async {
//                                     setSelectedRadioTile(val);
//                                   },
//                                   selected: false,
//                                 ),
//                               ),
//                               Flexible(
//                                 fit: FlexFit.loose,
//                                 //color: Colors.red,
//                                 child: RadioListTile(
//                                   visualDensity: const VisualDensity(
//                                     vertical: -4,
//                                     horizontal: -4,
//                                   ),
//                                   value: 2,
//                                   groupValue: selectedRadioTile,
//                                   title: const Text(
//                                     "Vendor",
//                                     style: TextStyle(
//                                       fontSize: 14.2,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   onChanged: (dynamic val) {
//                                     setSelectedRadioTile(val);
//                                   },
//                                   activeColor: colorConst.primarycolor,
//                                   selected: false,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 10.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             lebelText(
//                               labelText:
//                                   selectedRadioTile == 1
//                                       ? 'Client Name'
//                                       : 'Vendor Name',
//                               size: 14.2,
//                               color: blueColor,
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 5.h),
//                         selectedRadioTile == 1
//                             ? Container(
//                               alignment: Alignment.centerLeft,
//                               padding: const EdgeInsets.only(left: 8),
//                               height: 60,
//                               width: size.width,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 color: tfColor,
//                                 border: Border.all(
//                                   width: 1,
//                                   color: Colors.grey.shade900,
//                                 ),
//                               ),
//                               child: Text(
//                                 getVisitStatusModel.data!.clientName.toString(),
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             )
//                             : Container(),

//                         selectedRadioTile == 1
//                             ? SizedBox(height: 5.h)
//                             : Container(),
//                         selectedRadioTile == 2
//                             ? SizedBox(height: 5.h)
//                             : Container(),
//                         // SizedBox(
//                         //   height: 10.h,
//                         // ),
//                         selectedRadioTile == 2
//                             ? Container(
//                               alignment: Alignment.centerLeft,
//                               padding: const EdgeInsets.only(left: 8),
//                               height: 60,
//                               width: size.width,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 color: tfColor,
//                                 border: Border.all(
//                                   width: 1,
//                                   color: Colors.grey.shade900,
//                                 ),
//                               ),
//                               child: Text(
//                                 getVisitStatusModel.data!.vendorName.toString(),
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             )
//                             : Container(),

//                         SizedBox(height: 10.h),
//                         if (getVisitStatusModel.data!.vendorId != null)
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               lebelText(
//                                 labelText: 'Person Name',
//                                 size: 14.2,
//                                 color: blueColor,
//                               ),
//                             ],
//                           ),
//                         SizedBox(height: 10.h),

//                         Container(
//                           alignment: Alignment.centerLeft,
//                           width: size.width,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: tfColor,
//                           ),
//                           child: TextFormField(
//                             initialValue: personName,
//                             // readOnly: true,
//                             // controller: personNameController,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter Person Name';
//                               }
//                               return null;
//                             },
//                             decoration: InputDecoration(
//                               hintText: "Person Name",
//                               border: boarder,
//                               focusedBorder: focusboarder,
//                               errorBorder: errorboarder,
//                               hintStyle: const TextStyle(fontSize: 14.5),
//                             ),
//                             onChanged: (name) {
//                               setState(() {
//                                 personName = name;
//                               });
//                               log(personName.toString());
//                             },
//                             // maxLength: 10,
//                             keyboardType: TextInputType.text,
//                             style: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 17,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             lebelText(
//                               labelText: 'Designation Name',
//                               size: 14.2,
//                               color: blueColor,
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10.h),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           width: size.width,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: tfColor,
//                           ),
//                           child: TextFormField(
//                             initialValue: personDesig,
//                             // readOnly: true,
//                             // controller: personDesignationController,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter Designation';
//                               }
//                               return null;
//                             },
//                             decoration: InputDecoration(
//                               hintText: "Designation Name",
//                               border: boarder,
//                               focusedBorder: focusboarder,
//                               errorBorder: errorboarder,
//                               hintStyle: const TextStyle(fontSize: 14.5),
//                             ),
//                             onChanged: (designation) {
//                               setState(() {
//                                 personDesig = designation;
//                               });
//                             },
//                             // maxLength: 10,
//                             keyboardType: TextInputType.text,
//                             style: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 17,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             lebelText(
//                               labelText: 'Contact No',
//                               size: 14.2,
//                               color: blueColor,
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 15.h),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           width: size.width,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: tfColor,
//                           ),
//                           child: TextFormField(
//                             initialValue: contactNo,
//                             // readOnly: true,
//                             // controller: personMobileNoController,
//                             maxLength: 10,
//                             keyboardType: TextInputType.number,

//                             validator: (value) {
//                               RegExp regex = RegExp(r'^[6-9][0-9]{9}$');
//                               if (value == null || value.isEmpty) {
//                                 return 'Please Enter Your Phone Number';
//                               } else if (!regex.hasMatch(value)) {
//                                 return 'Invalid Contact No';
//                               } else if (value.length != 10) {
//                                 return 'Phone Number is not valid';
//                               }
//                               return null;
//                             },

//                             decoration: InputDecoration(
//                               counterText: "",
//                               hintText: "Contact No",
//                               border: boarder,
//                               focusedBorder: focusboarder,
//                               errorBorder: errorboarder,
//                               hintStyle: const TextStyle(fontSize: 14.5),
//                             ),
//                             onChanged: (contact) {
//                               setState(() {
//                                 contactNo = contact;
//                               });
//                             },
//                             // maxLength: 10,
//                             style: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 17,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10.h),

//                         SizedBox(height: 10.h),

//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             lebelText(
//                               labelText: 'Select Product/Service',
//                               size: 14.2,
//                               color: blueColor,
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 5.h),
//                         Container(
//                           width: size.width,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: tfColor,
//                           ),
//                           child: FormField<String>(
//                             builder: (FormFieldState<String> state) {
//                               return InputDecorator(
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                 ),
//                                 child: DropdownButtonHideUnderline(
//                                   child: DropdownButton(
//                                     hint: const Text("Select Product/Service "),
//                                     value: productServiceTypeID,
//                                     isDense: true,
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         productServiceTypeID = newValue;
//                                       });
//                                       log(productServiceTypeID);
//                                     },
//                                     items:
//                                         productServiceType.map((value) {
//                                           return DropdownMenuItem(
//                                             value: value['id'],
//                                             child: Text(
//                                               value['name'].toString(),
//                                             ),
//                                             onTap: () {
//                                               setState(() {
//                                                 productServiceTypeID =
//                                                     value['id'];
//                                               });
//                                             },
//                                           );
//                                         }).toList(),
//                                   ),
//                                 ),
//                               );
//                             },
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please Select a Product';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         SizedBox(height: 10.h),
//                         const Text(
//                           "Order Done",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Flexible(
//                               fit: FlexFit.loose,
//                               child: RadioListTile<String>(
//                                 title: const Text("Yes"),
//                                 value: "yes",
//                                 groupValue: selectedOption,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedOption = value;
//                                     isNO = false;
//                                   });
//                                 },
//                               ),
//                             ),
//                             Flexible(
//                               fit: FlexFit.loose,
//                               child: RadioListTile<String>(
//                                 title: const Text("No"),
//                                 value: "no",
//                                 selected: isNO,
//                                 groupValue: selectedOption,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedOption = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             lebelText(
//                               labelText: 'Complaint',
//                               size: 14.2,
//                               color: blueColor,
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 5.h),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           width: size.width,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: tfColor,
//                           ),
//                           child: TextFormField(
//                             // readOnly: true,
//                             controller: quiryController,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter complaint';
//                               }
//                               return null;
//                             },
//                             decoration: InputDecoration(
//                               hintText: "Complaint",
//                               border: boarder,
//                               focusedBorder: focusboarder,
//                               errorBorder: errorboarder,
//                               hintStyle: const TextStyle(fontSize: 14.5),
//                             ),
//                             onChanged: (text) {
//                               setState(() {});
//                             },
//                             // maxLength: 10,
//                             keyboardType: TextInputType.text,
//                             style: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 17,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             lebelText(
//                               labelText: 'Remark',
//                               size: 14.2,
//                               color: blueColor,
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 5.h),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           width: size.width,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: tfColor,
//                           ),
//                           child: TextFormField(
//                             // readOnly: true,
//                             controller: remarkController,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter Your Remark';
//                               }
//                               return null;
//                             },
//                             decoration: InputDecoration(
//                               hintText: "Remark",
//                               border: boarder,
//                               focusedBorder: focusboarder,
//                               errorBorder: errorboarder,
//                               hintStyle: const TextStyle(fontSize: 14.5),
//                             ),
//                             onChanged: (text) {
//                               setState(() {});
//                             },
//                             // maxLength: 10,
//                             keyboardType: TextInputType.text,
//                             style: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 17,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 15.h),
//                         const Text(
//                           "Next Visit",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             const Icon(Icons.calendar_month),
//                             SizedBox(width: 8.h),
//                             lebelText(
//                               labelText: 'Select Date',
//                               size: 14.2,
//                               color: blueColor,
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 5.h),
//                         GestureDetector(
//                           onTap: () => selectDateByUser(context),
//                           child: Container(
//                             alignment: Alignment.center,
//                             height: 50,
//                             width: size.width,
//                             padding: const EdgeInsets.only(left: 10),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: tfColor,
//                             ),
//                             child: Text(
//                               selectedDate != null
//                                   ? "${selectedDate.toString().split(' ')[0]}"
//                                   : "Tap to Select Date",
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 color: blueColor,
//                               ),
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 32.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             const Icon(Icons.timer),
//                             SizedBox(width: 8.h),
//                             lebelText(
//                               labelText: 'Select Time',
//                               size: 14.2,
//                               color: blueColor,
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 5.h),
//                         GestureDetector(
//                           onTap: () => selectTimeByUser(context),
//                           child: Container(
//                             alignment: Alignment.center,
//                             height: 50,
//                             width: size.width,
//                             padding: const EdgeInsets.only(left: 10),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: tfColor,
//                             ),
//                             child: Text(
//                               selectedTime != null
//                                   ? "${selectedTime!.format(context)}"
//                                   : "Tap to Select Time",
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 color: blueColor,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 30.h),
//                         Consumer<LocationProvider>(
//                           builder: (_, ref, __) {
//                             return GestureDetector(
//                               onTap:
//                                   formloder == true
//                                       ? null
//                                       : () async {
//                                         List productServiceID = [];
//                                         // if (_formKey.currentState!.validate()) {
//                                         if (selectedRadioTile.toString() !=
//                                             '') {
//                                           if (selectedRadioTile == 1) {
//                                             if (productServiceTypeID != null) {
//                                               if (selectedOption != null) {
//                                                 ref.updateLocation();
//                                                 setState(() {
//                                                   formloder = true;
//                                                   // isEnqEndTime = true;
//                                                 });

//                                                 productServiceID.add(
//                                                   productServiceTypeID,
//                                                 );
//                                                 String? userid =
//                                                     await secureStorageService
//                                                         .getUserID(
//                                                           key:
//                                                               StorageKeys
//                                                                   .userIDKey,
//                                                         );
//                                                 String? usercompanyid =
//                                                     await secureStorageService
//                                                         .getUserCompanyID(
//                                                           key:
//                                                               StorageKeys
//                                                                   .companyIdKey,
//                                                         );

//                                                 EndDate =
//                                                     "${DateFormat("yyyy-MM-dd").format(DateTime.now())} ${DateFormat.Hms().format(DateTime.now())}";
//                                                 var body = ({
//                                                   'user_id': userid,
//                                                   "company_id": usercompanyid,
//                                                   'visit_id':
//                                                       getVisitStatusModel
//                                                           .data!
//                                                           .visitId
//                                                           .toString(),
//                                                   'visit_at': 'client',
//                                                   'client_id':
//                                                       getVisitStatusModel
//                                                           .data!
//                                                           .clientId
//                                                           .toString(),
//                                                   'start_at':
//                                                       getVisitStatusModel
//                                                           .data!
//                                                           .startAt
//                                                           .toString(),
//                                                   'end_at': EndDate.toString(),
//                                                   'person_name': personName,
//                                                   'person_desi': personDesig,
//                                                   'person_mobile': contactNo,
//                                                   'product_service':
//                                                       productServiceID
//                                                           .toString(),
//                                                   'query_complaint':
//                                                       quiryController.text,
//                                                   'order_done': selectedOption,
//                                                   'next_visit':
//                                                       selectedDate != null
//                                                           ? '${selectedDate.toString().split(' ')[0]} ${selectedTime!.format(context)}'
//                                                           : '',
//                                                   'remark':
//                                                       remarkController.text,
//                                                   "inq_id": widget.inqId ?? '0',
//                                                   'location':
//                                                       "${ref.lat.value},${ref.lng.value}",
//                                                 });
//                                                 log(
//                                                   "postAPICall Visit body :$body",
//                                                 );
//                                                 var result = await http.post(
//                                                   Uri.parse(
//                                                     endVisitApiUrlEndPoint,
//                                                   ),
//                                                   body: body,
//                                                 );
//                                                 // request.files.add(
//                                                 //     await http.MultipartFile
//                                                 //         .fromPath('person_image',
//                                                 //            image ==null ? imgOnPressed() : image!.path));
//                                                 // var result = await ApiBaseHelper()

//                                                 log(
//                                                   "postAPICall Enquiry response==> ${result.body} ",
//                                                 );
//                                                 setState(() {
//                                                   formloder = false;
//                                                 });
//                                                 if (result.statusCode == 200) {
//                                                   var responsedata = jsonDecode(
//                                                     result.body,
//                                                   );
//                                                   if (responsedata['valid_status'] ==
//                                                       1) {
//                                                     Navigator.of(
//                                                       context,
//                                                     ).pushReplacement(
//                                                       MaterialPageRoute(
//                                                         builder:
//                                                             (_) => HomeNavBar(),
//                                                       ),
//                                                     );
//                                                   } else {
//                                                     await Future.delayed(
//                                                       Duration(seconds: 15),
//                                                       () {
//                                                         Navigator.of(
//                                                           context,
//                                                         ).pushReplacement(
//                                                           MaterialPageRoute(
//                                                             builder:
//                                                                 (_) =>
//                                                                     HomeNavBar(),
//                                                           ),
//                                                         );
//                                                       },
//                                                     );
//                                                     toastMsg(
//                                                       "${responsedata['message']}",
//                                                       true,
//                                                     );
//                                                   }
//                                                   // GoRouter.of(context)
//                                                   //     .goNamed(routerConst
//                                                   //         .homeNavBar);
//                                                   log(
//                                                     "Create Enquiry registration ==>$body",
//                                                   );
//                                                   log(
//                                                     "Create Enquiry registration==> ${result.body} ",
//                                                   );
//                                                   toastMsg(
//                                                     "${responsedata['message']}",
//                                                     false,
//                                                   );
//                                                 } else {
//                                                   // GoRouter.of(context)
//                                                   //     .goNamed(routerConst
//                                                   //         .homeNavBar);
//                                                   var responsedata = jsonDecode(
//                                                     result.body,
//                                                   );
//                                                   toastMsg(
//                                                     "${responsedata['message']}",
//                                                     false,
//                                                   );
//                                                 }
//                                               } else {
//                                                 toastMsg(
//                                                   "Please Select Order is done or not",
//                                                   true,
//                                                 );
//                                               }
//                                             } else {
//                                               toastMsg(
//                                                 "Please Select Services",
//                                                 true,
//                                               );
//                                             }
//                                             // } else {
//                                             //   toastMsg("Please Select Image", true);
//                                             // }
//                                             // } else {
//                                             //   toastMsg(
//                                             //       "Please Select Start Time",
//                                             //       true);
//                                             // }
//                                             // }
//                                             //  else {
//                                             //   toastMsg("Please Select Client",
//                                             //       true);
//                                             // }
//                                           } else {
//                                             // if (selectedVendorid != null) {
//                                             // if (selectedStartTime != null) {
//                                             // if (image != null) {
//                                             if (productServiceTypeID != null) {
//                                               if (selectedOption != null) {
//                                                 ref.updateLocation();
//                                                 setState(() {
//                                                   formloder = true;
//                                                 });
//                                                 productServiceID.add(
//                                                   productServiceTypeID,
//                                                 );

//                                                 String? userid =
//                                                     await secureStorageService
//                                                         .getUserID(
//                                                           key:
//                                                               StorageKeys
//                                                                   .userIDKey,
//                                                         );
//                                                 String? usercompanyid =
//                                                     await secureStorageService
//                                                         .getUserCompanyID(
//                                                           key:
//                                                               StorageKeys
//                                                                   .companyIdKey,
//                                                         );
//                                                 EndDate =
//                                                     "${DateFormat("yyyy-MM-dd").format(DateTime.now())} ${DateFormat.Hms().format(DateTime.now())}";
//                                                 var body = ({
//                                                   'user_id': userid,
//                                                   "company_id": usercompanyid,
//                                                   'visit_at': 'vendor',
//                                                   'visit_id':
//                                                       getVisitStatusModel
//                                                           .data!
//                                                           .visitId
//                                                           .toString(),
//                                                   'client_id':
//                                                       getVisitStatusModel
//                                                           .data!
//                                                           .vendorId
//                                                           .toString(),
//                                                   'start_at':
//                                                       getVisitStatusModel
//                                                           .data!
//                                                           .startAt
//                                                           .toString(),
//                                                   // selectedStartTime ==
//                                                   //         null
//                                                   //     ? ''
//                                                   //     : "${DateFormat("yyyy-MM-dd").format(DateTime.now())} ${selectedStartTime!.format(context).toString()}",
//                                                   'end_at': EndDate.toString(),
//                                                   'person_name': personName,
//                                                   'person_desi': personDesig,
//                                                   'person_mobile': contactNo,
//                                                   'product_service':
//                                                       productServiceID
//                                                           .toString(),
//                                                   'query_complaint':
//                                                       quiryController.text,
//                                                   'order_done': selectedOption,
//                                                   'next_visit':
//                                                       selectedDate != null
//                                                           ? '${selectedDate.toString().split(' ')[0]} ${selectedTime!.format(context)}'
//                                                           : '',
//                                                   'remark':
//                                                       remarkController.text,
//                                                   "inq_id": widget.inqId ?? '0',
//                                                   'location':
//                                                       "${ref.lat.value},${ref.lng.value}",
//                                                 });
//                                                 log("check body :=> $body ");
//                                                 final result = await http.post(
//                                                   Uri.parse(
//                                                     endVisitApiUrlEndPoint,
//                                                   ),
//                                                   body: body,
//                                                 );

//                                                 log(
//                                                   "postAPICall Enquiry response ==> ${result.body}",
//                                                 );
//                                                 setState(() {
//                                                   formloder = false;
//                                                 });

//                                                 if (result.statusCode == 200) {
//                                                   var responsedata = jsonDecode(
//                                                     result.body,
//                                                   );
//                                                   log(
//                                                     "Create Enquiry registration ==>$body",
//                                                   );
//                                                   log(
//                                                     "Create Enquiry registration ==> ${result.body}",
//                                                   );
//                                                   if (responsedata['valid_status'] ==
//                                                       1) {
//                                                     Navigator.of(
//                                                       context,
//                                                     ).pushReplacement(
//                                                       MaterialPageRoute(
//                                                         builder:
//                                                             (_) => HomeNavBar(),
//                                                       ),
//                                                     );
//                                                     await Future.delayed(
//                                                       Duration(seconds: 15),
//                                                       () {
//                                                         Navigator.of(
//                                                           context,
//                                                         ).pushReplacement(
//                                                           MaterialPageRoute(
//                                                             builder:
//                                                                 (_) =>
//                                                                     HomeNavBar(),
//                                                           ),
//                                                         );
//                                                       },
//                                                     );
//                                                     toastMsg(
//                                                       "${responsedata['message']}",
//                                                       false,
//                                                     );
//                                                   } else {
//                                                     toastMsg(
//                                                       "${responsedata['message']}",
//                                                       true,
//                                                     );
//                                                   }
//                                                 } else {
//                                                   var responsedata = jsonDecode(
//                                                     result.body,
//                                                   );
//                                                   // GoRouter.of(context)
//                                                   //     .goNamed(routerConst
//                                                   //         .homeNavBar);

//                                                   appToastMsg(
//                                                     "${responsedata['message']}",
//                                                   );
//                                                 }
//                                               } else {
//                                                 toastMsg(
//                                                   "Please Select Order is done or not",
//                                                   true,
//                                                 );
//                                               }
//                                             } else {
//                                               toastMsg(
//                                                 "Please Select Services",
//                                                 true,
//                                               );
//                                             }
//                                             // } else {
//                                             //   toastMsg("Please Select Image", true);
//                                             // }
//                                             // } else {
//                                             //   toastMsg(
//                                             //       "Please Select Start Time",
//                                             //       true);
//                                             // }
//                                             // } else {
//                                             //   toastMsg("Please Select Vendor",
//                                             //       true);
//                                             // }
//                                           }
//                                         } else {
//                                           toastMsg(
//                                             "Please Select Visit Type",
//                                             true,
//                                           );
//                                         }
//                                         // }

//                                         // GoRouter.of(context)
//                                         //     .goNamed(routerConst.homeNavBar);
//                                       },
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 height: size.height * 0.073,
//                                 width: size.width,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: blueColor,
//                                 ),
//                                 child: Text(
//                                   formloder == true
//                                       ? "Please wait.."
//                                       : "End Visit",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: size.height * 0.020,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         SizedBox(height: 30.h),
//                       ],
//                     ),
//                   ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
