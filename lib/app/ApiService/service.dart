import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class ApiService {
/* Local URl */
  static var baseurl = "http://sales.aadharsoftwares.com/";

  static String imageurl = "https://gospotless.co/";
  // static String image_url_for_documents =
  //     "http://122.170.0.3:6010/uploads/documents/";
  // static String image_url_for_experience =
  //     "http://122.170.0.3:6010/uploads/photos/";

  Future callloginApi(Map<String, Object> resetJson) async {
    //For Login APi
    var responseData;
    try {
      print("${baseurl}login/user_login");
      http.Response response = await http
          .post(Uri.parse("${baseurl}login/user_login"), body: resetJson);

      if (response.statusCode == 200) {
        responseData = JSON.jsonDecode(response.body);
        print("water calculation Success${response.body}");

        return responseData;
      }
    } catch (E) {
      print("Error$E");
    }
  }

  Future callchangepassApi(Map<String, Object> resetJson) async {
    //For Login APi
    var responseData;
    try {
      print("${baseurl}login/change_password");
      http.Response response = await http
          .post(Uri.parse("${baseurl}login/change_password"), body: resetJson);

      if (response.statusCode == 200) {
        responseData = JSON.jsonDecode(response.body);
        print("water calculation Success${response.body}");

        return responseData;
      }
    } catch (E) {
      print("Error$E");
    }
  }

  Future callinsrtdataApi(Map<String, Object> loginJson) async {
    //For Login APi
    var responseData;

    try {
      print("${baseurl}client/save");
      http.Response response =
          await http.post(Uri.parse("${baseurl}client/save"), body: loginJson);

      if (response.statusCode == 200) {
        responseData = JSON.jsonDecode(response.body);
        print("Login Success12${response.body}");

        return responseData;
      }
    } catch (E) {
      print("Error$E");
    }
  }

  Future getcityapi() async {
    var Dataresponse;
    try {
      print("${baseurl}city/get");
      http.Response response = await http.get(Uri.parse("${baseurl}city/get"));

      if (response.statusCode == 200) {
        Dataresponse = JSON.jsonDecode(response.body);
        print("Designatin  list sucess : ${response.body}");

        return Dataresponse;
      }
    } catch (E) {
      print("Error$E");
    }
  }

  Future getstateapi() async {
    var Dataresponse;
    try {
      print("${baseurl}state/get");
      http.Response response = await http.get(Uri.parse("${baseurl}state/get"));

      if (response.statusCode == 200) {
        Dataresponse = JSON.jsonDecode(response.body);
        print("Designatin  list sucess : ${response.body}");

        return Dataresponse;
      }
    } catch (E) {
      print("Error$E");
    }
  }
}
