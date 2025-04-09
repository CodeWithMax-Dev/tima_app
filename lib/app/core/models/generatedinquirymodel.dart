class GenerateEnquiryModel {
  List<EnquiryData>? data;
  String? message;

  GenerateEnquiryModel({this.data, this.message});

  factory GenerateEnquiryModel.fromJson(Map<String, dynamic> json) {
    return GenerateEnquiryModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => EnquiryData.fromJson(item as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );
  }
}

class EnquiryData {
  String? userId;
  String? dateTime;
  String? id;
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
  String? vendorId;
  String? visitId;
  String? rejectReason;
  String? status;

  EnquiryData({
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
    this.rejectReason,
    this.status,
  });

  factory EnquiryData.fromJson(Map<String, dynamic> json) {
    return EnquiryData(
      id: json['id'],
      dateTime: json['date_time'],
      userId: json['user_id'],
      userName: json['user_name'],
      userBranch: json['user_branch'],
      userMobile: json['user_mobile'],
      userEmail: json['user_email'],
      enqTypeId: json['enq_type_id'],
      enqTypeName: json['enq_type_name'],
      branchId: json['branch_id'],
      branchName: json['branch_name'],
      branchCity: json['branch_city'],
      personId: json['person_id'],
      personName: json['person_name'],
      personMobile: json['person_mobile'],
      personEmail: json['person_email'],
      productServiceId: json['product_service_id'],
      productServiceType: json['product_service_type'],
      productServiceName: json['product_service_name'],
      client: json['client'],
      contactPerson: json['contact_person'],
      contactNo: json['contact_no'],
      currentVendor: json['current_vendor'],
      currentPrice: json['current_price'],
      targetBusiness: json['target_business'],
      remark: json['remark'],
      opStatus: json['op_status'],
      clientId: json['client_id'],
      vendorId: json['vendor_id'],
      visitId: json['visit_id'],
      rejectReason: json['reject_reason'],
      status: json['status'],
    );
  }
}
