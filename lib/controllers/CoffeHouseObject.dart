import 'package:flutter/cupertino.dart';
import 'BasicObject.dart';
import 'CoffeObject.dart';

class CoffeHouse with ChangeNotifier implements BasicObject {
  @override
  bool flagOfBusy = false;
  String name = '';
  String token = '';
  String description = '';
  List<Coffe> coffe = [];
  List<String> pictures = [];

  void updateMainInformation() {}

  void updateCoffeHouseImages(List<String> pictures) {}

  @override
  void clearData() {
    // TODO: implement clearData
  }

  @override
  void onDataAccepted(data, controller) {
    // TODO: implement onDataAccepted
  }
}
