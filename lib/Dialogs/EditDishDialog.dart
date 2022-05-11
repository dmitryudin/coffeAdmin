import 'package:coffe_admin/MyWidgets/AddPicture.dart';
import 'package:coffe_admin/MyWidgets/MyPicture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditDishDialog extends StatelessWidget {
  String image = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Редактирование меню"),
      content: Column(
        children: [AddPicture(this)],
      ),
    );
    // TODO: implement build
  }
}
