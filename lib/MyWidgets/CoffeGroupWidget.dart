import 'package:coffe_admin/MyWidgets/DishView.dart';
import 'package:coffe_admin/controllers/DishObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoffeGroupWidget extends StatefulWidget {
  List<DishObject>? dishes;
  ScrollController scrollController = ScrollController();
  String name = '';
  CoffeGroupWidget({required this.dishes, required this.name, Key? key})
      : super(key: key);

  @override
  State<CoffeGroupWidget> createState() =>
      _CoffeGroupWidgetState(dishes: dishes, name: name);
}

class _CoffeGroupWidgetState extends State<CoffeGroupWidget> {
  List<DishObject>? dishes;
  String name = '';
  _CoffeGroupWidgetState({required this.dishes, required this.name, Key? key});
  List<Widget> cof = [];
  int i = -2;
  @override
  Widget build(BuildContext context) {
    i = -2;
    cof = [];
    if (dishes != null) {
      for (var dish in dishes!) {
        cof.add(DishView(dish, key: UniqueKey()));
      }
    }
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Divider(),
      Text(name),
      Divider(),
      ListView.builder(
          padding: EdgeInsets.only(top: 1),
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
    ]);
  }
}
