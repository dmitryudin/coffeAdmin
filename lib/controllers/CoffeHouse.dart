import 'package:flutter/cupertino.dart';
import 'BasicObject.dart';
import 'Coffe.dart';

class CoffeHouse with ChangeNotifier implements BasicObject {
  @override
  bool flagOfBusy = false;
  String name = '';
  String token = '';
  String description = '';
  List<Coffe> coffe = [];
  List<String> pictures = [];

  void sendData() {}

  @override
  void clearData() {
    // TODO: implement clearData
  }

  @override
  void onDataAccepted(data, controller) {
    // TODO: implement onDataAccepted
  }
}
