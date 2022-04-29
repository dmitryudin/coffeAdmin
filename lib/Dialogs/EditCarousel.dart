import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_admin/MyWidgets/MyPicture.dart';
import 'package:coffe_admin/controllers/CoffeHouseObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyImage extends StatelessWidget {
  String url = '';
  EditCarouselD baseClass;
  MyImage(this.url, this.baseClass);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (url.contains('http'))
      return Stack(
        children: [
          //Icon(Icons.close), height: 50, width: 50),
          Card(
            color: Colors.blue,
            child: CachedNetworkImage(
              height: 500,
              imageUrl: url,
            ),
          ),
          Positioned(
              top: 15,
              right: 15,
              child: IconButton(
                icon: Icon(Icons.close_sharp),
                color: Colors.red,
                onPressed: () {
                  baseClass.images.remove(url);
                  baseClass.setState(() {});
                },
              )),
        ],
      );
    else
      return Stack(
        children: [
          //Icon(Icons.close), height: 50, width: 50),
          Card(
            color: Colors.blue,
            child: Image.file(File(url), height: 500),
          ),
          Positioned(
              top: 15,
              right: 15,
              child: IconButton(
                icon: Icon(Icons.close_sharp),
                color: Colors.red,
                onPressed: () {
                  baseClass.images.remove(url);
                  baseClass.setState(() {});
                },
              )),
        ],
      );
  }
}

class EditCarouselDialog extends StatefulWidget {
  List<String> images = [];
  EditCarouselDialog(this.images) {}
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditCarouselD(images);
  }
}

class EditCarouselD extends State<EditCarouselDialog> {
  List<String> images = [];

  EditCarouselD(this.images) {
    images = images.toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> imagesWidget = [];
    for (int i = 0; i < images.length; i++) {
      imagesWidget.add(MyImage(images[i], this));
    }
    imagesWidget.add(PictureWidget(this));

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      title: Text("Редактировать галерею"),
      content: Container(
          height: height * 0.9,
          width: width * 0.96,
          child: GridView.count(

              //physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: imagesWidget)),
    );
    // TODO: implement build
  }
}
