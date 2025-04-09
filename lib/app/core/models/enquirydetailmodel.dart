// To parse this JSON data, do
//
//     final getEnquiryDetailModel = getEnquiryDetailModelFromJson(jsonString);

import 'dart:convert';

GetEnquiryDetailModel getEnquiryDetailModelFromJson(String str) =>
    GetEnquiryDetailModel.fromJson(json.decode(str));

String getEnquiryDetailModelToJson(GetEnquiryDetailModel data) =>
    json.encode(data.toJson());

class GetEnquiryDetailModel {
  int? status;
  String? message;
  List<Datum>? data;

  GetEnquiryDetailModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetEnquiryDetailModel.fromJson(Map<String, dynamic> json) =>
      GetEnquiryDetailModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? id;
  String? dateTime;
  String? userId;
  String? userName;
  String? userMobile;
  String? userEmail;
  String? enqTypeId;
  String? enqTypeName;
  String? branchId;
  String? branchName;
  String? branchCity;
  String? personId;
  String? personName;
  String? personMobile;
  String? personEmail;
  String? productServiceId;
  String? productServiceType;
  String? productServiceName;
  String? client;
  String? contactPerson;
  String? contactNo;
  String? currentVendor;
  String? currentPrice;
  String? targetBusiness;
  String? remark;
  String? opStatus;
  String? clientId;
  String? vendorId;
  String? visitId;

  Datum(
      {this.id,
      this.dateTime,
      this.userId,
      this.userName,
      this.userMobile,
      this.userEmail,
      this.enqTypeId,
      this.enqTypeName,
      this.branchId,
      this.branchName,
      this.branchCity,
      this.personId,
      this.personName,
      this.personMobile,
      this.personEmail,
      this.productServiceId,
      this.productServiceType,
      this.productServiceName,
      this.client,
      this.contactPerson,
      this.contactNo,
      this.currentVendor,
      this.currentPrice,
      this.targetBusiness,
      this.remark,
      this.opStatus,
      this.clientId,
      this.vendorId,
      this.visitId});

  Datum.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateTime = json['date_time'];
    userId = json['user_id'];
    userName = json['user_name'];
    userMobile = json['user_mobile'];
    userEmail = json['user_email'];
    enqTypeId = json['enq_type_id'];
    enqTypeName = json['enq_type_name'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    branchCity = json['branch_city'];
    personId = json['person_id'];
    personName = json['person_name'];
    personMobile = json['person_mobile'];
    personEmail = json['person_email'];
    productServiceId = json['product_service_id'];
    productServiceType = json['product_service_type'];
    productServiceName = json['product_service_name'];
    client = json['client'];
    contactPerson = json['contact_person'];
    contactNo = json['contact_no'];
    currentVendor = json['current_vendor'];
    currentPrice = json['current_price'];
    targetBusiness = json['target_business'];
    remark = json['remark'];
    opStatus = json['op_status'];
    clientId = json['client_id'];
    vendorId = json['vendor_id'];
    visitId = json['visit_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date_time'] = dateTime;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_mobile'] = userMobile;
    data['user_email'] = userEmail;
    data['enq_type_id'] = enqTypeId;
    data['enq_type_name'] = enqTypeName;
    data['branch_id'] = branchId;
    data['branch_name'] = branchName;
    data['branch_city'] = branchCity;
    data['person_id'] = personId;
    data['person_name'] = personName;
    data['person_mobile'] = personMobile;
    data['person_email'] = personEmail;
    data['product_service_id'] = productServiceId;
    data['product_service_type'] = productServiceType;
    data['product_service_name'] = productServiceName;
    data['client'] = client;
    data['contact_person'] = contactPerson;
    data['contact_no'] = contactNo;
    data['current_vendor'] = currentVendor;
    data['current_price'] = currentPrice;
    data['target_business'] = targetBusiness;
    data['remark'] = remark;
    data['op_status'] = opStatus;
    data['client_id'] = clientId;
    data['vendor_id'] = vendorId;
    data['visit_id'] = visitId;
    return data;
  }
}
