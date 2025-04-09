class EnquiryModel {
  final int status;
  final String message;
  final List<EnquiryData> data;

  EnquiryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EnquiryModel.fromJson(Map<String, dynamic> json) {
    return EnquiryModel(
      status: json['status'],
      message: json['message'],
      data: List<EnquiryData>.from(
          json['data'].map((item) => EnquiryData.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': List<dynamic>.from(data.map((item) => item.toJson())),
    };
  }
}

class EnquiryData {
  final String id;
  final DateTime dateTime;
  final String userId;
  final String userName;
  final String userBranch;
  final String userMobile;
  final String userEmail;
  final String enqTypeId;
  final String enqTypeName;
  final String branchId;
  final String branchName;
  final String branchCity;
  final String personId;
  final String personName;
  final String personMobile;
  final String personEmail;
  final String productServiceId;
  final String productServiceType;
  final String productServiceName;
  final String client;
  final String contactPerson;
  final String contactNo;
  final String currentVendor;
  final String currentPrice;
  final String targetBusiness;
  final String remark;
  final String opStatus;
  final String? clientId;
  final String? vendorId;
  final String? visitId;

  EnquiryData({
    required this.id,
    required this.dateTime,
    required this.userId,
    required this.userName,
    required this.userBranch,
    required this.userMobile,
    required this.userEmail,
    required this.enqTypeId,
    required this.enqTypeName,
    required this.branchId,
    required this.branchName,
    required this.branchCity,
    required this.personId,
    required this.personName,
    required this.personMobile,
    required this.personEmail,
    required this.productServiceId,
    required this.productServiceType,
    required this.productServiceName,
    required this.client,
    required this.contactPerson,
    required this.contactNo,
    required this.currentVendor,
    required this.currentPrice,
    required this.targetBusiness,
    required this.remark,
    required this.opStatus,
    this.clientId,
    this.vendorId,
    this.visitId,
  });

  factory EnquiryData.fromJson(Map<String, dynamic> json) {
    return EnquiryData(
      id: json['id'],
      dateTime: DateTime.parse(json['date_time']),
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date_time': dateTime.toIso8601String(),
      'user_id': userId,
      'user_name': userName,
      'user_branch': userBranch,
      'user_mobile': userMobile,
      'user_email': userEmail,
      'enq_type_id': enqTypeId,
      'enq_type_name': enqTypeName,
      'branch_id': branchId,
      'branch_name': branchName,
      'branch_city': branchCity,
      'person_id': personId,
      'person_name': personName,
      'person_mobile': personMobile,
      'person_email': personEmail,
      'product_service_id': productServiceId,
      'product_service_type': productServiceType,
      'product_service_name': productServiceName,
      'client': client,
      'contact_person': contactPerson,
      'contact_no': contactNo,
      'current_vendor': currentVendor,
      'current_price': currentPrice,
      'target_business': targetBusiness,
      'remark': remark,
      'op_status': opStatus,
      'client_id': clientId,
      'vendor_id': vendorId,
      'visit_id': visitId,
    };
  }
}
