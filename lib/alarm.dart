import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:uuid/uuid.dart';


class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();//custom_notification_channel
      static var platform = MethodChannel('localnot');
 static String zamanistring(DateTime dateTime) {
  final format = DateFormat('dd.MM.yyyy:HH:mm');
  return format.format(dateTime);
}
static String saatVeDakika(DateTime dateTime) {
  final format = DateFormat('HH:mm');
  return format.format(dateTime);
}
static Future<void> bildirimayarla (String saat ,String title ,String content ,String ilce ,String kalan_vakit ,String time1 ,String time2 ,String time3 ,String time4 ,String time5 ,String time6

) async{
 try {await platform.invokeMethod('setAlarm', {
      'title' : "$title",
      'saat' : '$saat', // '06.11.2023:18:54',
      'content' : '$content',
      'ilce' : '$ilce',
      'kalan_vakit' : '$kalan_vakit',
      'time1' : '$time1',
      'time2' : '$time2',
      'time3' : '$time3',
      'time4' : '$time4',
      'time5' : '$time5',
      'time6' : '$time6',
    });
 } on PlatformException catch (e) {
    print("Hata: $e");
  }
}  
     
static Future<void> showCustomNotification(String title, String vakitAdi, String vakitSaat) async {
  try {
    print("showCustomNotification çalıştı");
    
    await platform.invokeMethod('showCustomNotification2', {
      'title' : title,
      'vakitAdi': vakitAdi,
      'vakitSaat': vakitSaat,
    });
  } on PlatformException catch (e) {
    print("Hata: $e");
  }
} 

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {
    //  Get.to(() => AlarmView()); // Handle your notification response here.
      // For example, navigate to a specific screen based on the notification payload.
    });
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'localnot',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }
  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin
        .show(id, title, body, await notificationDetails(), payload: payLoad
        );
  }
  Future<void> setAlarm(DateTime dateTime, String title, String body) async {
    print("alarm ayarlama basladi");
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_channel',
      'Alarm',
      icon: 'app_icon',
      sound: RawResourceAndroidNotificationSound('ses'),
      importance: Importance.max,
      priority: Priority.high,
    );
    final iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    String payload = '${dateTime.toIso8601String()}|Custom payload'; 
int id = Random().nextInt(100000); 
    tz.initializeTimeZones(); // Zaman dilimlerini başlatma
    final timeZone = tz.local;
    await notificationsPlugin.zonedSchedule(
       id, 
      title,
      body,
      tz.TZDateTime.from(dateTime, timeZone),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload, // You can also set a custom payload here.
    );
  }
}
