// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import 'package:tima_app/app/ApiService/postApiBaseHelper.dart';
import 'package:tima_app/app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/app/DataBase/keys/keys.dart';
import 'package:tima_app/app/core/GWidgets/textfieldsStyle.dart';
import 'package:tima_app/app/core/GWidgets/toast.dart';
import 'package:tima_app/app/core/constants/apiUrlConst.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';
import 'package:tima_app/app/core/constants/textconst.dart';
import 'package:tima_app/app/core/models/lat_lng_model.dart';
import 'package:tima_app/app/feature/Auth/register/builder/registerController.dart';
import 'package:tima_app/app/feature/NavBar/home/homeNavBar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key, this.latLng, this.inqId}) : super(key: key);
  final LatLng? latLng;
  final String? inqId;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends RegisterController {
  GlobalKey<FormState> registerkey = GlobalKey<FormState>();
  final SecureStorageService _secureStorageService = SecureStorageService();
  @override
  var selectedRadioTile;
  @override
  // late LocationProvider locationProvider;
  // late LatLng latLng;
  @override
  void initState() {
    super.initState();

    setState(() {
      selectedRadioTile = 1;

      addpersondetail();
    });
    clientVendorRegistration();
    getStateFromApi();
    getProdcutServicesFromApi();
    getServices();
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  addpersondetail() {
    setState(() {
      final startcontroller = TextEditingController();
      final endcontroller = TextEditingController();
      final emailcontroller = TextEditingController();
      final fiels1 = TextFormField(
        cursorColor: Colors.grey,
        enableInteractiveSelection: true,
        // onTap: () async {

        // },
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2,
        ),
        decoration: InputDecoration(
          hintText: "Contact Person",
          labelText: "Contact Person${startController.length + 1}",
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.2,
          ),
          isDense: true,
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 1.2,
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        controller: startcontroller,
        readOnly: false,
        // validator: ((value) {
        //   if (value == null || value == '') {
        //     return "Contact person Required";
        //   } else {
        //     return null;
        //   }
        // }),
      );
      final fiels2 = TextFormField(
        cursorColor: Colors.grey,
        enableInteractiveSelection: false,
        maxLength: 10,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        // onTap: () async {

        // },
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2,
        ),
        decoration: InputDecoration(
          hintText: "Contact Mobile",
          labelText: "Contact Mobile${endController.length + 1}",
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          counterText: "",
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.2,
          ),
          isDense: true,
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 1.2,
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        controller: endcontroller,
        // validator: ((value) {
        //   if (value == null || value == '') {
        //     return "Contact Number Required";
        //   } else {
        //     return null;
        //   }
        // }),
      );
      final fiels3 = TextFormField(
        cursorColor: Colors.grey,
        enableInteractiveSelection: false,
        // onTap: () async {
        // },
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2,
        ),
        decoration: const InputDecoration(
          hintText: "Contact Email",
          // labelText: "Contact Email${emailcontroller.length + 1}",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.2,
          ),
          isDense: true,
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            letterSpacing: 1.2,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        controller: emailcontroller,
        // validator: form_validation().validateEmail,
      );

      final field = TextField(
        controller: endcontroller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          // labelText: "name${_emailcontrollers.length + 1}",
        ),
      );

      setState(() {
        startController.add(startcontroller);
        endController.add(endcontroller);
        emailcontrollers.add(emailcontroller);
        fields1.add(fiels1);
        log("_field-->${fields1.length}");
        fields2.add(fiels2);
        fields3.add(fiels3);
        fields.add(field);
      });
    });
  }

  Widget _addTile() {
    return ListTile(
      title: Container(
        height: 60,
        width: 290,
        decoration: BoxDecoration(
          border: Border.all(color: colorConst.primarycolor),
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.add),
            Center(
              child: Text(
                'Add Contact',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: colorConst.primarycolor,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        final startcontroller = TextEditingController();
        final endcontroller = TextEditingController();
        final emailcontroller = TextEditingController();
        final fiels1 = TextFormField(
          cursorColor: Colors.grey,
          enableInteractiveSelection: true,
          // onTap: () async {

          // },
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.2,
          ),
          decoration: InputDecoration(
            hintText: "Contact Person",
            labelText: "Contact Person${startController.length + 1}",
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.2,
            ),
            isDense: true,
            errorStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          controller: startcontroller,
          readOnly: false,
          validator: ((value) {
            if (value == null || value == '') {
              return "Contact person Required";
            } else {
              return null;
            }
          }),
        );
        final fiels2 = TextFormField(
          cursorColor: Colors.grey,
          enableInteractiveSelection: false,
          maxLength: 10,
          keyboardType: TextInputType.number,

          // validator: form_validation().validatephonenumber,
          // onTap: () async {

          // },
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.2,
          ),
          decoration: InputDecoration(
            hintText: "Contact Mobile",
            counterText: "",
            labelText: "Contact Mobile${endController.length + 1}",
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.2,
            ),
            isDense: true,
            errorStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          controller: endcontroller,
          validator: ((value) {
            if (value == null || value == '') {
              return "Contact Number Required";
            } else {
              return null;
            }
          }),
        );
        final fiels3 = TextFormField(
          cursorColor: Colors.grey,
          enableInteractiveSelection: false,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.2,
          ),
          decoration: InputDecoration(
            hintText: "Contact Email",
            labelText: "Contact Email${emailcontrollers.length + 1}",
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.2,
            ),
            isDense: true,
            errorStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          controller: emailcontroller,
          //  validator: form_validation().validateEmail,
        );
        final field = TextField(
          controller: endcontroller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: "name${emailcontrollers.length + 1}",
          ),
        );

        setState(() {
          startController.add(startcontroller);
          endController.add(endcontroller);
          emailcontrollers.add(emailcontroller);
          fields1.add(fiels1);
          log("_field--> ${fields1.length}");
          fields2.add(fiels2);
          fields3.add(fiels3);
          fields.add(field);
        });
      },
    );
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: fields.length,
      // itemCount: 1,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          // color: Colors.red,
          margin: const EdgeInsets.all(5),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    log("startController : $index");
                    startController.removeAt(index);
                    endController.removeAt(index);
                    emailcontrollers.removeAt(index);
                    fields1.removeAt(index);
                    fields2.removeAt(index);
                    fields3.removeAt(index);
                    fields.removeAt(index);
                  });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.delete_forever, color: Colors.red),
                    ),
                    Text(
                      "Remove",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              fields1[index],
              SizedBox(height: 20.h),
              fields2[index],
              SizedBox(height: 15.h),
              fields3[index],
              SizedBox(height: 15.h),
              // _fields[index],
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      // backgroundColor: colorConst.backgroundcolor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: 40,
          ),
          child: Form(
            key: registerkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Center(
                  child: txtHelper().heading1Text(
                    'REGISTRATION',
                    21,
                    blueColor,
                  ),
                ),
                SizedBox(height: 30.h),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: tfColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: RadioListTile(
                          visualDensity: const VisualDensity(
                            vertical: -4,
                            horizontal: -4,
                          ),
                          value: 1,
                          activeColor: colorConst.primarycolor,
                          groupValue: selectedRadioTile,
                          title: const Text(
                            "Client",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onChanged: (dynamic val) async {
                            setSelectedRadioTile(val);

                            nameController.clear();
                            emailController.clear();
                            mobileController.clear();
                            pinController.clear();
                            webController.clear();
                            addressController.clear();
                          },
                          selected: false,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        //color: Colors.red,
                        child: RadioListTile(
                          visualDensity: const VisualDensity(
                            vertical: -4,
                            horizontal: -4,
                          ),
                          value: 2,
                          groupValue: selectedRadioTile,
                          title: const Text(
                            "Vendor",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onChanged: (dynamic val) {
                            setSelectedRadioTile(val);
                          },
                          activeColor: colorConst.primarycolor,
                          selected: false,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  'Organization Name',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: blueColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: tfColor,
                  ),
                  width: size.width,
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Please Enter Your Name';
                      }
                      return null; //changes
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(CupertinoIcons.building_2_fill),
                      hintText: "Organization Name",
                      border: boarder,
                      focusedBorder: focusboarder,
                      errorBorder: errorboarder,
                    ),
                    onChanged: (text) {
                      setState(() {
                        if (text.isNotEmpty) {
                          errororgname = true;
                        }
                      });
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
                SizedBox(height: 12.h),
                Text(
                  'Email',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: blueColor,
                  ),
                ),
                SizedBox(height: 10.h),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: tfColor,
                  ),
                  width: size.width,
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      Pattern pattern =
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?)*$";
                      RegExp regex = RegExp(pattern.toString());
                      if (!regex.hasMatch(value.toString()) || value == null) {
                        return 'Please Enter a Valid Email address ';
                      }
                      return null; //changes;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      counterText: "",
                      hintText: "Email *",
                      border: boarder,
                      focusedBorder: focusboarder,
                      errorBorder: errorboarder,
                    ),
                    onChanged: (text) {
                      setState(() {
                        if (text.isNotEmpty) {
                          erroremail = true;
                        }
                      });
                    },
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Mobile Number',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: blueColor,
                  ),
                ),
                SizedBox(height: 10.h),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: tfColor,
                  ),
                  width: size.width,
                  child: TextFormField(
                    controller: mobileController,
                    validator: (value) {
                      RegExp regex = RegExp(r'^[6-9][0-9]{9}$');
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Phone Number';
                      } else if (!regex.hasMatch(value)) {
                        return 'Invalid Contact No';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      counterText: "",
                      hintText: "Mobile Number *",
                      border: boarder,
                      focusedBorder: focusboarder,
                      errorBorder: errorboarder,
                    ),
                    onChanged: (text) {
                      setState(() {
                        if (text.isNotEmpty) {
                          errormobile = true;
                        }
                      });
                    },
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Select State',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: blueColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: tfColor,
                  ),
                  width: size.width,
                  child: DropdownButtonFormField(
                    // validator: (value) {
                    //   if (value == null || value == '') {
                    //     return 'Please Enter a Valid Name';
                    //   }
                    //   return null; //changes
                    // },
                    decoration: InputDecoration(
                      border: boarder,
                      focusedBorder: focusboarder,
                      errorBorder: errorboarder,
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.grey),
                      hintText: "Select State",

                      fillColor: tfColor,
                      // prefixIcon: Icon(Icons.language),
                    ),
                    value: selcectState,
                    onChanged: (value) {
                      setState(() {
                        selcectState = value;
                        selectCity = null;
                      });
                      log("selectedstateId--->$selectedstateId");

                      if (selectedstateId.isEmpty) {
                        selectedstateId = '';
                      } else {
                        getCityFromApi(selectedstateId);
                      }
                    },
                    items:
                        States.map((explist) {
                          return DropdownMenuItem(
                            value: explist['state_name'].toString(),
                            child: Text(explist['state_name'].toString()),
                            onTap: () {
                              selectedstateId = explist['id'].toString();
                              log("selectedstateId--->$selectedstateId");
                            },
                          );
                        }).toList(),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Select City',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: blueColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: tfColor,
                  ),
                  width: size.width,
                  child: DropdownButtonFormField(
                    // validator: (value) {
                    //   if (value == null || value == '') {
                    //     return 'Please Enter a Valid Name';
                    //   }
                    //   return null; //changes
                    // },
                    decoration: InputDecoration(
                      border: boarder,

                      focusedBorder: focusboarder,
                      errorBorder: errorboarder,
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.grey),
                      hintText: "Select City",
                      labelStyle: TextStyle(color: Colors.grey.shade600),
                      fillColor: tfColor,
                      // prefixIcon: Icon(Icons.language),
                    ),
                    value: selectCity,
                    onChanged: (value) {
                      setState(() {
                        selectCity = value;
                      });
                      if (selectCityID == 0) {
                        selectCityID = null;
                      }
                    },
                    items:
                        City.map((explist) {
                          return DropdownMenuItem(
                            value: explist['city_name'].toString(),
                            child: Text(explist['city_name'].toString()),
                            onTap: () {
                              selectCityID = explist['id'].toString();
                            },
                          );
                        }).toList(),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Pin Code',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: blueColor,
                  ),
                ),
                SizedBox(height: 10.h),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: tfColor,
                  ),
                  width: size.width,
                  child: TextFormField(
                    controller: pinController,
                    // validator: form_validation().validatepincode,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.pin),
                      counterText: "",
                      hintText: "Pin",
                      border: boarder,
                      focusedBorder: focusboarder,
                      errorBorder: errorboarder,
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Web',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: blueColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: tfColor,
                  ),
                  width: size.width,
                  child: TextFormField(
                    controller: webController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.web),
                      counterText: "",
                      hintText: "Web",
                      border: boarder,
                      focusedBorder: focusboarder,
                      errorBorder: errorboarder,
                    ),
                    // maxLength: 10,
                    // keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  'Select Products',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: blueColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: tfColor,
                  ),
                  child: MultiSelectFormField(
                    autovalidate: AutovalidateMode.disabled,
                    chipBackGroundColor: colorConst.primarycolor,
                    chipLabelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    dialogTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    checkBoxActiveColor: colorConst.primarycolor,
                    checkBoxCheckColor: tfColor,
                    dialogShapeBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    title: const Text(
                      "Select Product",
                      style: TextStyle(fontSize: 16),
                    ),
                    // validator: (value) {
                    //   if (value == null || value.length == 0) {
                    //     return null;
                    //   }
                    //   return null;
                    // },
                    dataSource: AllLanguageServicesData,
                    textField: 'name',
                    valueField: 'id',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    hintWidget: const Text('Please choose one or more Product'),
                    initialValue: AllLanguageServices,
                    onSaved: (value) {
                      if (value == null) return;
                      setState(() {
                        AllLanguageServices = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Select Service',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: blueColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: tfColor,
                  ),
                  child: MultiSelectFormField(
                    autovalidate: AutovalidateMode.disabled,
                    chipBackGroundColor: colorConst.primarycolor,
                    chipLabelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    dialogTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    checkBoxActiveColor: colorConst.primarycolor,
                    checkBoxCheckColor: Colors.white,
                    dialogShapeBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    title: const Text(
                      "Select Service",
                      style: TextStyle(fontSize: 16),
                    ),
                    // validator: (value) {
                    //   if (value == null || value.length == 0) {
                    //     return null;
                    //   }
                    //   return null;
                    // },
                    dataSource: AllServicesData,
                    textField: 'name',
                    valueField: 'id',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    hintWidget: const Text('Please choose one or more Service'),
                    initialValue: AllServices,
                    onSaved: (value) {
                      if (value == null) return;
                      setState(() {
                        AllServices = value;
                      });
                    },
                  ),
                ),

                SizedBox(height: 15.h),
                Text(
                  'Location',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: blueColor,
                  ),
                ),
                SizedBox(height: 12.h),
                // Text('${widget.latLng.lat} , ${widget.latLng.lng}'),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 8),
                  height: 60,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: tfColor,
                    border: Border.all(width: 1, color: Colors.grey.shade900),
                  ),
                  child: Text(
                    '${widget.latLng!.lat} , ${widget.latLng!.lng}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15),
                //       color: tfColor),
                //   width: size.width,
                //   child: TextFormField(
                //     controller: locationController,
                //     readOnly: true,

                //     decoration: InputDecoration(
                //       prefixIcon: const Icon(Icons.location_city),
                //       counterText: "",
                //       hintText: "Location *",
                //       border: boarder,
                //       focusedBorder: focusboarder,
                //       errorBorder: errorboarder,
                //     ),
                //     onChanged: (text) {
                //       setState(() {
                //         if (text.isNotEmpty) {
                //           erroelocation = true;
                //         }
                //       });
                //     },
                //     // maxLength: 10,
                //     // keyboardType: TextInputType.number,
                //     style: const TextStyle(
                //         color: Colors.black,
                //         fontSize: 17,
                //         fontWeight: FontWeight.normal),
                //   ),
                // ),
                SizedBox(height: 20.h),
                // Center(
                //   child: ElevatedButton.icon(
                //     onPressed: () {
                //       ref.updateMap();
                //       locationController = TextEditingController(
                //           text: "${ref.lat.value} , ${ref.lng.value}");
                //       addressController =
                //           TextEditingController(text: ref.address.value);
                //     },
                //     icon: const Icon(Icons.location_searching),
                //     label: const Text(
                //       "Get Location",
                //       style: TextStyle(fontWeight: FontWeight.bold),
                //     ),
                //     style: ElevatedButton.styleFrom(backgroundColor: tfColor),
                //   ),
                // ),
                SizedBox(height: 15.h),

                Text(
                  'Address',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: blueColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  alignment: Alignment.centerLeft,
                  height: 55,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: tfColor,
                    border: Border.all(width: 1, color: Colors.grey.shade900),
                  ),
                  child: Text(
                    widget.latLng!.address,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
                // Container(
                //   alignment: Alignment.centerLeft,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15),
                //       color: tfColor),
                //   width: size.width,
                //   child: TextFormField(
                //     readOnly: true,
                //     controller: addressController,
                //     maxLength: 3,
                //     validator: (value) {
                //       if (value == null || value == '') {
                //         return 'Please Enter a Valid Name';
                //       }
                //       return null; //changes
                //     },
                //     decoration: InputDecoration(
                //       prefixIcon: const Icon(Icons.home),
                //       counterText: "",
                //       hintText: "Address *",
                //       border: boarder,
                //     ),
                //     onChanged: (text) {
                //       setState(() {
                //         if (text.isNotEmpty) {
                //           erroradd = true;
                //         }
                //       });
                //     },
                //     maxLines: 3,
                //     keyboardType: TextInputType.text,
                //     style: const TextStyle(
                //         color: Colors.black,
                //         fontSize: 17,
                //         fontWeight: FontWeight.normal),
                //   ),
                // ),
                SizedBox(height: 12.h),
                _listView(),
                // _addTile(),
                ListTile(
                  title: Container(
                    height: 60,
                    width: 290,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorConst.primarycolor),
                      borderRadius: BorderRadius.circular(100.0),
                      color: Colors.white,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.add),
                        Center(
                          child: Text(
                            'Add Contact',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: colorConst.primarycolor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    final startcontroller = TextEditingController();
                    final endcontroller = TextEditingController();
                    final emailcontroller = TextEditingController();
                    final fiels1 = TextFormField(
                      cursorColor: Colors.grey,
                      enableInteractiveSelection: true,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: "Contact Person",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0.2,
                        ),
                        isDense: true,
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.2,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      controller: startcontroller,
                      readOnly: false,
                      // validator: ((value) {
                      //   if (value == null || value == '') {
                      //     return "Contact person Required";
                      //   } else {
                      //     return null;
                      //   }
                      // }
                      // ),
                    );
                    final fiels2 = TextFormField(
                      cursorColor: Colors.grey,
                      enableInteractiveSelection: false,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      // validator: form_validation().validatephonenumber,
                      onTap: () async {},
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0.2,
                      ),
                      decoration: InputDecoration(
                        hintText: "Contact Mobile",
                        counterText: "",
                        labelText: "Contact Mobile${endController.length + 1}",
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0.2,
                        ),
                        isDense: true,
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.2,
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      controller: endcontroller,
                      // validator: ((value) {
                      //   if (value == null || value == '') {
                      //     return "Contact Number Required";
                      //   } else {
                      //     return null;
                      //   }
                      // }),
                    );
                    final fiels3 = TextFormField(
                      cursorColor: Colors.grey,
                      enableInteractiveSelection: false,
                      onTap: () async {},
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                      ),
                      decoration: InputDecoration(
                        hintText: "Contact Email",
                        labelText:
                            "Contact Email${emailcontrollers.length + 1}",
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0.2,
                        ),
                        isDense: true,
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.2,
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      controller: emailcontroller,
                      //  validator: form_validation().validateEmail,
                    );
                    final field = TextField(
                      controller: endcontroller,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "name${emailcontrollers.length + 1}",
                      ),
                    );

                    setState(() {
                      startController.add(startcontroller);
                      endController.add(endcontroller);
                      emailcontrollers.add(emailcontroller);
                      fields1.add(fiels1);
                      log("_field--> ${fields1.length}");
                      fields2.add(fiels2);
                      fields3.add(fiels3);
                      fields.add(field);
                    });
                  },
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (registerkey.currentState!.validate()) {
                        if (nameController != '') {
                          if (emailcontrollers != '') {
                            if (mobileController != '') {
                              // ref.updateMap();
                              bool validemail;
                              log("--->$AllServices");
                              try {
                                log("--1--->$AllLanguageServices");
                                startController
                                    .where((element) => element.text != "")
                                    .fold("", (previousValue, element) {
                                      arrayList1.add(element.text);
                                      return '';
                                    });
                                emailcontrollers
                                    .where((element) => element.text != "")
                                    .fold("", (previousValue, element) {
                                      arrayListmail.add(element.text);
                                      return '';
                                    });
                                endController
                                    .where((element) => element.text != "")
                                    .fold("", (previousValue, element) {
                                      arrayListmobile.add(element.text);
                                      return '';
                                    });
                                var url;
                                if (selectedRadioTile == 1) {
                                  url = Uri.parse(client_reg_url.toString());
                                } else {
                                  url = Uri.parse(vender_reg_url.toString());
                                }
                                String? usercompanyid =
                                    await _secureStorageService
                                        .getUserCompanyID(
                                          key: StorageKeys.companyIdKey,
                                        );

                                String? userid = await _secureStorageService
                                    .getUserID(key: StorageKeys.userIDKey);
                                var body = ({
                                  "company_id": usercompanyid,
                                  'user_id': userid,
                                  "org_name": nameController.text,
                                  "address": widget.latLng!.address.toString(),
                                  "city": selectCityID,
                                  "pin": pinController.text,
                                  "state": selectedstateId,
                                  "contact_no": "8852911910",
                                  "mobile": mobileController.text,
                                  "web": webController.text,
                                  "email": emailController.text,
                                  "inq_id": widget.inqId ?? '0',
                                  "location":
                                      '${widget.latLng!.lat},${widget.latLng!.lng}',
                                  'products':
                                      AllLanguageServices.isEmpty
                                          ? ""
                                          : jsonEncode(AllLanguageServices),
                                  'services':
                                      AllServices.isEmpty
                                          ? ""
                                          : jsonEncode(AllServices),
                                  'contact_person': jsonEncode(arrayList1),
                                  'contact_mobile': jsonEncode(arrayListmobile),
                                  'contact_email': jsonEncode(arrayListmail),
                                });
                                log("boss==> $jsonEncode(arrayList1)");
                                log("boss==> $jsonEncode(arrayListmail)");
                                log("boss==> $jsonEncode(arrayListmobile)");
                                log("client registration==> $body");
                                var result = await ApiBaseHelper().postAPICall(
                                  url,
                                  body,
                                );
                                if (result.statusCode == 200) {
                                  var responsedata = jsonDecode(result.body);
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (_) => const HomeNavBar(),
                                    ),
                                  );
                                  Fluttertoast.showToast(
                                    msg: responsedata['message'],
                                  );

                                  // GoRouter.of(context)
                                  //     .goNamed(routerConst.homeNavBar);
                                  log("client registration==>${result.body} ");
                                  nameController.clear();
                                  emailController.clear();
                                  mobileController.clear();
                                  pinController.clear();
                                  webController.clear();
                                  addressController.clear();
                                  startController.clear();
                                  endController.clear();
                                  emailcontrollers.clear();
                                  fields1.clear();
                                  fields2.clear();
                                  fields3.clear();
                                  timefields1.clear();
                                  timefields2.clear();
                                  fields.clear();
                                }
                              } catch (e) {
                                log("exception :=> $e ");
                              }
                            } else {
                              toastMsg('Please Enter Mobile Number', true);
                            }
                          } else {
                            toastMsg('Please Enter Email', true);
                          }
                        } else {
                          toastMsg('Please Enter Organization Name', true);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: blueColor,
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
