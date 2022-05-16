import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_admin/MyWidgets/MyPicture.dart';
import 'package:coffe_admin/controllers/BasicObject.dart';
import 'package:coffe_admin/controllers/CoffeHouseObject.dart';
import 'package:coffe_admin/controllers/RestController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyImage extends StatefulWidget {
  String url = '';
  late EditCarouselD baseClass;
  MyImage(this.url, this.baseClass);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyWidget(url, baseClass);
  }
}

class MyWidget extends State<MyImage> {
  String url = '';
  EditCarouselD baseClass;
  double progress = 0;
  MyWidget(this.url, this.baseClass) {
    if (!url.contains('http')) {
      RestController.uploadFile(class_obj: this, filename: this.url);
    }
  }
  setProgress(double progress) {
    setState(() {
      this.progress = progress;
    });
  }

  void onUploaded(String urln) {
    baseClass.images[baseClass.images.indexOf(url)] = urln;
    baseClass.newImages.add(urln);
    url = urln;
    baseClass.setState(() {});
  }

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
                print(url);
                baseClass.images.remove(url);
                baseClass.setState(() {});
                String payload = url;
                payload = '{"url":"' + payload + '"}';
                RestController.send_request(
                    class_obj: BasicObject(),
                    controller: 'delete_file',
                    data: payload);
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
            )),
        Positioned(
            top: 100,
            right: 100,
            child: CircularProgressIndicator(
              value: progress,
              semanticsLabel: 'Linear progress indicator',
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

class EditCarouselD extends State<EditCarouselDialog> with BasicObject {
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
      imagesWidget.add(MyImage(images[i], this));
    }
    imagesWidget.add(PictureWidget(this));

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
                    String payload = img;
                    payload = '{"url":"' + payload + '"}';
                    RestController.send_request(
                        class_obj: BasicObject(),
                        controller: 'delete_file',
                        data: payload);
                  }
                  /*TODO
                  Тут нужно доделать функционал удаления загруженных файлов с 
                  сервера в случае нештатных ситуаций
                   */
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
        String payload = img;
        payload = '{"url":"' + payload + '"}';
        RestController.send_request(
            class_obj: BasicObject(), controller: 'delete_file', data: payload);
      }
    }
    super.dispose();
  }
}
