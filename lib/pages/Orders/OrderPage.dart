import 'package:coffe_admin/controllers/OrdersObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../../controllers/DishObject.dart';

class OrderPagePreview extends StatefulWidget {
  late OrderObject orderObject;
  OrderPagePreview(this.orderObject);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderPageState(orderObject);
  }
}

Set onPlace = {true, false};
bool valueRadio = true;
String mytime = '5 минут';

class OrderPageState extends State<OrderPagePreview> {
  late OrderObject orderObject;
  OrderPageState(this.orderObject);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    OrderObject newOrderObject = orderObject;

    List<Widget> coffeLines = [];
    for (Coffe line in newOrderObject.unpackedCoffe) {
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
                  line.selectedVolume.volume.toString() + ' мл',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
                flex: 1,
              ),
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Добавки:',
                    style: TextStyle(
                        color: Color.fromARGB(255, 13, 13, 14),
                        //  fontWeight: FontWeight.bold,
                        fontSize: 15)),
                Text(
                  '    ' +
                      line.properties
                          .map((e) => e.name)
                          .toList()
                          .toString()
                          .replaceAll(new RegExp(r'[^\w\s]'), ''),
                  style: TextStyle(
                      color: Color.fromARGB(255, 54, 152, 244), fontSize: 15),
                ),
              ],
            ),
            Row(children: [
              Expanded(
                child: Text('Количество',
                    style: TextStyle(color: Colors.black, fontSize: 15)),
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
                    style: TextStyle(color: Colors.black, fontSize: 15)),
                flex: 2,
              ),
              Expanded(
                child: Text(
                  line.total.toString(),
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
                            'Итого: ${newOrderObject.totalCost} руб.',
                            style: TextStyle(
                                color: Color.fromARGB(255, 243, 33, 33),
                                fontSize: 25),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Divider(
                            color: Color(0xFF070707),
                            height: 25,
                          ),
                          Container(
                              width: width * 0.9,
                              child: Row(children: [
                                Text('Время готовности:'),
                                Text(
                                  ' ' + mytime + ' ',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 243, 33, 33),
                                      fontSize: 20),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      DatePicker.showDateTimePicker(
                                        context,
                                        locale: LocaleType.ru,
                                        onConfirm: (time) {
                                          print('change $time');
                                          mytime =
                                              time.toString().substring(0, 16);
                                          orderObject.requiredDateTime = mytime;
                                          setState(() {});
                                        },
                                      );
                                    },
                                    child: Text('Выбрать время'))
                              ])),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                    fillColor: MaterialStateColor.resolveWith(
                                        (states) => Colors.green),
                                    focusColor: MaterialStateColor.resolveWith(
                                        (states) => Colors.green),
                                    value: false,
                                    groupValue: valueRadio,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        valueRadio = value!;
                                        orderObject.onPlace = valueRadio;
                                      });
                                    }),
                                Text('С собой'),
                                Radio(
                                    fillColor: MaterialStateColor.resolveWith(
                                        (states) => Colors.green),
                                    focusColor: MaterialStateColor.resolveWith(
                                        (states) => Colors.green),
                                    value: true,
                                    groupValue: valueRadio,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        valueRadio = value!;
                                        orderObject.onPlace = valueRadio;
                                      });
                                    }),
                                Text('На месте'),
                              ]),
                        ],
                      )))),
          ElevatedButton(
            child: Text('Заказать'),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
