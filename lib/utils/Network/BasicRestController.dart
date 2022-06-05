import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../Security/Auth.dart';
import 'package:coffe_admin/utils/Configuration/NetworkConfiguration.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

class BasicRestController {
  BasicRestController() {}

  late final void Function({required String data, required int statusCode})
      onComplete;
  late final void Function({required int statusCode}) onError;

  Future<http.Response> postRequest(
      {required String data, required String url, String? accessToken}) async {
    return await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: data);
  }

  Future<http.Response> deleteRequest(
      {required String data, required String url, String? accessToken}) async {
    return await http.delete(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: data);
  }

  Future<http.Response> putRequest(
      {required String data, required String url, String? accessToken}) async {
    return await http.put(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: data);
  }

  Future<http.Response> getRequest(
      {required String data, required String url, String? accessToken}) async {
    return await http.get(
      Uri.parse(url + data),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
  }

  void sendRequest(
      {required void Function({required String data, required int statusCode})
          onComplete,
      required void Function({required int statusCode}) onError,
      required String controller,
      required String data,
      dynamic requestFunc,
      String? accessToken}) async {
    this.onComplete = onComplete;
    this.onError = onError;
    String url = NetworkConfiguration().address +
        NetworkConfiguration().controllersMap[controller].toString();
    try {
      var response =
          await requestFunc(data: data, url: url, accessToken: accessToken);
      if (response.statusCode == 401 || response.statusCode == 422) {
        throw Exception('Excetrion in RestController: Invalid  token');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        var box = await Hive.openBox('myBox');
        box.put(url, response.body);
        return onComplete(data: response.body, statusCode: response.statusCode);
      } else {
        onError(statusCode: response.statusCode);
      }
    } catch (e) {}
  }
}
