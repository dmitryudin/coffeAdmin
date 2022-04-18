import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  String url = '';
  MyImage(this.url);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
              onPressed: () {},
            )),
      ],
    );
  }
}

class EditCarouselDialog extends StatelessWidget {
  List<String> images = [];
  List<Widget> imagesWidget = [];
  EditCarouselDialog(this.images) {
    imagesWidget = images.map((image) => MyImage(image)).toList();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      title: Text("Success"),
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
