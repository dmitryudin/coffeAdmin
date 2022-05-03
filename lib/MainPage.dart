// ignore_for_file: file_names

import 'package:coffe_admin/Orders/Orders.dart';
import 'package:coffe_admin/controllers/CoffeHouseObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomePage/HomePage.dart';

class MainPage extends StatefulWidget {
  @override
  MyWidget createState() {
    // TODO: implement createState
    return MyWidget();
  }
}

class MyWidget extends State {
  void _onItemTapped(ind) {
    setState(() {
      Provider.of<CoffeHouse>(context, listen: false).getMainData();
      index = ind;
    });
  }

  int index = 0;
  List<Widget> Screens = [
    HomePage(),
    HomePage(),
    Orders(),
  ];
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: Center(child: Screens[index]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber[800],
        currentIndex: index,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Кофейня',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Заказы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'История заказов',
          ),
        ],
      ),
    );
  }
}
