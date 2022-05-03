import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_admin/Dialogs/EditCarousel.dart';
import 'package:coffe_admin/HomePage/Carousel.dart';
import 'package:coffe_admin/controllers/CoffeHouseObject.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
          expandedHeight: height / 3.5,
          flexibleSpace: Stack(children: [
            Positioned(
                child: FlexibleSpaceBar(
                  title:
                      Text(Provider.of<CoffeHouse>(context, listen: true).name),
                  background: Carousel(),
                ),
                top: 0,
                left: 0,
                right: 0,
                bottom: 0),
            Positioned(
              child: IconButton(
                  icon: Icon(Icons.edit_outlined, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EditCarouselDialog(
                            Provider.of<CoffeHouse>(context, listen: true)
                                .photos);
                      },
                    );
                  }),
              top: 20,
              right: 0,
            ),
            Positioned(
              child: Container(
                height: 50,
                //child: Card(),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
              ),
              top: height / 3.3,
              right: 0,
              left: 0,
            ),
          ])),
      SliverList(delegate:
          SliverChildBuilderDelegate((BuildContext context, int index) {
        return GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            children: cof);
      })),
    ]);
  }
}
