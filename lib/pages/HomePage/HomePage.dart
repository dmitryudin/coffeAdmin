import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_admin/Dialogs/EditCarouselDialog.dart';
import 'package:coffe_admin/MyWidgets/Carousel.dart';
import 'package:coffe_admin/MyWidgets/DishView.dart';
import 'package:coffe_admin/MyWidgets/NewDishWidget.dart';
import 'package:coffe_admin/controllers/CoffeHouseObject.dart';
import 'package:coffe_admin/utils/Network/RestController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Это написал я
    double height = MediaQuery.of(context).size.height;
    var coffes = Provider.of<CoffeHouse>(context, listen: true).coffes;
    List<Widget> cof = [];
    for (var coffe in coffes) {
      cof.add(DishView(coffe, key: UniqueKey()));
    }

    cof.add(NewDishWidget());
    int i = -2;
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
                height: 20,
                //child: Card(),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
              ),
              bottom: 0,
              right: 0,
              left: 0,
            ),
          ])),
      SliverList(
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
            ListView.builder(
                itemCount: (cof.length / 2).ceil().toInt(),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  i = i + 2;
                  if (cof.length - i == 1)
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [cof.last],
                    );
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [cof[i], cof[i + 1]],
                  );
                })
          ],
        ),
      )
    ]);
  }
}
