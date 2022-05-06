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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Card(
            color: Colors.white,
            child: (url.contains('http'))
                ? CachedNetworkImage(
                    width: width / 2.2,
                    height: height / 5,
                    imageUrl: url,
                  )
                : Image.file(
                    File(url),
                    width: width / 2.2,
                    height: height / 5,
                  )),
        Positioned(
            top: 10,
            right: -15,
            child: RawMaterialButton(
              onPressed: () {
                baseClass.images.remove(url);
                baseClass.setState(() {});
              },
              elevation: 2.0,
              fillColor: Colors.blue[100],
              child: Icon(
                Icons.close_sharp,
                color: Colors.red,
                size: 15.0,
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
            ))
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

  Widget sendButton = TextButton(
    child: Text("Отправить"),
    onPressed: () {},
  );

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
      actions: [sendButton],
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
          height: height * 0.9,
          width: width * 0.96,
          child: ListView(children: [
            GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                children: imagesWidget),
          ])),
    );
    // TODO: implement build
  }
}
