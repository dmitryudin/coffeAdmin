import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPreview extends StatefulWidget {
  OrderPreview({Key? key}) : super(key: key);

  @override
  State<OrderPreview> createState() => _OrderPreviewState();
}

class _OrderPreviewState extends State<OrderPreview> {
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
              title: Text('Заказ № 566'),
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
                Text('565 руб.',
                    style: TextStyle(fontSize: 25, color: Colors.red))
              ],
            ),
            ElevatedButton(onPressed: () {}, child: Text('Детали заказа'))
          ])),
    );
  }
}
