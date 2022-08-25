import 'package:coffe_admin/controllers/OrdersObject.dart';
import 'package:coffe_admin/pages/OrderPage/OrderDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPreview extends StatefulWidget {
  OrderObject? orderObject;
  OrderPreview(this.orderObject, {Key? key}) : super(key: key);

  @override
  State<OrderPreview> createState() => _OrderPreviewState(orderObject);
}

class _OrderPreviewState extends State<OrderPreview> {
  OrderObject? orderObject;
  _OrderPreviewState(this.orderObject);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
        height: height * 0.28,
        width: width * 0.95,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15))),
          elevation: 20,
          child: Column(children: [
            ListTile(
              leading: Icon(Icons.notifications),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15))),
              title: Text(
                'Заказ № ${orderObject!.ids}',
                style: TextStyle(fontSize: height * 0.028),
              ),
              tileColor: Colors.green,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Container(
                width: width * 0.95,
                child: Table(

                    // textDirection: TextDirection.rtl,
                    // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                    border: TableBorder.all(width: 0.5, color: Colors.grey),
                    children: [
                      TableRow(children: [
                        Text(
                          "Цена",
                          style: TextStyle(
                              color: Color.fromARGB(255, 56, 165, 255)),
                          textScaleFactor: 1.2,
                        ),
                        Text("${orderObject!.totalCost} руб.",
                            textScaleFactor: 1.2),
                        // Text("University", textScaleFactor: 1.5),
                      ]),
                      TableRow(children: [
                        Text(
                          "Время готовности",
                          textScaleFactor: 1.2,
                          style: TextStyle(
                              color: Color.fromARGB(255, 56, 165, 255)),
                        ),
                        Text("${orderObject!.requiredDateTime}",
                            textScaleFactor: 1.2),
                        // Text("University", textScaleFactor: 1.5),
                      ]),
                      TableRow(children: [
                        Text(
                          "Статус:",
                          textScaleFactor: 1.2,
                          style: TextStyle(
                              color: Color.fromARGB(255, 56, 165, 255)),
                        ),
                        orderObject!.isAccepted
                            ? Text("Заказ принят", textScaleFactor: 1.2)
                            : Text("Ожидает подтвержения", textScaleFactor: 1.2)
                        // Text("University", textScaleFactor: 1.5),
                      ]),
                      TableRow(children: [
                        Text(
                          "Телефон пользователя",
                          textScaleFactor: 1.2,
                          style: TextStyle(
                              color: Color.fromARGB(255, 56, 165, 255)),
                        ),
                        Text(orderObject!.userPhone.toString(),
                            textScaleFactor: 1.2)

                        // Text("University", textScaleFactor: 1.5),
                      ]),
                    ])),
            SizedBox(
              height: height * 0.01,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderDetailsPage(orderObject)));
                },
                child: Text('Детали заказа'))
          ]),
        ));
  }
}
