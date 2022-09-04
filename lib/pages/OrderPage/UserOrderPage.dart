import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_admin/MyWidgets/OrderPreview.dart';
import 'package:coffe_admin/controllers/OrdersController.dart';
import 'package:coffe_admin/controllers/OrdersObject.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserOrderPage extends StatefulWidget {
  int userId = -1;
  UserOrderPage({Key? key}) : super(key: key);

  @override
  _UserOrderPageState createState() {
    return _UserOrderPageState(userId);
  }
}

class _UserOrderPageState extends State<UserOrderPage> {
  List<Widget> orderPreview = [];
  int userId = -1;
  _UserOrderPageState(this.userId) {
    //OrderController().getUsersActiveOrders(userId);
  }

  @override
  Widget build(BuildContext context) {
    print('order page user rebuild');
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<OrderObject> activeOrders =
        Provider.of<OrderController>(context, listen: true).usersActiveOrders;

    orderPreview = [];
    for (var order in activeOrders) {
      orderPreview.add(OrderPreview(order));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Активные заказы'),
        ),
        body: ListView(children: [
          Column(children: orderPreview),
          ElevatedButton(
              onPressed: () {
                // orderController.getActiveOrders();
              },
              child: Text('Обновить'))
        ]));
  }
}
