import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'BasicObject.dart';

Map map = {
  'client_registration': "/client/registration",
  'client_login': "/client/login",
  'client_get_profile': "/client/getProfile",
  'client_get_passport': "/client/getPassport",
  'client_update_profile': "/client/updateProfile",
  3: "Sam"
};

class RestController {
  static String fileInBase64({uri}) {
    return base64Encode(File(uri).readAsBytesSync());
  }

  static send_request(
      {required BasicObject class_obj,
      required String controller,
      required data}) async {
    class_obj.flagOfBusy = true;

    String address = 'http://192.168.0.105:5050';
    String url = address + map[controller].toString();
    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: data);
      if (response.statusCode == 200) {
        class_obj.flagOfBusy = false;
        return class_obj.onDataAccepted(response.body, controller);
      } else {
        throw Exception('Error of Internet connection');
      }
    } catch (e) {}
  }
}
