import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_admin/controllers/BasicObject.dart';
import 'package:coffe_admin/controllers/RestController.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPicture extends StatefulWidget {
  String url = '';
  late var onFileUploaded, onFileLoaded;
  AddPicture(
      {required this.url,
      required void onFileLoaded(String path),
      required void onFileUploaded(String url)}) {
    this.onFileLoaded = onFileLoaded;
    this.onFileUploaded = onFileUploaded;
  }

  @override
  AddPictureState createState() {
    return AddPictureState(this);
  }
}

class AddPictureState extends State<AddPicture> {
  late var basicClass;
  String url = '';
  bool isActive = true;
  AddPictureState(this.basicClass);
  double progress = 0.0;
  final ImagePicker _picker = ImagePicker();
  XFile? image;

  var myImg;

  void setProgress(double progress) {
    setState(() {
      this.progress = progress;
    });
  }

  void onUploaded(String urln) {
    print(url);
    url = urln;
    basicClass.onFileUploaded(url);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (url == '')
      myImg = Column(
        children: [
          Text('Нажмите'),
          Icon(Icons.add_a_photo, color: Colors.orange, size: width / 3),
          Text('чтобы добавить фото', textAlign: TextAlign.center),
        ],
      );
    else {
      myImg = Stack(
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
                  print('removed');

                  RestController.send_request(
                      class_obj: BasicObject(),
                      controller: 'delete_file',
                      data: '{"url":"' + url + '"}');
                  url = '';
                  basicClass.onFileUploaded(url);
                  setState(() {});
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
    return GestureDetector(
        onTap: () async {
          if (isActive) {
            image = await _picker
                .pickImage(
              source: ImageSource.gallery,
              imageQuality: 50,
            )
                .then((value) {
              basicClass.onFileLoaded(value!.path);
              RestController.uploadFile(class_obj: this, filename: value.path);
            });
            setState(() {});
          }
        },
        child: Column(
          children: <Widget>[myImg],
        ));
  }
}
