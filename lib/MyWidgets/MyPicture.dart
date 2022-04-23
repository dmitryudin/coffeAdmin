import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PictureWidget extends StatefulWidget {
  String url = '';

  PictureWidget({required this.url, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyPicture(url);
  }
}

class MyPicture extends State<PictureWidget> {
  String url = '';

  MyPicture(this.url);
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  var myImg;
  @override
  Widget build(BuildContext context) {
    myImg = Column(
      children: [
        Text('Нажмите'),
        Icon(Icons.add_a_photo),
        Text('чтобы добавить фото', textAlign: TextAlign.center),
      ],
    );

    return GestureDetector(
        onTap: () async {
          image = await _picker.pickImage(
            source: ImageSource.gallery,
            imageQuality: 50,
          );

          setState(() {
            // setImage();
          });
        },
        child: Column(
          children: <Widget>[myImg],
        ));
  }
}
