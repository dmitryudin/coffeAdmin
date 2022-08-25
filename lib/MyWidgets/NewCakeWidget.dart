import 'package:coffe_admin/Dialogs/EditCakeDialog.dart';
import 'package:coffe_admin/Dialogs/EditDishDialog.dart';
import 'package:flutter/material.dart';

class NewCakeWidget extends StatelessWidget {
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
                    builder: (context) => EditCakeDialog(),
                  ));
            },
            child: Container(
                width: width / 2.1,
                child: Column(
                  children: [
                    Text('Нажмите,'),
                    Icon(Icons.cake, size: width / 3),
                    Text('чтобы добавить кондитерку'),
                  ],
                ))));
  }
}
