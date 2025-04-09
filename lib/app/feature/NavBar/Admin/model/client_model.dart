class ClientsModel {
  int? status;
  String? message;
  List<Data>? data;

  ClientsModel({this.status, this.message, this.data});

  ClientsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? orgName;
  String? address;
  String? city;
  String? pin;
  String? state;
  String? contactNo;
  String? mobile;
  String? web;
  String? email;
  String? location;
  String? cityName;
  String? stateName;

  Data(
      {this.id,
      this.orgName,
      this.address,
      this.city,
      this.pin,
      this.state,
      this.contactNo,
      this.mobile,
      this.web,
      this.email,
      this.location,
      this.cityName,
      this.stateName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orgName = json['org_name'];
    address = json['address'];
    city = json['city'];
    pin = json['pin'];
    state = json['state'];
    contactNo = json['contact_no'];
    mobile = json['mobile'];
    web = json['web'];
    email = json['email'];
    location = json['location'];
    cityName = json['city_name'];
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['org_name'] = orgName;
    data['address'] = address;
    data['city'] = city;
    data['pin'] = pin;
    data['state'] = state;
    data['contact_no'] = contactNo;
    data['mobile'] = mobile;
    data['web'] = web;
    data['email'] = email;
    data['location'] = location;
    data['city_name'] = cityName;
    data['state_name'] = stateName;
    return data;
  }
}
