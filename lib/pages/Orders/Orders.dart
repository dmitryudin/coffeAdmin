import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../controllers/OrdersController.dart';
import '../OrderPage/UserOrderPage.dart';

class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QRViewExampleState();
  }
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(children: [
        Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text('Поместите QR-код в рамку'),
              ),
            )
          ],
        ),
        Positioned(
            left: width / 7,
            top: height / 5,
            child: DottedBorder(
              // PathBuilder
              color: Color.fromARGB(255, 63, 181, 63),
              dashPattern: [8, 4],
              strokeWidth: 2,
              child: Container(
                height: width * 0.7,
                width: width * 0.7,
                color: Colors.green.withAlpha(20),
              ),
            ))
      ]),
    );
  }

  bool flag = true;
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;

      await controller.pauseCamera();

      if (result != null) {
        OrderController()
            .getUsersActiveOrders(int.parse(result!.code.toString()));
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserOrderPage()));

        result = null;
      }

      await controller.resumeCamera();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
