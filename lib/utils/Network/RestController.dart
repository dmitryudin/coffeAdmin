import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:coffe_admin/configuration/NetworkConfiguration.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class RestController {
  RestController();
  late final void Function({required String data}) onComplete;
  late final void Function({required String data}) onError;

  void sendPostRequest({
    required void Function({required String data}) onComplete,
    required void Function({required String data}) onError,
    required String controller,
    required String data,
  }) async {
    this.onComplete = onComplete;
    this.onError = onError;
    String url = NetworkConfiguration().address +
        NetworkConfiguration().controllersMap[controller].toString();
    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: data);
      if (response.statusCode == 200) {
        return onComplete(data: response.body);
      } else {
        throw Exception('Error of Internet connection');
      }
    } catch (e) {
      print(e);
    }
  }

  void sendGetRequest({
    required void Function({required String data}) onComplete,
    required void Function({required String data}) onError,
    required String controller,
    required Map<String, dynamic> queryParameters,
  }) async {
    this.onComplete = onComplete;
    this.onError = onError;
    var url = Uri.https(
        NetworkConfiguration().address.split('://')[1],
        NetworkConfiguration().controllersMap[controller].toString(),
        queryParameters);
    try {
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return onComplete(data: response.body);
      } else {
        throw Exception('Error of Internet connection');
      }
    } catch (e) {
      print('NO!');
    }
  }
}
