import 'package:coffe_admin/controllers/OrdersObject.dart';
import 'package:coffe_admin/pages/Orders/OrderPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/OrderPage/OrderPage.dart';

class OrderPreview extends StatefulWidget {
  late OrderObject orderObject;
  OrderPreview(this.orderObject);

  @override
  State<OrderPreview> createState() => _OrderPreviewState(orderObject);
}

class _OrderPreviewState extends State<OrderPreview> {
  late OrderObject orderObject;
  _OrderPreviewState(this.orderObject);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.24,
      child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          semanticContainer: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: Column(children: [
            ListTile(
              tileColor: Colors.teal,
              title: Text('Заказ № ${orderObject.ids}'),
            ),
            Row(
              children: [
                Text(
                  '  Статус: ',
                  style: TextStyle(fontSize: 25, color: Colors.blue),
                ),
                Text('Активен',
                    style: TextStyle(fontSize: 25, color: Colors.green))
              ],
            ),
            Row(
              children: [
                Text('  Стоимость: ',
                    style: TextStyle(fontSize: 25, color: Colors.blue)),
                Text('${orderObject.totalCost}',
                    style: TextStyle(fontSize: 25, color: Colors.red))
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderPagePreview(orderObject)));
                },
                child: Text('Детали заказа'))
          ])),
    );
  }
}
