import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'BasicObject.dart';
import 'MultiPart.dart';

Map map = {
  'coffehouse_get': "/coffehouse/get_coffe_house",
  'delete_file': "/coffehouse/delete_file",
  'update_coffe_house': '/coffehouse/update_coffe_house',
};

class RestController {
  static String fileInBase64({uri}) {
    return base64Encode(File(uri).readAsBytesSync());
  }

  static send_request(
      {required BasicObject class_obj,
      required String controller,
      required String data}) async {
    class_obj.flagOfBusy = true;
    String address = 'http://thefir.ddns.net:5050';
    String url = address + map[controller].toString();
    print(url);
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

  static uploadFile(
      {required dynamic class_obj, required String filename}) async {
    var uri = Uri.parse('http://thefir.ddns.net:5050//coffehouse/upload_file');

    final request = MultipartRequest(
      'POST',
      uri,
      onProgress: (int bytes, int total) {
        class_obj.setProgress(bytes / total);
      },
    );
    request.headers['HeaderKey'] = 'header_value';
    request.fields['form_key'] = 'form_value';
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        filename,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.send().then((response) {
      if (response.statusCode == 200)
        response.stream.transform(utf8.decoder).listen((value) {
          class_obj.onUploaded(value);
        });
    });
  }
}
