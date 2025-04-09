class HomeSliderModel {
  String? logo;
  String? logoMessage;
  int? status;
  String? message;
  int? userLoginStatus;
  List<SliderData> data=[];

  HomeSliderModel(
      {this.logo,
      this.logoMessage,
      this.status,
      this.message,
      this.userLoginStatus,
      required this.data});

  HomeSliderModel.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    logoMessage = json['logo_message'];
    status = json['status'];
    message = json['message'];
    userLoginStatus = json['user_login_status'];
    if (json['data'] != null) {
      data = <SliderData>[];
      json['data'].forEach((v) {
        data.add(SliderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logo'] = logo;
    data['logo_message'] = logoMessage;
    data['status'] = status;
    data['message'] = message;
    data['user_login_status'] = userLoginStatus;
    if (this.data != '') {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SliderData {
  String? imageUrl;

  SliderData({this.imageUrl});

  SliderData.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    return data;
  }
}