/*
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_service/flutter_foreground_service.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:provider/provider.dart';
import 'package:safecall/ApiLevel/AndroidApi/AndroidDataProvider.dart';
import 'package:safecall/Service/Foreground.dart';

import 'Service/Background.dart';

Future<void> _initForegroundTask() async {
  await FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'notification_channel_id',
      channelName: 'Foreground Notification',
      channelDescription: 'This notification appears when the foreground service is running.',
      channelImportance: NotificationChannelImportance.LOW,
      priority: NotificationPriority.LOW,
      iconData: const NotificationIconData(
        resType: ResourceType.mipmap,
        resPrefix: ResourcePrefix.ic,
        name: 'launcher',
      ),
      buttons: [
        const NotificationButton(id: 'sendButton', text: 'Send'),
        const NotificationButton(id: 'testButton', text: 'Test'),
      ],
    ),
    iosNotificationOptions: const IOSNotificationOptions(
      showNotification: true,
      playSound: false,
    ),
    foregroundTaskOptions: const ForegroundTaskOptions(
      interval: 5000,
      autoRunOnBoot: true,
      allowWifiLock: true,
    ),
    printDevLog: true,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await initializeService();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [

    ChangeNotifierProvider(create: (context) => AndroidDataProvider())],
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Небольшая демонстрация'),
    ));
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState(){
  //  static const platform = MethodChannel('samples.flutter.dev/battery');
   // static const codec = StringCodec();
  //  platform.setMethodCallHandler((call){
   //   switch (call.method) {
   //     case 'bar':

    //      print(call.arguments);
    //  }
     // Future<dynamic> my = 15 as Future;
    //  return my;
 // });

    androidDataProvider.update();
  }
  AndroidDataProvider androidDataProvider = AndroidDataProvider();
  String _counter = '';

  String result='';
  int cid = 0; int lac = 0; int timeAdvanced = 0;
  void _incrementCounter() async {

      result = androidDataProvider.mainInformation.typeOfNetwork;



    setState(() {
      _counter = _counter;

    });
  }

  @override
  Widget build(BuildContext context) {
    return WithForegroundTask(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Параметры:',
              style: TextStyle(fontSize: 35),
            ),
            Text(
              'Уровень сигнала: $result dbm',
              style: TextStyle(fontSize: 25),
            ),
            Text(
              'CID: $cid',
              style: TextStyle(fontSize: 25),
            ),
            Text(
              'LAC: $lac',
              style: TextStyle(fontSize: 25),
            ),
            Text(
              'Time advanced $timeAdvanced',
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    _initForegroundTask();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      // You can get the previous ReceivePort without restarting the service.
      if (await FlutterForegroundTask.isRunningService) {
        final newReceivePort = await FlutterForegroundTask.receivePort;
        registerReceivePort(newReceivePort);
      }
    });
    startForegroundTask();
  }
}
*/