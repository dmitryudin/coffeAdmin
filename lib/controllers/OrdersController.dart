import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

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
  int uid = -1;
  List<OrderObject> activeOrders = [];
  List<OrderObject> usersActiveOrders = [];

  static final OrderController _orderController = OrderController._instance();

  factory OrderController() {
    _orderController.getActiveOrders();
    return _orderController;
  }
  OrderController._instance();

  void setState() {
    notifyListeners();
  }

  void getActiveOrders() {
    RestController().sendGetRequest(
        onComplete: ({required String data, required int statusCode}) {
          // print(data);
          print('start getting active order!');

          List<dynamic> json = jsonDecode(data);
          print('json decoded');
          try {
            activeOrders =
                json.map((e) => OrderObject.fromJson(jsonEncode(e))).toList();
            print('active oreder parsed');
          } catch (e) {
            //activeOrders.add(OrderObject.fromJson(e)));

          } finally {
            setState();
            notifyListeners();
            print('notified');
          }
        },
        onError: ({required int statusCode}) {},
        controller: 'active_orders',
        data: '');
    // notifyListeners();
  }

  void getUsersActiveOrders(int user_id) {
    uid = user_id;
    RestController().sendGetRequest(
        onComplete: ({required String data, required int statusCode}) {
          // print(data);

          List<dynamic> json = jsonDecode(data);

          usersActiveOrders = json
              .map((e) => OrderObject.fromJson(jsonEncode(e)))
              .toList(); //activeOrders.add(OrderObject.fromJson(e)));

          notifyListeners();
        },
        onError: ({required int statusCode}) {
          notifyListeners();
        },
        controller: 'active_orders_by_user_id',
        data: '?user_id=$user_id');
    notifyListeners();
  }

  void deleteOrder(int id) {
    RestController().sendDeleteRequest(
        onComplete: ({required String data, required int statusCode}) {
          getActiveOrders();
          getUsersActiveOrders(uid);
        },
        onError: ({required int statusCode}) {
          getActiveOrders();
          getUsersActiveOrders(uid);
        },
        controller: 'order',
        data: '{"order_id":$id}');

    notifyListeners();
  }

  void acceptOrder(int id) {
    RestController().sendGetRequest(
        onComplete: ({required String data, required int statusCode}) {
          notifyListeners();
        },
        onError: ({required int statusCode}) {
          notifyListeners();
        },
        controller: 'accept_order',
        data: '?order_id=$id');
    notifyListeners();
  }

  /// chatModel = box.get('abonents');

}
