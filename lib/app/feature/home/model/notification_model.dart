class NotificationModel {
  final List<String>? visitData;
  final List<String>? enquiryData;

  NotificationModel({this.visitData, this.enquiryData});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      visitData: List<String>.from(json['visit_data']),
      enquiryData: List<String>.from(json['enquiry_data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visit_data': visitData,
      'enquiry_data': enquiryData,
    };
  }
}
