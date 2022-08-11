import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../utils/Network/RestController.dart';
import 'DishObject.dart';

class OrderObject with ChangeNotifier {
  int ids = 0;
  int idPayment = -1;
  bool onPlace = false;
  String requiredDateTime = '';
  bool isComplete = false;
  double totalCost = 0.0;
  List<Coffe> unpackedCoffe = [];

  OrderObject();

  OrderObject.fromJson(Map<String, dynamic> json) {
    // Map<String, dynamic> jsonString = jsonDecode(json);
    idPayment = json['id_payment'];
    ids = json['id'];
    requiredDateTime = json['required_datetime'];
    //onPlace = json['on_place'];
    totalCost = json['total_cost'];

    unpackedCoffe = (json['positions'] as List)
        .map((item) => Coffe.fromOrderJson(jsonEncode(item)))
        .toList();
    print('----------------------------------------------------');
    print('айди платежа $idPayment');
    print('требуемое время $requiredDateTime');
    print('Итоговая стоимость $totalCost');
    print('На месте $onPlace');
  }
}
