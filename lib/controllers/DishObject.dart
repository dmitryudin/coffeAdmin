import 'package:flutter/cupertino.dart';

import 'BasicObject.dart';

class Property {
  double price = 0.0;
  String name = '';
  String value = '';
  bool used = false;
  bool selected = false;
}

class Dish with ChangeNotifier implements BasicObject {
  @override
  bool flagOfBusy = false;
  String picture = '';
  String name = '';
  double price = 0.0;
  String category = '';
  List<Property> properties = [];

  @override
  void clearData() {
    // TODO: implement clearData
  }

  @override
  void onDataAccepted(data, controller) {
    // TODO: implement onDataAccepted
  }
}
