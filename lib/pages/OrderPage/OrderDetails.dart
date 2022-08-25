import 'package:coffe_admin/controllers/OrdersController.dart';
import 'package:coffe_admin/controllers/OrdersObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../../controllers/DishObject.dart';

class OrderDetailsPage extends StatefulWidget {
  OrderObject? _orderObject;
  OrderDetailsPage(this._orderObject);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderDetailsPageState(this._orderObject);
  }
}

Set onPlace = {true, false};
bool valueRadio = true;
String mytime = '5 минут';

class OrderDetailsPageState extends State<OrderDetailsPage> {
  OrderObject? _orderObject;
  OrderDetailsPageState(this._orderObject);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    OrderController orderController =
        Provider.of<OrderController>(context, listen: true);

    List<Widget> coffeLines = [];
    for (DishObject line in _orderObject!.unpackedCoffe) {
      coffeLines.add(Container(
          width: width * 0.85,
          child: Column(children: [
            Row(children: [
              Expanded(
                child: Text(line.name,
                    style: TextStyle(
                        color: Color.fromARGB(255, 252, 172, 24),
                        fontSize: 20)),
                flex: 2,
              ),
              Expanded(
                child: Text(
                  line.fieldSelection.selectedField!.name + ' мл',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
                flex: 1,
              ),
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    flex: 1,
                    child: Text('Добавки:',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            //  fontWeight: FontWeight.bold,
                            fontSize: 15))),
                Expanded(
                    flex: 1,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: line.options.length,
                        itemBuilder: (BuildContext context, int index) {
                          return line.options[index].isSelected
                              ? Text(line.options[index].name,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 15))
                              : Text(line.options[index].name,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 15));
                        })),
              ],
            ),
            Row(children: [
              Expanded(
                child: Text('Количество',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15)),
                flex: 2,
              ),
              Expanded(
                child: Text(
                  line.count.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
                flex: 1,
              ),
            ]),
            Row(children: [
              Expanded(
                child: Text('Стоимость',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15)),
                flex: 2,
              ),
              Expanded(
                child: Text(
                  line.totalCost.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
                flex: 1,
              ),
            ]),
            Divider(color: Color.fromARGB(255, 8, 8, 8)),
            SizedBox(
              height: 10,
            ),
          ])));
    }
    return Scaffold(
        appBar: AppBar(title: Text('Оформление заказа')),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Container(
                      width: width * 0.97,
                      child: Card(
                          elevation: 15,
                          child: Column(
                            children: [
                              ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15))),
                                title: Text('Детали заказа'),
                                tileColor: Colors.green,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Column(
                                children: coffeLines,
                              ),
                              Divider(
                                color: Color(0xFF070707),
                                height: 25,
                              ),
                              Text(
                                'Итого: ${_orderObject!.totalCost} руб.',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 243, 33, 33),
                                    fontSize: 25),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              !_orderObject!.isAccepted
                                  ? TextButton(
                                      onPressed: () {
                                        orderController
                                            .acceptOrder(_orderObject!.ids);
                                        orderController.notifyListeners();
                                      },
                                      child: Text('Принять'))
                                  : Row(key: UniqueKey()),
                              ElevatedButton(
                                  onPressed: () {
                                    orderController
                                        .deleteOrder(_orderObject!.ids);
                                    orderController.getActiveOrders();
                                    orderController.notifyListeners();

                                    Navigator.pop(context);
                                  },
                                  child: Text('Заказ исполнен')),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ))))
            ]));
  }
}
