import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_admin/MyWidgets/AddPicture.dart';
import 'package:coffe_admin/utils/Network/MultiPart.dart';
import 'package:coffe_admin/controllers/CoffeHouseObject.dart';
import 'package:coffe_admin/utils/Network/RestController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  List<String> newImages = [];

  late CoffeHouse coffeHouse;
  bool isCansel = true;
  EditCarouselD(this.images) : super() {
    images = images.toList();
  }

  @override
  Widget build(BuildContext context) {
    coffeHouse = Provider.of<CoffeHouse>(context, listen: false);
    List<Widget> imagesWidget = [];
    for (int i = 0; i < images.length; i++) {
      imagesWidget.add(
        AddPicture(
            onFileUploaded: (String url) {},
            onFileLoaded: (String path) {},
            onFileDeleted: (String uri) {
              print('FileRemoved $uri');

              setState(() {
                images.remove(uri);
                if (newImages.contains(uri)) {
                  newImages.remove(uri);
                }
              });
            },
            url: images[i],
            key: UniqueKey()),
      );
    }
    imagesWidget.add(AddPicture(
        onFileUploaded: (String url) {
          print('File uploaded $url');

          setState(() {
            images.add(url);
            newImages.add(url);
          });
        },
        onFileLoaded: (String path) {},
        onFileDeleted: null,
        url: '',
        key: UniqueKey()));

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      title: Text("Редактировать галерею"),
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
            ElevatedButton(
                onPressed: () {
                  coffeHouse.photos = images;
                  isCansel = false;
                  coffeHouse.updateMainInformation();
                  Navigator.pop(context);
                },
                child: Text('Отправить')),
            ElevatedButton(
                onPressed: () {
                  for (String img in newImages) {
                    // RemoteFileManager().deleteFile(url: img);
                  }
                  Navigator.pop(context);
                },
                child: Text('Отменить'))
          ])),
    );
    // TODO: implement build
  }

  @override
  void dispose() {
    if (isCansel) {
      for (String img in newImages) {
        RemoteFileManager().deleteFile(url: img);
      }
    }
    super.dispose();
  }
}
