import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_admin/MyWidgets/OrderPreview.dart';
import 'package:coffe_admin/controllers/OrdersController.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() {
    return _OrderPageState();
  }
}

class _OrderPageState extends State<OrderPage> {
  List<Widget> orderPreview = [];
  _OrderPageState() {
    //orderController.getActiveOrders();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    OrderController orderController =
        Provider.of<OrderController>(context, listen: true);

    orderPreview = [];
    for (var order in orderController.activeOrders) {
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
                orderController.getActiveOrders();
              },
              child: Text('Обновить'))
        ]));
  }
}
