import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_admin/HomePage/Carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < 30; i++) {
      widgets.add(Card(
          child: Column(children: [
        CachedNetworkImage(
            imageUrl:
                'https://www.thespruceeats.com/thmb/iYCclWmk5rE1gLdE--uYELPhTL4=/5760x3840/filters:no_upscale():max_bytes(150000):strip_icc()/fancy-raspberry-mousse-cake-dessert-462334687-813bea322cfb4b3184cad39f2b201072.jpg'),
        //Text('nothing'),
        const ListTile(
          tileColor: Colors.orange,
          title: Text(
            "Тортики слоёные",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ])));
    }

    List<Widget> cof = [];
    for (int i = 0; i < 30; i++) {
      cof.add(Card(
          child: Column(children: [
        CachedNetworkImage(
            imageUrl:
                'https://wallbox.ru/wallpapers/main2/201725/14978928755948080b1a38d9.12077544.jpg'),
        //Text('nothing'),
        const ListTile(
          tileColor: Colors.orange,
          title: Text(
            "Вкуснейший кофе",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ])));
    }
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
        body: ListView(children: [
      Carousel(),
      DefaultTabController(
          length: 2,
          child: Column(children: [
            const TabBar(
              indicatorColor: Colors.red,
              labelColor: Colors.black,
              tabs: [
                Tab(icon: Icon(Icons.coffee)),
                Tab(icon: Icon(Icons.cake)),
              ],
            ),
            Container(
                height: width * widgets.length / 4,
                child: TabBarView(children: [
                  GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: cof),
                  GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: widgets),
                ]))
          ])),
    ]));
  }
}
