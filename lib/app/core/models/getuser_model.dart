class GetUsersModel {
  final int status;
  final String message;
  final List<GetUserData> data;

  GetUsersModel(
      {required this.status, required this.message, required this.data});

  factory GetUsersModel.fromJson(Map<String, dynamic> json) {
    return GetUsersModel(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List).map((v) => GetUserData.fromJson(v)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((v) => v.toJson()).toList(),
    };
  }
}

class GetUserData {
  final String userId;
  final String name;
  final String cityName;
  final String stateName;

  GetUserData(
      {required this.userId,
      required this.name,
      required this.cityName,
      required this.stateName});

  factory GetUserData.fromJson(Map<String, dynamic> json) {
    return GetUserData(
      userId: json['userid'],
      name: json['name'],
      cityName: json['city_name'],
      stateName: json['state_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userId,
      'name': name,
      'city_name': cityName,
      'state_name': stateName,
    };
  }
}
