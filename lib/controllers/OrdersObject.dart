import 'package:coffe_admin/utils/Notifications/NotificationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../utils/Security/Auth.dart';

class OrderController with ChangeNotifier {
  late IO.Socket socket;

  late var box;
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

  OrderController() {}

  void connect(address) {
    socketReInit();
    socket.connect();
  }

  void sendMessage(String senderLogin, String recieverLogin, message) {
    String jsonString =
        '{"sender_login":"$senderLogin", "reciever_login":"$recieverLogin", "message":"$message"}';
    socketReInit();
    socket.emit('message', jsonString);
  }

  void statusRequest(String recieverLogin) {
    String jsonString = '{"reciever_login":"$recieverLogin"}';
    socketReInit();
    socket.emit('status', jsonString);
  }

  void sendTyping(String senderLogin, String recieverLogin) {
    String jsonString =
        '{"sender_login":"$senderLogin", "reciever_login":"$recieverLogin"';
    socketReInit();
    socket.emit('typing', jsonString);
  }

  void sendFriendlyRequest(String senderLogin, String recieverLogin) {
    String jsonString =
        '{"sender_login":"$senderLogin", "reciever_login":"$recieverLogin"';
    socketReInit();
    socket.emit('typing', jsonString);
    socketReInit();
  }

  void getActiveOrders() {}

  /// chatModel = box.get('abonents');
  notifyListeners();
}
