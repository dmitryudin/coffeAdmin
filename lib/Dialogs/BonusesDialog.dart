import 'dart:convert';

import 'package:coffe_admin/utils/Network/RestController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BonusesDialog extends StatefulWidget {
  int userId = -1;
  double cost = 0;
  BonusesDialog({required this.userId, required this.cost, Key? key})
      : super(key: key);

  @override
  State<BonusesDialog> createState() => _BonusesDialogState(userId, cost);
}

class _BonusesDialogState extends State<BonusesDialog> {
  int userId = -1;
  double cost = 0;
  double currentBonusesBalance = 0.0;
  _BonusesDialogState(this.userId, this.cost) {
    RestController().sendGetRequest(
        onComplete: ({required String data, required int statusCode}) {
          var map = jsonDecode(data);
          print('balanxce $currentBonusesBalance');
          currentBonusesBalance = map['bonuses'];
          setState(() {});
        },
        onError: ({required int statusCode}) {},
        controller: 'client_bonuses',
        data: '?user_id=$userId');
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text('Завершение заказа'),
      content: Text('Списать/начислить бонусы'),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () async {
            RestController().sendDeleteRequest(
                onComplete: (
                    {required String data, required int statusCode}) {},
                onError: ({required int statusCode}) {},
                controller: 'client_bonuses',
                data: '{"bonuses":$currentBonusesBalance, "user_id":$userId}');
            await showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Иформация об оплате'),
                content:
                    Text('К опалате: ${cost - currentBonusesBalance} руб.'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pop(); // dismisses only the dialog and returns nothing
                    },
                    child: new Text('OK'),
                  ),
                ],
              ),
            );
            Navigator.of(context, rootNavigator: true)
                .pop(); // dismisses only the dialog and returns nothing
          },
          child: new Text('Списать $currentBonusesBalance бонусов'),
        ),
        ElevatedButton(
          onPressed: () async {
            RestController().sendPostRequest(
                onComplete: (
                    {required String data, required int statusCode}) {},
                onError: ({required int statusCode}) {},
                controller: 'client_bonuses',
                data: '{"bonuses":${cost * 0.01}, "user_id":$userId}');
            await showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Иформация об оплате'),
                content: Text('К опалате: $cost руб.'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pop(); // dismisses only the dialog and returns nothing
                    },
                    child: new Text('OK'),
                  ),
                ],
              ),
            );
            Navigator.of(context, rootNavigator: true)
                .pop(); // dismisses only the dialog and returns nothing
          },
          child: new Text('Начислить ${cost / 100} бонусов'),
        ),
        ElevatedButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Иформация об оплате'),
                content: Text('К опалате: $cost руб.'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pop(); // dismisses only the dialog and returns nothing
                    },
                    child: new Text('OK'),
                  ),
                ],
              ),
            );
            Navigator.of(context, rootNavigator: true)
                .pop(); // dismisses only the dialog and returns nothing
          },
          child: new Text('Завершить'),
        ),
      ],
    );
  }
}
