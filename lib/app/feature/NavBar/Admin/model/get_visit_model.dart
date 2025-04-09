class GetVisitsStatusModel {
  Data? data;
  int? status;
  String? message;

  GetVisitsStatusModel({this.data, this.status, this.message});

  GetVisitsStatusModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class Data {
  String? visitId;
  String? userId;
  String? visitAt;
  String? clientId;
  String? vendorId;
  String? clientName;
  String? vendorName;
  String? personName;
  String? personDesignation;
  String? contactNo;
  String? startAt;
  String? startLocation;
  String? inqId;
  String? company;
  String? visitStatus;

  Data(
      {this.visitId,
      this.userId,
      this.visitAt,
      this.clientId,
      this.vendorId,
      this.clientName,
      this.vendorName,
      this.personName,
      this.personDesignation,
      this.contactNo,
      this.startAt,
      this.startLocation,
      this.inqId,
      this.company,
      this.visitStatus});

  Data.fromJson(Map<String, dynamic> json) {
    visitId = json['visit_id'];
    userId = json['user_id'];
    visitAt = json['visit_at'];
    clientId = json['client_id'];
    vendorId = json['vendor_id'];
    clientName = json['client_name'];
    vendorName = json['vendor_name'];
    personName = json['person_name'];
    personDesignation = json['person_desi'];
    contactNo = json['contact_no'];
    startAt = json['start_at'];
    startLocation = json['start_location'];
    inqId = json['inq_id'];
    company = json['company'];
    visitStatus = json['visit_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['visit_id'] = visitId;
    data['user_id'] = userId;
    data['visit_at'] = visitAt;
    data['client_id'] = clientId;
    data['vendor_id'] = vendorId;
    data['client_name'] = clientName;
    data['vendor_name'] = vendorName;
    data['person_name'] = personName;
    data['person_desi'] = personDesignation;
    data['contact_no'] = contactNo;
    data['start_at'] = startAt;
    data['start_location'] = startLocation;
    data['inq_id'] = inqId;
    data['company'] = company;
    data['visit_status'] = visitStatus;
    return data;
  }
}
