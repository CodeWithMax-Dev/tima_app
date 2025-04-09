// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromJson(jsonString);

import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) =>
    AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceModel data) =>
    json.encode(data.toJson());

class AttendanceModel {
  int status;
  String message;
  List<AttDatum> data;

  AttendanceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        status: json["status"],
        message: json["message"],
        data:
            List<AttDatum>.from(json["data"].map((x) => AttDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AttDatum {
  String? id;
  String? userId;
  String? attDate;
  String? inTime;
  String? outTime;
  String? status;

  AttDatum({
    this.id,
    this.userId,
    this.attDate,
    this.inTime,
    this.outTime,
    this.status,
  });

  factory AttDatum.fromJson(Map<String, dynamic> json) => AttDatum(
        id: json["id"],
        userId: json["user_id"],
        attDate: json["att_date"],
        inTime: json["in_time"],
        outTime: json["out_time"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "att_date": attDate,
        "in_time": inTime,
        "out_time": outTime,
        "status": status,
      };
}
