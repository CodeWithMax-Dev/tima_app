class NextVisitDataModel {
  var message;
  List<Datum> useData;

  NextVisitDataModel(this.message, this.useData);
}

class Datum {
  var id;
  var userId;
  var visitAt;
  var client;
  dynamic vendor;
  DateTime? startAt;
  DateTime? endAt;
  var personName;
  var personDesi;
  var personMobile;
  var personImage;
  var productService;
  var queryComplaint;
  var orderDone;
  DateTime? nextVisit;
  var remark;
  var location;

  Datum({
    this.id,
    this.userId,
    this.visitAt,
    this.client,
    this.vendor,
    this.startAt,
    this.endAt,
    this.personName,
    this.personDesi,
    this.personMobile,
    this.personImage,
    this.productService,
    this.queryComplaint,
    this.orderDone,
    this.nextVisit,
    this.remark,
    this.location,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        visitAt: json["visit_at"],
        client: json["client"],
        vendor: json["vendor"],
        startAt:
            json["start_at"] != null ? DateTime.parse(json["start_at"]) : null,
        endAt: json["end_at"] != null ? DateTime.parse(json["end_at"]) : null,
        personName: json["person_name"],
        personDesi: json["person_desi"],
        personMobile: json["person_mobile"],
        personImage: json["person_image"],
        productService: json["product_service"],
        queryComplaint: json["query_complaint"],
        orderDone: json["order_done"],
        nextVisit: json["next_visit"] != null
            ? DateTime.parse(json["next_visit"])
            : null,
        remark: json["remark"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "visit_at": visitAt,
        "client": client,
        "vendor": vendor,
        "start_at": startAt?.toIso8601String(),
        "end_at": endAt?.toIso8601String(),
        "person_name": personName,
        "person_desi": personDesi,
        "person_mobile": personMobile,
        "person_image": personImage,
        "product_service": productService,
        "query_complaint": queryComplaint,
        "order_done": orderDone,
        "next_visit": nextVisit?.toIso8601String(),
        "remark": remark,
        "location": location,
      };
}
