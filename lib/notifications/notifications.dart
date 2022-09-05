import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  late BuildContext _context;
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future initNotifies() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    // the initialization settings are initialized after they are setted
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //---------------------------------| Show the notification in the specific time |-------------------------------
  Future showNotification(String title, String description, int time, int id, FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id.toInt(),
        title,
        description,
        tz.TZDateTime.now(tz.local).add(Duration(milliseconds: time)),
        const NotificationDetails(
          android: AndroidNotificationDetails(

            'medicines_id',
            'medicines',
            'medicines_notification_channel',
            importance: Importance.high,
            priority: Priority.high,
            color: Colors.cyanAccent,
          ),
          iOS: IOSNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidAllowWhileIdle:
            true, //To show notification even when the app is closed
        // Type of time interpretation
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  //-------------------------| Cancel the notify |---------------------------
  Future removeNotification(int notifyId,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    try {
      return await flutterLocalNotificationsPlugin.cancel(notifyId);

    } catch (e) {
      return null;
    }
  }

  //-------------------------/Cancelling or deleting all notifications/--------
  Future deleteAllNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    try {
      return await flutterLocalNotificationsPlugin.cancelAll();
    } catch (e) {
      return null;
    }
  }
  //-------------| function to inicialize local notifications |---------------------------

  Future onSelectNotification(String payload) async {
    showDialog(
      context: _context,
      builder: (_) {
        return AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }
}
