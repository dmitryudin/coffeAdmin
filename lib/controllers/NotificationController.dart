import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationController {
  NotificationController() {
    print('start init');
    WidgetsFlutterBinding.ensureInitialized();
    AwesomeNotifications().initialize('resource://drawable/notification_icon', [
      // notification icon
      NotificationChannel(
        channelGroupKey: 'basic',
        channelKey: 'basic',
        channelName: 'basic',
        channelDescription: 'Notification channel for basic tests',
        channelShowBadge: true,
        importance: NotificationImportance.High,
        enableVibration: true,
      ),

      NotificationChannel(
          channelGroupKey: 'image_test',
          channelKey: 'image',
          channelName: 'image notifications',
          channelDescription: 'Notification channel for image tests',
          defaultColor: Colors.redAccent,
          ledColor: Colors.white,
          channelShowBadge: true,
          importance: NotificationImportance.High)

      //add more notification type with different configuration
    ]);
    print('inited');
  }

  void showNotification() async {
    bool isallowed = await AwesomeNotifications().isNotificationAllowed();
    print(isallowed);
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      //simgple notification
      id: 123,
      channelKey: 'basic', //set configuration wuth key "basic"
      title: 'Макс',
      body: 'ПРИВЕД!',

      //largeIcon: 'asset://assets/images/elephant.jpg',
      //large icon will be displayed at right side
    ));
  }
}
