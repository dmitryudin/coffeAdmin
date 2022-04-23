import 'package:flutter/cupertino.dart';

import 'BasicObject.dart';

class Coffe with ChangeNotifier implements BasicObject {
  @override
  bool flagOfBusy = false;
  String picture = '';
  String name = '';
  double price = 0.0;

  @override
  void clearData() {
    // TODO: implement clearData
  }

  @override
  void onDataAccepted(data, controller) {
    // TODO: implement onDataAccepted
  }
}
