import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'DishObject.dart';
import 'OrdersObject.dart';
import '../utils/Network/RestController.dart';

class CoffeHouse with ChangeNotifier {
  @override
  bool flagOfBusy = false;
  int id = -1;
  String name = '';
  String phone = '';
  String email = '';
  String description = '';
  String address = '';
  double rating = 5.5;
  String token = '';
  List<String> photos = [];
  List<Coffe> coffes = [];
  List<Order> orders = [];

  CoffeHouse() {
    getMainData();
    getCoffes();
  }

  void getCoffes() {
    RestController().sendGetRequest(
        onComplete: ({required String data, required int statusCode}) {
          List<dynamic> json = jsonDecode(data);
          this.coffes.clear();
          for (var coffe in json) {
            this.coffes.add(Coffe.fromJson(jsonEncode(coffe)));
          }
          notifyListeners();
        },
        onError: ({required int statusCode}) {},
        controller: 'coffes',
        data: "",
        accessToken: '');
  }

  getMainData() {
    RestController().sendGetRequest(
        onComplete: ({required String data, required int statusCode}) {
          onMainDataAccepted(data);
          getCoffes();
        },
        onError: ({required int statusCode}) {},
        controller: 'coffehouse',
        data: '');
    /*основная информация включает в себя основные текстовые данные и меню*/
  }

  void onMainDataAccepted(data) {
    Map<String, dynamic> json = jsonDecode(data);
    print(json);
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    //description = json['description'];
    address = json['address'];
    List d = json['photos'];
    photos = d.map((e) => e.toString()).toList();
    notifyListeners();
  }

  void createCoffe(Coffe coffe) {
    RestController().sendPostRequest(
        onComplete: ({required String data, required int statusCode}) {
          getCoffes();
        },
        onError: ({required int statusCode}) {},
        controller: 'coffe',
        data: coffe.toJson());
  }

  void deleteCoffe(Coffe coffe) {
    coffes.remove(coffe);
    RestController().sendDeleteRequest(
        onComplete: ({required String data, required int statusCode}) {
          getCoffes();
        },
        onError: ({required int statusCode}) {},
        controller: 'coffe',
        data: '{"id":' + coffe.id.toString() + '}');

    notifyListeners();
  }

  String toJson() {
    Map<String, dynamic> data = {};
    String address = '';

    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['description'] = description;
    data['address'] = address;
    data['photos'] = photos;
    print(data);
    return jsonEncode(data);
  }

  void updateMainInformation() {
    RestController().sendPutRequest(
        onComplete: ({required String data, required int statusCode}) {},
        onError: ({required int statusCode}) {},
        controller: 'coffehouse',
        data: this.toJson());
  }
}
