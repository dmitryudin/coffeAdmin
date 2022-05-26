import 'package:coffe_admin/Dialogs/EditDishDialog.dart';
import 'package:flutter/material.dart';

class NewDishWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Card(
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditDishDialog(),
                  ));
            },
            child: Container(
                width: width / 2.2,
                child: Column(
                  children: [
                    Text('Нажмите,'),
                    Icon(Icons.coffee, size: width / 3),
                    Text('чтобы добавить кофе'),
                  ],
                ))));
  }
}
