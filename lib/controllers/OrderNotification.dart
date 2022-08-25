class OrderNotification {
  late IO.Socket socket;
  List<OrderObject> activeOrders = [];
  List<OrderObject> usersActiveOrders = [];
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

  OrderNotification() {
    socketReInit();
    socket.connect();
    getActiveOrders();
    socket.onConnect((_) {
      print('connect');
    });
    socket.on('message', (data) {
      getActiveOrders();
      NotificationController().showNotification();

      notifyListeners();
    });
    socket.onDisconnect((data) => print('disconnect'));
    notifyListeners();
  }
}
