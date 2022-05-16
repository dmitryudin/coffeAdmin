import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'BasicObject.dart';

class Property {
  double price = 0.0;
  String name = '';
  bool initialValue = false;
  bool used = false;
  bool selected = false;

  String toJson() {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['price'] = price;
    String json = jsonEncode(data);
    return json;
  }
}

class Volume {
  double volume = 0;
  double price = 0;

  String toJson() {
    Map<String, dynamic> data = {};
    data['volume'] = volume;
    data['price'] = price;
    String json = jsonEncode(data);
    return json;
  }
}

class Coffe with ChangeNotifier implements BasicObject {
  @override
  String category = '';
  bool flagOfBusy = false;
  String picture = '';
  String name = '';
  String description = '';
  List<Volume> priceOfVolume = [];
  List<Property> properties = [];
  String toJson() {
    Map<String, dynamic> data = {};

    data['name'] = name;
    data['picture'] = picture;
    data['description'] = description;

    data['priceOfVolume'] =
        priceOfVolume.map((e) => jsonDecode(e.toJson())).toList();
    data['properties'] = properties.map((e) => jsonDecode(e.toJson())).toList();
    String json = jsonEncode(data);
    print(json);
    return json;
  }

  @override
  void clearData() {
    // TODO: implement clearData
  }

  @override
  void onDataAccepted(data, controller) {
    // TODO: implement onDataAccepted
  }
}
