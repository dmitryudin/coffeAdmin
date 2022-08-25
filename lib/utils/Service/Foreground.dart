import 'dart:isolate';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:coffe_admin/controllers/OrdersController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

Future<void> initForegroundTask() async {
  // OrderController();
  AwesomeNotifications().actionStream.listen((receivedAction) {
    var payload = receivedAction.payload;
    print('pushed notification');
    if (receivedAction.channelKey == 'basic') {
      print('pushed notification');
      //do something here
    }
  });
  await FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'notification_channel_id',
      channelName: 'Foreground Notification',
      channelDescription:
          'This notification appears when the foreground service is running.',
      channelImportance: NotificationChannelImportance.LOW,
      priority: NotificationPriority.LOW,
      iconData: const NotificationIconData(
        resType: ResourceType.mipmap,
        resPrefix: ResourcePrefix.ic,
        name: 'launcher',
      ),
      buttons: [
        //const NotificationButton(id: 'sendButton', text: 'Send'),
        //const NotificationButton(id: 'testButton', text: 'Test'),
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

// The callback function should always be a top-level function.
void startCallback() {
  // The setTaskHandler function must be called to handle the task in the background.
  FlutterForegroundTask.setTaskHandler(FirstTaskHandler());
}

class FirstTaskHandler extends TaskHandler {
  SendPort? _sendPort;

  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    _sendPort = sendPort;
    //OrderController();

    // You can use the getData function to get the stored data.
    final customData =
        await FlutterForegroundTask.getData<String>(key: 'customData');
    print('customData: $customData');
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
    FlutterForegroundTask.updateService(
        notificationTitle: '#Thefir админ',
        notificationText: 'Приложение работает в фоновом режиме');
    // Send data to the main isolate.
    sendPort?.send(timestamp);
  }

  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {
    // You can use the clearAllData function to clear all the stored data.
    await FlutterForegroundTask.clearAllData();
  }

  @override
  void onButtonPressed(String id) {
    // Called when the notification button on the Android platform is pressed.
    print('onButtonPressed >> $id');
  }

  @override
  void onNotificationPressed() {
    // Called when the notification itself on the Android platform is pressed.
    //
    // "android.permission.SYSTEM_ALERT_WINDOW" permission must be granted for
    // this function to be called.

    // Note that the app will only route to "/resume-route" when it is exited so
    // it will usually be necessary to send a message through the send port to
    // signal it to restore state when the app is already started.
    FlutterForegroundTask.launchApp("");
    // _sendPort?.send('onNotificationPressed');
  }
}

Future<bool> startForegroundTask() async {
  // "android.permission.SYSTEM_ALERT_WINDOW" permission must be granted for
  // onNotificationPressed function to be called.
  //
  // When the notification is pressed while permission is denied,
  // the onNotificationPressed function is not called and the app opens.
  //
  // If you do not use the onNotificationPressed or launchApp function,
  // you do not need to write this code.
  if (!await FlutterForegroundTask.canDrawOverlays) {
    final isGranted =
        await FlutterForegroundTask.openSystemAlertWindowSettings();
    if (!isGranted) {
      print('SYSTEM_ALERT_WINDOW permission denied!');
      return false;
    }
  }

  // You can save data using the saveData function.
  await FlutterForegroundTask.saveData(key: 'customData', value: 'hello');

  ReceivePort? receivePort;
  if (await FlutterForegroundTask.isRunningService) {
    receivePort =
        (await FlutterForegroundTask.restartService()) as ReceivePort?;
  } else {
    receivePort = (await FlutterForegroundTask.startService(
      notificationTitle: 'Foreground Service is running',
      notificationText: 'Tap to return to the app',
      callback: startCallback,
    )) as ReceivePort?;
    print('FOREGROUND_SERVISE started!!');
  }

  return registerReceivePort(receivePort);
}

ReceivePort? _receivePort;
bool registerReceivePort(ReceivePort? receivePort) {
  _closeReceivePort();

  if (receivePort != null) {
    _receivePort = receivePort;
    _receivePort?.listen((message) {
      if (message is DateTime) {
        print('timestamp: ${message.toString()}');
      } else if (message is String) {
        if (message == 'onNotificationPressed') {}
      }
    });

    return true;
  }

  return false;
}

void _closeReceivePort() {
  _receivePort?.close();
  _receivePort = null;
}
