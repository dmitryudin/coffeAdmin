import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_admin/MyWidgets/OrderPreview.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  MyWidget createState() {
    return MyWidget();
  }
}

class MyWidget extends State<UserPage> {
  void updateActiveOrders() {}
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Активные заказы'),
        ),
        body: ListView(children: [OrderPreview()]));
  }
}
