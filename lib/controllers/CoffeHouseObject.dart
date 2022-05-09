import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'BasicObject.dart';
import 'DishObject.dart';
import 'OrdersObject.dart';
import 'RestController.dart';

class CoffeHouse with ChangeNotifier implements BasicObject {
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
  List<Dish> coffes = [];
  List<Order> orders = [];

  CoffeHouse() {
    getMainData();
  }
  getMainData() {
    RestController.send_request(
        class_obj: this, controller: 'coffehouse_get', data: '');
    /*основная информация включает в себя основные текстовые данные и меню*/
  }

  void onMainDataAccepted(data) {
    Map<String, dynamic> json = jsonDecode(data);
    print(json);
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    description = json['description'];
    address = json['address'];
    photos = json['photos'];
    coffes = json['coffes'];
    notifyListeners();
  }

  void updateMainInformation() {}

  void updateCoffeHouseImages(List<String> pictures) {
    /*
    метод принимает на вход 
    */
  }

  @override
  void clearData() {
    // TODO: implement clearData
  }

  @override
  void onDataAccepted(data, controller) {
    switch (controller) {
      case 'coffehouse_get':
        onMainDataAccepted(data);
        break;
      case 'myPI':
        // do something else
        break;
    }
    // TODO: implement onDataAccepted
  }
}
