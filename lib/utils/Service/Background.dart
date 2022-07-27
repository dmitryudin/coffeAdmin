
/*
import 'dart:async';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

import '../ApiLevel/AndroidApi/AndroidDataProvider.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
bool onIosBackground(ServiceInstance service) {

  print('FLUTTER BACKGROUND FETCH');

  return true;
}

void onStart(ServiceInstance service) async {

  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually





  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  AndroidDataProvider androidDataProvider = AndroidDataProvider();
  const platform = MethodChannel('samples.flutter.dev/battery');
  //сonst codec = StringCodec();
  platform.setMethodCallHandler((call){
    switch (call.method) {
      case 'bar':
        print(call.arguments);
    }
    Future<dynamic> my = 15 as Future;
    return my;
  });
  // bring to foreground
  Timer.periodic(const Duration(seconds: 5), (timer) async {



    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(

        title: "Тип сети",
        content: 'result',
      );
    }

    /// you can see this log in logcat
    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

    // test using external plugin


  });
}*/