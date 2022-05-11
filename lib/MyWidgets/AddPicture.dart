import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPicture extends StatefulWidget {
  late var basicClass;
  AddPicture(this.basicClass);

  @override
  MyGallery createState() {
    return MyGallery(basicClass);
  }
}

class MyGallery extends State<AddPicture> {
  late var basicClass;

  bool isActive = true;
  MyGallery(this.basicClass);

  final ImagePicker _picker = ImagePicker();
  XFile? image;
  var myImg;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (basicClass.image.contains('http') || !isActive)
      myImg = CachedNetworkImage(
        placeholder: (context, url) => const CircularProgressIndicator(),
        imageUrl: basicClass.image,
      );
    else if (image == null)
      myImg = Column(
        children: [
          Text('Нажмите'),
          Icon(Icons.add_a_photo,
              color: Colors.orange, size: screenSize.width / 3),
          Text('чтобы добавить фото', textAlign: TextAlign.center),
        ],
      );
    else
      myImg = Image.file(File(image!.path));
    return GestureDetector(
        onTap: () async {
          image = await _picker.pickImage(
            source: ImageSource.gallery,
            imageQuality: 50,
          );

          setState(() {
            basicClass.image = image!.path;

            // setImage();
          });
        },
        child: Column(
          children: <Widget>[myImg],
        ));
  }
}
