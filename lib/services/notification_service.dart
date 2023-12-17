import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  /// create a instance of flutter local notification plugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// this function initializes local notification
  Future<void> initializeNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('ic_launcher');

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void displayNotification() {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('ff', 'ff',
            channelDescription: 'ff',
            importance: Importance.max,
            priority: Priority.high);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    flutterLocalNotificationsPlugin.show(0, 'ddd', 'XVxV', notificationDetails);
    print('noti');
  }
}
