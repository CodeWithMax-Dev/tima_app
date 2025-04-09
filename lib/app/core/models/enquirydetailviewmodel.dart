// To parse this JSON data, do
//
//     final getEnquiryDetailViewModel = getEnquiryDetailViewModelFromJson(jsonString);

import 'dart:convert';

GetEnquiryDetailViewModel getEnquiryDetailViewModelFromJson(String str) => GetEnquiryDetailViewModel.fromJson(json.decode(str));

String getEnquiryDetailViewModelToJson(GetEnquiryDetailViewModel data) => json.encode(data.toJson());

class GetEnquiryDetailViewModel {
  int? status;
  String? message;
  Data? data;

  GetEnquiryDetailViewModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetEnquiryDetailViewModel.fromJson(Map<String, dynamic> json) => GetEnquiryDetailViewModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  String? id;
  DateTime? dateTime;
  String? userId;
  String? userName;
  String? userBranch;
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
  dynamic vendorId;
  dynamic visitId;

  Data({
    this.id,
    this.dateTime,
    this.userId,
    this.userName,
    this.userBranch,
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
    this.visitId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    dateTime: DateTime.parse(json["date_time"]),
    userId: json["user_id"],
    userName: json["user_name"],
    userBranch: json["user_branch"],
    userMobile: json["user_mobile"],
    userEmail: json["user_email"],
    enqTypeId: json["enq_type_id"],
    enqTypeName: json["enq_type_name"],
    branchId: json["branch_id"],
    branchName: json["branch_name"],
    branchCity: json["branch_city"],
    personId: json["person_id"],
    personName: json["person_name"],
    personMobile: json["person_mobile"],
    personEmail: json["person_email"],
    productServiceId: json["product_service_id"],
    productServiceType: json["product_service_type"],
    productServiceName: json["product_service_name"],
    client: json["client"],
    contactPerson: json["contact_person"],
    contactNo: json["contact_no"],
    currentVendor: json["current_vendor"],
    currentPrice: json["current_price"],
    targetBusiness: json["target_business"],
    remark: json["remark"],
    opStatus: json["op_status"],
    clientId: json["client_id"],
    vendorId: json["vendor_id"],
    visitId: json["visit_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_time": dateTime!.toIso8601String(),
    "user_id": userId,
    "user_name": userName,
    "user_branch": userBranch,
    "user_mobile": userMobile,
    "user_email": userEmail,
    "enq_type_id": enqTypeId,
    "enq_type_name": enqTypeName,
    "branch_id": branchId,
    "branch_name": branchName,
    "branch_city": branchCity,
    "person_id": personId,
    "person_name": personName,
    "person_mobile": personMobile,
    "person_email": personEmail,
    "product_service_id": productServiceId,
    "product_service_type": productServiceType,
    "product_service_name": productServiceName,
    "client": client,
    "contact_person": contactPerson,
    "contact_no": contactNo,
    "current_vendor": currentVendor,
    "current_price": currentPrice,
    "target_business": targetBusiness,
    "remark": remark,
    "op_status": opStatus,
    "client_id": clientId,
    "vendor_id": vendorId,
    "visit_id": visitId,
  };
}
