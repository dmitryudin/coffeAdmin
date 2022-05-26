import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../configuration/NetworkConfiguration.dart';
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
    //getCoffes();
  }

  void getCoffes() {
    RestController().sendPostRequest(
        onComplete: ({required String data}) {
          List<dynamic> json = jsonDecode(data);
          this.coffes.clear();
          for (var coffe in json) {
            this.coffes.add(Coffe.fromJson(jsonEncode(coffe)));
          }
          notifyListeners();
        },
        onError: ({required String data}) {},
        controller: 'coffe_get',
        data: '');
  }

  getMainData() {
    RestController().sendPostRequest(
        onComplete: ({required String data}) {
          onMainDataAccepted(data);
          getCoffes();
        },
        onError: ({required String data}) {},
        controller: 'coffehouse_get',
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
        onComplete: ({required String data}) {
          getCoffes();
        },
        onError: ({required String data}) {},
        controller: 'create_coffe',
        data: coffe.toJson());
  }

  void deleteCoffe(Coffe coffe) {
    print(coffe.id);
    coffes.remove(coffe);
    RestController().sendPostRequest(
        onComplete: ({required String data}) {
          getCoffes();
        },
        onError: ({required String data}) {},
        controller: 'coffe_delete',
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
    RestController().sendPostRequest(
        onComplete: ({required String data}) {},
        onError: ({required String data}) {},
        controller: 'update_coffe_house',
        data: this.toJson());
  }
}
