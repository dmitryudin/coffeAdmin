import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sberbank_acquiring/sberbank_acquiring_core.dart';
import 'package:sberbank_acquiring/sberbank_acquiring_ui.dart';

class PayView extends StatefulWidget {
  SberbankAcquiring acquiring = SberbankAcquiring(
    SberbankAcquiringConfig(
        userName: 'username', password: 'password', debug: true),
  );
  PayView({Key? key}) : super(key: key);

  @override
  State<PayView> createState() => _PayViewState();
}

class _PayViewState extends State<PayView> {
  SberbankAcquiring acquiring = SberbankAcquiring(
    SberbankAcquiringConfig(
        userName: 'username', password: 'password', debug: true),
  );
  OrderStatus? orderStatus;
  Future<void> webviewPayment() async {
    final RegisterResponse register = await acquiring.register(RegisterRequest(
      amount: 1000,
      returnUrl: 'https://test.ru/return.html',
      failUrl: 'https://test.ru/fail.html',
      orderNumber: 'test',
      pageView: 'MOBILE',
    ));

    final String? formUrl = register.formUrl;

    if (!register.hasError && formUrl != null) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => Scaffold(
            body: WebViewPayment(
              config: acquiring.config,
              formUrl: formUrl,
              returnUrl: 'https://test.ru/return.html',
              failUrl: 'https://test.ru/fail.html',
              onLoad: (bool v) {
                debugPrint('WebView load: $v');
              },
              onError: () {
                debugPrint('WebView Error');
              },
              onFinished: (String? v) async {
                final GetOrderStatusExtendedResponse status =
                    await acquiring.getOrderStatusExtended(
                        GetOrderStatusExtendedRequest(orderId: v));

                orderStatus = status.orderStatus;
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Status: $orderStatus'),
            ElevatedButton(
              onPressed: () async {
                await webviewPayment();
              },
              child: const Text('Webview Buy'),
            ),
          ],
        ),
      ),
    );
  }
}
