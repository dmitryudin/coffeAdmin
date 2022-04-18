import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffe_admin/Dialogs/EditCarousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<String> imagesPath = [
  'https://avatars.mds.yandex.net/get-zen_doc/1874839/pub_5dcd7bfccd7152643c8dcf60_5dcd7c1777c1617acad09dd6/scale_1200',
  'https://sovcominvest.ru/uploads/photo/20148/image/56241086b7dfaf75764519e9556855eb.jpeg',
  'https://restconcept.ru/upload/medialibrary/4e4/%D0%9F%D1%80%D0%B8%D0%BC%D0%B5%D1%80-%D0%B1%D0%B8%D0%B7%D0%BD%D0%B5%D1%81-%D0%BF%D0%BB%D0%B0%D0%BD%D0%B0-%D0%BA%D0%BE%D1%84%D0%B5%D0%B5%D0%BD.jpg',
  'https://i.pinimg.com/originals/4c/96/4a/4c964a44655b0b6dedf25e86f85ccf48.jpg',
  'https://avatars.mds.yandex.net/get-altay/760153/2a0000017189e9da498f4a91d6346c0e038f/XXL',
];

List<Widget> imagesWidget = imagesPath
    .map((imageUrl) => Container(
            child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.fill,
        )))
    .toList();

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
    return Column(children: [
      Row(
        children: [
          IconButton(
              onPressed: () => {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            EditCarouselDialog(imagesPath))
                  },
              icon: Icon(Icons.edit))
        ],
      ),
      CarouselSlider(
          items: imagesWidget,
          carouselController: _controller,
          options: CarouselOptions(
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          )),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imagesWidget.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
