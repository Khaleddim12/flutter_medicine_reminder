import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medicine_reminder/databaseHelper/pills_database.dart';
import 'package:medicine_reminder/models/pill.dart';
import 'package:medicine_reminder/notifications/notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PillData extends ChangeNotifier {
  final DatabaseHelper db = DatabaseHelper.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final NotificationService _notificationService = NotificationService();

  //--------------------| List of Pills from database |----------------------

  List<Pill> allListOfPills = [];

  UnmodifiableListView<Pill> get pills {
    return UnmodifiableListView(allListOfPills);
  }

  Future<void> initNotifications() async {
     await _notificationService.initNotifies();
  }


  Future clearPills() async{
    initNotifications();
    allListOfPills = [];
    await db.empty();
    _notificationService
        .deleteAllNotifications(flutterLocalNotificationsPlugin);
    notifyListeners();
  }

  Future setData() async {
    initNotifications();

    allListOfPills.clear();
    (await db.getAllData()).forEach((pillMap) {
      allListOfPills.add(Pill.fromMap(pillMap));
    });
    notifyListeners();
  }

  Future addPill(Pill pill) async {
    initNotifications();
    allListOfPills.add(pill);
    notifyListeners();
    return await db.insertData(pill);
  }

  Future deletePill(Pill pill) async {
    db.deletePill(pill.id!);
    allListOfPills.remove(pill);
    _notificationService.removeNotification(pill.notifyId, flutterLocalNotificationsPlugin);
    notifyListeners();
  }

  int get pillsCount {
    return allListOfPills.length;
  }
}
