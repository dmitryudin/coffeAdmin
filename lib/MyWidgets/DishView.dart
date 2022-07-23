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
        height: height / 2.5,
        padding: const EdgeInsets.only(top: 4.0),
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: Colors.grey[800]),
        child: Column(children: [
          Container(
            width: width / 2.15,
            height: height / 3.95,
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
      Text(coffe.name,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center, 
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        
          ]
        ),
      ),
          Positioned(
          bottom: 55,
          left: 15,
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

        Positioned(
          bottom: 10,
          left: 8,
          child: Container(
                        width: width / 2.2,
            height: height / 15,
          
            decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(14.0)),
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
          ),
        
        
    
      Positioned(
          top: 4,
          right: -16,
          child: RawMaterialButton(
            onPressed: () {
              Provider.of<CoffeHouse>(context, listen: false)
                  .deleteCoffe(coffe);
            },
            elevation: 1.0,
            fillColor: Colors.grey[500],
            child: Icon(
              Icons.close_sharp,
              color: Colors.black,
              size: 18.0,
            ),
            padding: EdgeInsets.all(7.0),
            shape: CircleBorder(),
          )),
    ]
    );
  }
}
