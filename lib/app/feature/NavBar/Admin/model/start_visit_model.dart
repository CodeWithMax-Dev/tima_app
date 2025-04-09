class StartVisitModel {
  String? startAt;
  int? status;
  int? visitId;
  String? message;
  List<dynamic>? data;

  StartVisitModel(
      {this.startAt, this.status, this.visitId, this.message, this.data});

  StartVisitModel.fromJson(Map<String, dynamic> json) {
    startAt = json['start_at'];
    status = json['status'];
    visitId = json['visit_id'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Null>[];
      json['data'].forEach((v) {
        data!.add(v.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_at'] = startAt;
    data['status'] = status;
    data['visit_id'] = visitId;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}