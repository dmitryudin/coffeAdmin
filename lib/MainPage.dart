// ignore_for_file: file_names

import 'package:coffe_admin/Orders/Orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
