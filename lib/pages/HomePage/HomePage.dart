import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_admin/Dialogs/EditCarouselDialog.dart';
import 'package:coffe_admin/MyWidgets/Carousel.dart';
import 'package:coffe_admin/MyWidgets/CoffeGroupWidget.dart';
import 'package:coffe_admin/MyWidgets/DishView.dart';
import 'package:coffe_admin/MyWidgets/NewCakeWidget.dart';
import 'package:coffe_admin/MyWidgets/NewDishWidget.dart';
import 'package:coffe_admin/controllers/CoffeHouseObject.dart';
import 'package:coffe_admin/controllers/DishObject.dart';
import 'package:coffe_admin/utils/DataStorage/KeyStorage.dart';
import 'package:coffe_admin/utils/Network/RestController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import "package:collection/collection.dart";
import '../../controllers/OrdersController.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int index = KeyStorage().keyStore['index'];
  final focusKey = ValueKey('focus');
  @override
  Widget build(BuildContext context) {
    // Это написал я
    KeyStorage().keyStore['index'] = index;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var coffes = Provider.of<CoffeHouse>(context, listen: true).coffes;
    List<Widget> cofWidget = [];
    List<Widget> cakeWidget = [];
    List<DishObject> coffesObj = [];
    List<DishObject> cakeObj = [];

    for (var coffe in coffes) {
      coffe.category == 'coffe' ? coffesObj.add(coffe) : cakeObj.add(coffe);
    }
    Map k = groupBy(coffesObj, (DishObject obj) => obj.subcategory);
    for (String dish in k.keys) {
      cofWidget
          .add(CoffeGroupWidget(dishes: k[dish], name: dish, key: UniqueKey()));
    }
    Map t = groupBy(cakeObj, (DishObject obj) => obj.subcategory);
    for (String dish in t.keys) {
      cakeWidget.add(CoffeGroupWidget(
        dishes: t[dish],
        name: dish,
        key: UniqueKey(),
      ));
    }

    cofWidget.add(NewDishWidget());
    cakeWidget.add(NewCakeWidget());
    int i = -2;
    // TODO: implement build
    return CustomScrollView(center: focusKey, slivers: <Widget>[
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
                  icon: Icon(Icons.edit_outlined),
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
                height: 20,
                //child: Card(),
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35)),
                ),
              ),
              bottom: 0,
              right: 0,
              left: 0,
            ),
          ])),
      SliverList(
        key: focusKey,
        delegate: SliverChildListDelegate(
          [
            Card(
                child: Column(children: [
              Row(children: [
                Text('Адрес   '),
                Text(Provider.of<CoffeHouse>(context, listen: true).address),
              ]),
              Row(children: [
                Text('Телефон   '),
                Text(Provider.of<CoffeHouse>(context, listen: true).phone),
              ]),
              Row(children: [
                Text('Email   '),
                Text(Provider.of<CoffeHouse>(context, listen: true).email),
              ]),
            ])),
            Row(
              children: [
                SizedBox(
                    width: width / 2,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: index == 0
                                ? MaterialStateProperty.all(Colors.red)
                                : MaterialStateProperty.all(
                                    Color.fromARGB(255, 37, 37, 19))),
                        onPressed: () {
                          setState(() {
                            index = 0;
                            print(index);
                          });
                        },
                        child: Text('Напитки'))),
                SizedBox(
                    width: width / 2,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: index == 1
                              ? MaterialStateProperty.all(Colors.red)
                              : MaterialStateProperty.all(
                                  Color.fromARGB(255, 37, 37, 19)),
                        ),
                        onPressed: () {
                          setState(() {
                            print(index);
                            index = 1;
                          });
                        },
                        child: Text('Кондитерка'))),
              ],
            ),
            index == 0
                ? Column(children: cofWidget)
                : Column(children: cakeWidget)
          ],
        ),
      )
    ]);
  }
}
