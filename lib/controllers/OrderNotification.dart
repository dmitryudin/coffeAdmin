import 'dart:isolate';

import 'package:coffe_admin/utils/Security/Auth.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../utils/Notifications/NotificationController.dart';

class OrderNotification {
  late IO.Socket socket;
  SendPort? _sendPort;
  void socketReInit() {
    socket = IO.io(
        'http://185.119.58.234:5050',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({
          'foo': 'bar',
          'Authorization': 'Bearer ${Auth().accessToken}',
        }) // optional
            .build());
  }

  OrderNotification(this._sendPort) {
    socketReInit();
    socket.connect();
    socket.onConnect((_) {
      print('connect');
    });
    socket.on('message', (data) {
      NotificationController().showNotification();
      _sendPort!.send('new order');
    });
    socket.onDisconnect((data) => print('disconnect'));
  }
}
