import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PictureWidget extends StatefulWidget {
  var baseClass;

  PictureWidget(this.baseClass);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyPicture(baseClass);
  }
}

class MyPicture extends State<PictureWidget> {
  var baseClass;

  MyPicture(this.baseClass);
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  var myImg;
  @override
  Widget build(BuildContext context) {
    myImg = Card(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Нажмите'),
      Icon(Icons.add_a_photo, size: 60),
      Text('чтобы добавить фото', textAlign: TextAlign.center),
    ]));

    return GestureDetector(
      onTap: () async {
        image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
        );

        setState(() {
          baseClass.images.add(image!.path);
          baseClass.setState(() {});
        });
      },
      child: myImg,
    );
  }
}
