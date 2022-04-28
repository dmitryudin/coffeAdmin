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
  List<String> pictures = [
    'https://avatars.mds.yandex.net/get-zen_doc/1874839/pub_5dcd7bfccd7152643c8dcf60_5dcd7c1777c1617acad09dd6/scale_1200',
    'https://avatars.mds.yandex.net/get-zen_doc/1874839/pub_5dcd7bfccd7152643c8dcf60_5dcd7c1777c1617acad09dd6/scale_1200'
  ];

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
    // TODO: implement onDataAccepted
  }
}
