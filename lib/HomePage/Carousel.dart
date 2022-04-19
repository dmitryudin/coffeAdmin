import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffe_admin/Dialogs/EditCarousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<String> imagesPath = [
  'https://avatars.mds.yandex.net/get-zen_doc/1874839/pub_5dcd7bfccd7152643c8dcf60_5dcd7c1777c1617acad09dd6/scale_1200',
];

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
    List<Widget> imagesWidget = imagesPath
        .map((imageUrl) => Container(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.fitWidth,
                width: width,
              ),
            ))
        .toList();
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
