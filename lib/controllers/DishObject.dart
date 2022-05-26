import 'dart:convert';
import 'package:flutter/cupertino.dart';

class Property {
  Property();
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

  Property.fromJsonString({jsonString}) {
    name = jsonString['name'];
    price = jsonString['price'];
  }
}

class Volume {
  Volume();
  double volume = 0;
  double price = 0;
  Volume.fromJsonString({jsonString}) {
    volume = jsonString['volume'];
    price = jsonString['price'];
  }
  String toJson() {
    Map<String, dynamic> data = {};
    data['volume'] = volume;
    data['price'] = price;
    String json = jsonEncode(data);
    return json;
  }
}

class Coffe with ChangeNotifier {
  Coffe();
  int id = -1;
  String category = '';
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
    data['category'] = category;
    data['priceOfVolume'] =
        priceOfVolume.map((e) => jsonDecode(e.toJson())).toList();
    data['properties'] = properties.map((e) => jsonDecode(e.toJson())).toList();
    String json = jsonEncode(data);
    print(json);
    return json;
  }

  Coffe.fromJson(var data) {
    Map<String, dynamic> jsonString = jsonDecode(data);
    name = jsonString['name'];
    id = jsonString['id'];
    description = jsonString['description'];
    category = jsonString['category'];

    if (!jsonString['photo'].isEmpty) picture = jsonString['photo'].last;
    for (var el in jsonString['volumes'])
      this.priceOfVolume.add(Volume.fromJsonString(jsonString: el));
    for (var el in jsonString['suppliments'])
      this.properties.add(Property.fromJsonString(jsonString: el));
  }
}
