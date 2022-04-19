import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_admin/HomePage/Carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        pinned: false,
        snap: false,
        floating: true,
        expandedHeight: 160.0,
        flexibleSpace: FlexibleSpaceBar(
          title: Text('SliverAppBar'),
          background: Carousel(),
        ),
      ),
      SliverList(delegate:
          SliverChildBuilderDelegate((BuildContext context, int index) {
        return GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            children: cof);
      })),
    ]);

    /*ListView(children: [
      Carousel(),
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 0, 40, 160),
                  Color.fromARGB(255, 79, 118, 247),
                ],
              )),
          child: Column(children: [
            SizedBox(
              height: 26,
            ),
            GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                children: cof),
          ]))
    ]);*/
  }
}
