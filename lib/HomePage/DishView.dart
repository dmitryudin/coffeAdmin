import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DishView extends StatefulWidget {
  int id;
  DishView(this.id);
  @override
  State<StatefulWidget> createState() {
    return MyDishView(id); // TODO: implement createState
  }
}

class MyDishView extends State<DishView> {
  int id = -1;
  MyDishView(this.id);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
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
              color: Colors.black54, borderRadius: BorderRadius.circular(20.0)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: SizedBox.fromSize(
              size: Size.fromRadius(70), // Image radius
              child: Image.network(
                  'https://sun9-35.userapi.com/s/v1/if2/aKvxSDy13LCl2AwQJeG7usaAO0QoyVPAIjLNbyTz1j1ZHUVchTG9fx90QCEmtiOXlAE3xuqa_mPsvo7HEp4myl5m.jpg?size=864x1080&quality=96&type=album',
                  fit: BoxFit.cover),
            ),
          ),
        ),
        const Text(
          'Название напитка полностью',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            ' 300 мл',
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
              color: Colors.black54, borderRadius: BorderRadius.circular(10.0)),
          child: const Center(
            child: Text(
              '200 ₽',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
