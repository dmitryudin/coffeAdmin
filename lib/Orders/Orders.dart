import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  @override
  MyWidget createState() {
    return MyWidget();
  }
}

class MyWidget extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(children: [
      Column(children: [
        Container(
            height: height / 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 0, 40, 160),
                    Color.fromARGB(255, 79, 118, 247),
                  ],
                )),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                SizedBox(
                    height: height * 0.03,
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 25,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    )),
                SizedBox(
                    height: height * 0.03,
                    child: IconButton(
                      icon: Icon(
                        Icons.qr_code_scanner,
                        size: 25,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    )),
              ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: height * 0.21)),
                    CachedNetworkImage(
                      imageUrl:
                          'https://sun9-64.userapi.com/impf/b5JPtrBOLfdsgn8ALYni8WIzwSHG7VlKblPUkQ/uogxCEpTOoQ.jpg?size=1753x2160&quality=95&sign=a02868cc69fe68fa92f6e2cf9c374b96&type=album', //_user.photo.entity.uri,
                      imageBuilder: (context, imageProvider) => Container(
                        width: height / 5,
                        height: height / 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Юдин Дмитрий Алексеевич',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          //fontStyle: FontStyle.italic,
                          fontSize: 22,
                          color: Colors.white))
                ],
              ),
            ])),
        Padding(padding: EdgeInsets.only(top: 200)),
        Container(
          child: Text('fxcvxcvcvsf'),
        ),
      ]),
      Positioned(
          top: height / 3.4,
          left: width * 0.05,
          child: Container(
              width: width * 0.9,
              child: Card(
                  elevation: 10,
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only(right: width * 0.05)),
                      Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.5,
                                  color: Color.fromARGB(255, 12, 224, 12)),
                            ),
                          ),
                          width: width * 0.23,
                          child: Column(children: [
                            Text(
                              'Возраст',
                              style: TextStyle(fontSize: 23),
                            ),
                            Text('26',
                                style: TextStyle(
                                    fontSize: 26,
                                    color: Color.fromARGB(255, 12, 224, 12)))
                          ])),
                      Padding(padding: EdgeInsets.only(right: 15)),
                      Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.5,
                                  color: Color.fromARGB(255, 12, 16, 224)),
                            ),
                          ),
                          width: width * 0.23,
                          child: Column(
                            children: [
                              Text('Сделки', style: TextStyle(fontSize: 23)),
                              Text(
                                '5',
                                style: TextStyle(
                                    fontSize: 26,
                                    color: Color.fromARGB(255, 12, 16, 224)),
                              )
                            ],
                          )),
                      Padding(padding: EdgeInsets.only(right: 15)),
                      Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.5,
                                  color: Color.fromARGB(255, 184, 82, 82)),
                            ),
                          ),
                          width: width * 0.23,
                          child: Column(
                            children: [
                              Text('Рейтинг', style: TextStyle(fontSize: 23)),
                              Text('7.7',
                                  style: TextStyle(
                                      fontSize: 26,
                                      color: Color.fromARGB(255, 236, 26, 26)))
                            ],
                          ))
                    ],
                  )))),
    ]);
  }
}
