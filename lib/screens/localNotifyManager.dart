import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:rxdart/subjects.dart';

class LocalNotifyManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initSetting;

  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
      BehaviorSubject<ReceiveNotification>();

  LocalNotifyManager.init() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (Platform.isIOS) {
      requestIOSPermission();
    }
    initializePlatform();
  }

  requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(alert: true, badge: true, sound: true);
  }

  initializePlatform() {
    var initSettingAndroid =
        AndroidInitializationSettings('app_notification_icon');
    var initSettingIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceiveNotification notification = ReceiveNotification(
              id: id, title: title, body: body, payload: payload);

          didReceiveLocalNotificationSubject.add(notification);
        });
    initSetting = InitializationSettings(
        android: initSettingAndroid, iOS: initSettingIOS);
  }

  setOnNotificationReceive(Function onNotificationReceive) {
    didReceiveLocalNotificationSubject.listen((notification) {
      onNotificationReceive(notification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> showNotification() async {
    var androidChannel = AndroidNotificationDetails(
        'CHANNEL_ID', 'CHANNEL_NAME', 'CHANNEL_DESCRIPTION',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        timeoutAfter: 5000,
        enableLights: true);

    var iosChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);

    await flutterLocalNotificationsPlugin.show(
        0, 'Test Title', 'Test body', platformChannel,
        payload: 'New Payload');
  }

  Future<void> scheduleNotification() async {
    var scheduleNoticationDateTime = DateTime.now().add(Duration(seconds: 5));
    var androidChannel = AndroidNotificationDetails(
        'CHANNEL_ID', 'CHANNEL_NAME', 'CHANNEL_DESCRIPTION',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        timeoutAfter: 5000,
        enableLights: true);

    var iosChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);

    await flutterLocalNotificationsPlugin.zonedSchedule(0, 'Schedule Test Title',
        'Schedule Test body', scheduleNoticationDateTime, platformChannel,
        payload: 'New Payload');
  }

  Future<void> repeatNotification() async {
    var androidChannel = AndroidNotificationDetails(
        'CHANNEL_ID', 'CHANNEL_NAME', 'CHANNEL_DESCRIPTION',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        timeoutAfter: 5000,
        enableLights: true);

    var iosChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);

    await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        'Repeat Test Title',
        'Repeat Test body',
        RepeatInterval.everyMinute,
        platformChannel,
        payload: 'New Payload');
  }

  Future<void> showDialyAtTimeNotification() async {
//_scheduleDailyTenAMNotification
    var androidChannel = AndroidNotificationDetails(
        'CHANNEL_ID', 'CHANNEL_NAME', 'CHANNEL_DESCRIPTION',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        timeoutAfter: 5000,
        enableLights: true);

    var iosChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0, 'Daily Test Title ',
        ' Daily Test body',
        _nextInstanceOfTenAM(),
        platformChannel,
        payload: 'New Payload',
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }
  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);//_scheduleDailyTenAMNotification, on peut ajouter les minutes, secondes,...
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }


  Future<void> showWeeklyAtDayTimeNotification() async {
//_scheduleWeeklyTenAMNotification
    var time = Time(15, 50, 0);
    var androidChannel = AndroidNotificationDetails(
        'CHANNEL_ID', 'CHANNEL_NAME', 'CHANNEL_DESCRIPTION',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        timeoutAfter: 5000,
        enableLights: true);

    var iosChannel = IOSNotificationDetails();
    var platformChannel =
    NotificationDetails(android: androidChannel, iOS: iosChannel);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Weekly Test Title at ${time.hour}-${time.minute}-${time.second}',
        'Weekly Test body',_nextInstanceOfTenAM(),
        platformChannel,
        payload: 'New Payload',
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  Future<void> cancelNotification(int id) async{
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotification() async{
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

LocalNotifyManager localNotifyManager = LocalNotifyManager.init();

class ReceiveNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceiveNotification(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}
