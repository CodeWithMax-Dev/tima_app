// To parse this JSON data, do
//
//     final nextVisitModel = nextVisitModelFromJson(jsonString);

import 'dart:convert';

NextVisitModel nextVisitModelFromJson(String str) =>
    NextVisitModel.fromJson(json.decode(str));

String nextVisitModelToJson(NextVisitModel data) => json.encode(data.toJson());

class NextVisitModel {
  int status;
  String message;
  List<DatumNextVisit> data;

  NextVisitModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory NextVisitModel.fromJson(Map<String, dynamic> json) => NextVisitModel(
        status: json["status"],
        message: json["message"],
        data: List<DatumNextVisit>.from(json["data"].map((x) => DatumNextVisit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatumNextVisit {
  String id;
  String userId;
  String visitAt;
  String client;
  dynamic vendor;
  DateTime startAt;
  DateTime endAt;
  String personName;
  String personDesi;
  String personMobile;
  String personImage;
  String productService;
  String queryComplaint;
  String orderDone;
  DateTime nextVisit;
  String remark;
  String location;

  DatumNextVisit({
    required this.id,
    required this.userId,
    required this.visitAt,
    required this.client,
    required this.vendor,
    required this.startAt,
    required this.endAt,
    required this.personName,
    required this.personDesi,
    required this.personMobile,
    required this.personImage,
    required this.productService,
    required this.queryComplaint,
    required this.orderDone,
    required this.nextVisit,
    required this.remark,
    required this.location,
  });

  factory DatumNextVisit.fromJson(Map<String, dynamic> json) => DatumNextVisit(
        id: json["id"],
        userId: json["user_id"],
        visitAt: json["visit_at"],
        client: json["client"],
        vendor: json["vendor"],
        startAt: DateTime.parse(json["start_at"]),
        endAt: DateTime.parse(json["end_at"]),
        personName: json["person_name"],
        personDesi: json["person_desi"],
        personMobile: json["person_mobile"],
        personImage: json["person_image"],
        productService: json["product_service"],
        queryComplaint: json["query_complaint"],
        orderDone: json["order_done"],
        nextVisit: DateTime.parse(json["next_visit"]),
        remark: json["remark"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "visit_at": visitAt,
        "client": client,
        "vendor": vendor,
        "start_at": startAt.toIso8601String(),
        "end_at": endAt.toIso8601String(),
        "person_name": personName,
        "person_desi": personDesi,
        "person_mobile": personMobile,
        "person_image": personImage,
        "product_service": productService,
        "query_complaint": queryComplaint,
        "order_done": orderDone,
        "next_visit": nextVisit.toIso8601String(),
        "remark": remark,
        "location": location,
      };
}
