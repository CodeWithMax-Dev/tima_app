// To parse this JSON data, do
//
//     final stateListmodel = stateListmodelFromJson(jsonString);

import 'dart:convert';

StateListmodel stateListmodelFromJson(String str) => StateListmodel.fromJson(json.decode(str));

String stateListmodelToJson(StateListmodel data) => json.encode(data.toJson());

class StateListmodel {
  StateListmodel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<Datum>? data;

  factory StateListmodel.fromJson(Map<String, dynamic> json) => StateListmodel(
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
  Datum({
    this.id,
    this.stateName,
  });

  String? id;
  String? stateName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    stateName: json["state_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "state_name": stateName,
  };
}
