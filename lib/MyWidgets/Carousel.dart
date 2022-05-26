import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffe_admin/Dialogs/EditCarouselDialog.dart';
import 'package:coffe_admin/controllers/CoffeHouseObject.dart';
import 'package:coffe_admin/utils/Notifications/NotificationController.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Carousel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyWidget();
  }
}

class MyWidget extends State<Carousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    List<String> imagesPath =
        Provider.of<CoffeHouse>(context, listen: true).photos;
    List<Widget> imagesWidget = imagesPath
        .map((imageUrl) => Container(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.fitWidth,
                width: width,
              ),
            ))
        .toList();
    if (imagesWidget.isEmpty) {
      imagesWidget.add(Container(
        child: GestureDetector(
          child: Icon(
            Icons.add_a_photo,
            size: height / 3,
            color: Colors.red,
          ),
          onTap: () {
            NotificationController ntf = NotificationController();
            ntf.showNotification();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return EditCarouselDialog(
                    Provider.of<CoffeHouse>(context, listen: true).photos);
              },
            );
          },
        ),
      ));
    }
    return CarouselSlider(
        items: imagesWidget,
        carouselController: _controller,
        options: CarouselOptions(
          aspectRatio: 2.0,
          viewportFraction: 1.0,
          height: height / 3,
          enlargeCenterPage: false,
          autoPlay: true,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
        ));
  }
}
