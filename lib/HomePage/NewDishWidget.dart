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
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EditDishDialog();
                  });
            },
            child: Column(
              children: [
                Icon(Icons.coffee, size: width / 2),
              ],
            )));
  }
}
