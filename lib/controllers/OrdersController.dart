import 'dart:convert';

import 'package:coffe_admin/controllers/OrdersObject.dart';
import 'package:coffe_admin/utils/Notifications/NotificationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../utils/Network/RestController.dart';
import '../utils/Security/Auth.dart';

class OrderController with ChangeNotifier {
  late IO.Socket socket;
  List<OrderObject> activeOrders = [];
  void socketReInit() {
    socket = IO.io(
        'http://thefircoffe.ddns.net:5050',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({
          'foo': 'bar',
          'Authorization': 'Bearer ${Auth().accessToken}',
        }) // optional
            .build());
  }

  OrderController() {
    socketReInit();
    socket.connect();
    getActiveOrders();
    socket.onConnect((_) {
      print('connect');
    });
    socket.on('message', (data) {
      getActiveOrders();
      NotificationController().showNotification();
    });
    socket.onDisconnect((data) => print('disconnect'));
  }

  void getActiveOrders() {
    RestController().sendGetRequest(
        onComplete: ({required String data, required int statusCode}) {
          // print(data);

          List<dynamic> json = jsonDecode(data);

          activeOrders = json
              .map((e) => OrderObject.fromJson(e))
              .toList(); //activeOrders.add(OrderObject.fromJson(e)));
          print('updated');
          notifyListeners();
        },
        onError: ({required int statusCode}) {
          notifyListeners();
        },
        controller: 'active_orders',
        data: '');
    notifyListeners();
  }

  /// chatModel = box.get('abonents');

}
