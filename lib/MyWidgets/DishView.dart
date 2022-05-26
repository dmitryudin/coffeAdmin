import 'package:coffe_admin/controllers/CoffeHouseObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/DishObject.dart';

class DishView extends StatefulWidget {
  Coffe coffe;
  DishView(this.coffe, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MyDishView(coffe); // TODO: implement createState
  }
}

class MyDishView extends State<DishView> {
  late Coffe coffe;
  MyDishView(this.coffe);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(children: [
      Container(
        width: width / 2.05,
        // height: height / 3,
        padding: const EdgeInsets.only(top: 2.0),
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: Colors.grey[600]),
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(2), // Border width
            decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20.0)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: SizedBox.fromSize(
                size: Size.fromRadius(70), // Image radius
                child: Image.network(coffe.picture, fit: BoxFit.cover),
              ),
            ),
          ),
          Text(
            coffe.name,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              !coffe.priceOfVolume.isEmpty
                  ? coffe.priceOfVolume[0].volume.toString()
                  : '',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[350],
              ),
            ),
          ),
          Container(
            width: 135,
            height: 35,
            margin: const EdgeInsets.only(
                bottom:
                    1.0), //Не могу привязать контейнер c ценой к нижнему краю внешнего контейнера!!!!!!!!!! (Только если каждому элементу добавлять Padding)
            decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Text(
                !coffe.priceOfVolume.isEmpty
                    ? coffe.priceOfVolume[0].volume.toString()
                    : '',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]),
      ),
      Positioned(
          top: 10,
          right: -15,
          child: RawMaterialButton(
            onPressed: () {
              Provider.of<CoffeHouse>(context, listen: false)
                  .deleteCoffe(coffe);
            },
            elevation: 2.0,
            fillColor: Colors.blue[100],
            child: Icon(
              Icons.close_sharp,
              color: Colors.red,
              size: 15.0,
            ),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          )),
    ]);
  }
}
