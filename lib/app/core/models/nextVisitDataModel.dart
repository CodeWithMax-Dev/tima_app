class VisitData {
  int id;
  int userId;
  String visitAt;
  String client;
  String vendor;
  String? startAt;
  String? endAt;
  String personName;
  String personDesi;
  String personMobile;
  String personImage;
  String productService;
  String queryComplaint;
  bool orderDone;
  String? nextVisit;
  String remark;
  String location;

  VisitData({
    required this.id,
    required this.userId,
    required this.visitAt,
    required this.client,
    required this.vendor,
    this.startAt,
    this.endAt,
    required this.personName,
    required this.personDesi,
    required this.personMobile,
    required this.personImage,
    required this.productService,
    required this.queryComplaint,
    required this.orderDone,
    this.nextVisit,
    required this.remark,
    required this.location,
  });

  factory VisitData.fromJson(Map<String, dynamic> json) {
    return VisitData(
      id: json['id'],
      userId: json['user_id'],
      visitAt: json['visit_at'],
      client: json['client'],
      vendor: json['vendor'],
      startAt: json['start_at'],
      endAt: json['end_at'],
      personName: json['person_name'],
      personDesi: json['person_desi'],
      personMobile: json['person_mobile'],
      personImage: json['person_image'],
      productService: json['product_service'],
      queryComplaint: json['query_complaint'],
      orderDone: json['order_done'],
      nextVisit: json['next_visit'],
      remark: json['remark'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'visit_at': visitAt,
      'client': client,
      'vendor': vendor,
      'start_at': startAt,
      'end_at': endAt,
      'person_name': personName,
      'person_desi': personDesi,
      'person_mobile': personMobile,
      'person_image': personImage,
      'product_service': productService,
      'query_complaint': queryComplaint,
      'order_done': orderDone,
      'next_visit': nextVisit,
      'remark': remark,
      'location': location,
    };
  }
}
