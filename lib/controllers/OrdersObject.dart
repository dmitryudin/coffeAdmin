import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../utils/Network/RestController.dart';
import 'DishObject.dart';

class OrderObject with ChangeNotifier {
  int idPayment = -1;
  int ids = -1;
  bool onPlace = false;
  String requiredDateTime = '';
  bool isComplete = false;
  bool isAccepted = false;
  int userId = -1;
  String userPhone = '';
  double totalCost = 0.0;
  List<DishObject> unpackedCoffe = [];

  OrderObject();

  OrderObject.fromJson(String json) {
    Map<String, dynamic> jsonMap = jsonDecode(json);
    idPayment = jsonMap['id_payment'];
    ids = jsonMap['id'];
    userId = jsonMap['user_id'];

    requiredDateTime = jsonMap['required_datetime'];
    userPhone = jsonMap['user_phone'];
    onPlace = jsonMap['on_place'];
    isAccepted = jsonMap['is_accepted'];
    totalCost = jsonMap['total_cost'];

    unpackedCoffe = (jsonMap['positions'] as List)
        .map((item) => DishObject.fromJson(jsonEncode(item)))
        .toList();
  }
}
