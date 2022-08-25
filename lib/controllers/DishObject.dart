import 'dart:convert';
import 'package:flutter/cupertino.dart';

class Option {
  Option() {}
  double price = 0.0;
  String name = '';
  int count = 1;
  bool isSelected = false;

  String toJson() {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['price'] = price;
    data['is_selected'] = isSelected;
    String json = jsonEncode(data);
    return json;
  }

  Option.fromJson(String json) {
    Map<String, dynamic> jsonMap = jsonDecode(json);

    name = jsonMap['name'];
    price = jsonMap['price'];
    isSelected = jsonMap['is_selected'];
  }
}

class FieldSelection {
  String name = '';
  List<Option> fields = [];
  Option selectedField = Option();
  FieldSelection() {}

  String toJson() {
    Map<String, dynamic> jsonMap = {};
    jsonMap['name'] = name;
    jsonMap['fields'] = fields.map((e) => jsonDecode(e.toJson())).toList();
    jsonMap['selected_field'] = jsonDecode(selectedField.toJson());
    String json = jsonEncode(jsonMap);
    return json;
  }

  FieldSelection.fromJson(String json) {
    Map<String, dynamic> jsonMap = jsonDecode(json);

    name = jsonMap['name'];

    selectedField = Option.fromJson(jsonEncode(jsonMap['selected_field']));
    List<dynamic> temp = jsonMap['fields'];
    fields = temp.map((e) => (Option.fromJson(jsonEncode(e)))).toList();
  }
}

class DishObject with ChangeNotifier {
  DishObject();
  int id = -1;
  String category = '';
  String subcategory = '';
  String name = '';
  String description = '';
  String picture = '';
  double weight = 0.0;
  double basePrice = 0.0;
  double totalCost = 0.0;
  int count = 1;

  FieldSelection fieldSelection = FieldSelection();
  List<Option> options = [];

  String toJson() {
    Map<String, dynamic> data = {};
    data['category'] = category;
    data['subcategory'] = subcategory;
    data['name'] = name;
    data['description'] = description;
    data['picture'] = picture;
    data['weight'] = weight;
    data['base_price'] = basePrice;
    data['total_cost'] = totalCost;
    data['count'] = count;
    data['options'] = options.map((e) => jsonDecode(e.toJson())).toList();
    if (!fieldSelection.fields.isEmpty)
      data['field_selection'] = jsonDecode(fieldSelection.toJson());
    else
      data['field_selection'] = [];
    return jsonEncode(data);
  }

  DishObject.fromJson(String data) {
    Map<String, dynamic> jsonMap = jsonDecode(data);

    category = jsonMap['category'];
    subcategory = jsonMap['subcategory'];
    name = jsonMap['name'];

    description = jsonMap['description'];
    picture = jsonMap['picture'];
    weight = jsonMap['weight'];
    basePrice = jsonMap['base_price'];
    try {
      totalCost = jsonMap['total_cost'];
      count = jsonMap['count'];
    } catch (e) {
      // Обработка возникшего исключения
    }

    fieldSelection =
        FieldSelection.fromJson(jsonEncode(jsonMap['field_selection']));

    List<dynamic> temp = jsonMap['options'];
    options = temp.map((e) => (Option.fromJson(jsonEncode(e)))).toList();
  }

  DishObject getDeepCopy() {
    DishObject deepDishCopy = DishObject();
    deepDishCopy.id = this.id;
    deepDishCopy.category = this.category;
    deepDishCopy.picture = this.picture;
    deepDishCopy.name = this.name;
    deepDishCopy.count = int.parse(this.count.toString());
    deepDishCopy.description = this.description;
    deepDishCopy.options = this.options;
    deepDishCopy.fieldSelection = this.fieldSelection;
    return deepDishCopy;
  }

  bool _compareCoffeLists(List<Option> list1, list2) {
    if (list1.length == list2.length) {
      for (int i = 0; i < list1.length; i++) {
        if ((list1[i].name != list2[i].name) ||
            (list1[i].isSelected != list2[i].isSelected)) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  bool compareWith(DishObject template) {
    return (template.id == this.id &&
        template.category == this.category &&
        template.picture == this.picture &&
        template.name == this.name &&
        template.count == int.parse(this.count.toString()) &&
        template.description == this.description &&
        template.fieldSelection!.selectedField.toString() ==
            this.fieldSelection!.selectedField.toString() &&
        _compareCoffeLists(template.options, this.options));
  }

  double getTotal() {
    double counter = 0.0;
    counter = counter +
        this.fieldSelection!.selectedField!.price *
            this.fieldSelection!.selectedField!.count;
    for (Option item in this.options) {
      if (item.isSelected) counter = counter + item.price;
    }
    counter = counter * this.count;
    totalCost = counter;
    return totalCost + basePrice;
  }
}
