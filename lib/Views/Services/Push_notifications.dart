import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/material.dart';

import 'local_db.dart';
import '../../models/Notification_model.dart';
import '../Notifications/Notifications_view.dart';
DatabaseHelper _databaseHelper = DatabaseHelper();

@pragma('vm:entry-point')
Future<void> backgroundMessageHandler(RemoteMessage message) async {
  try {
    print("Handling a background message: ${message.messageId}");

    if (message.notification != null) {
      print('Notification Title: ${message.notification!.title}');
      print('Notification Body: ${message.notification!.body}');

      Notification_model notification = Notification_model(
        title: message.notification!.title,
        body: message.notification!.body,
        timestamp: message.sentTime ?? DateTime.now(),  // Use sentTime or current time
      );

      // Access your database helper instance
      await _databaseHelper.insertNotificationCount(1);
      await _databaseHelper.insertNotification(notification);

    }

    print('Payload data: ${message.data}');
  } catch (e) {
    print('Error handling background message: $e');
    // Handle the exception as needed, such as logging it or reporting it.
  }
}


class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> initNotification({BuildContext? context}) async {
    await Firebase.initializeApp();


    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);


    await _firebaseMessaging.requestPermission();


    await _firebaseMessaging.subscribeToTopic('general');
    String? token = await _firebaseMessaging.getToken();

    print("FCM Token: $token");
    print("Subscribed to topic 'general'");


    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Received a message in the foreground: ${message.messageId}');

      if (message.notification != null) {
        print('Title: ${message.notification!.title}');
        print('Body: ${message.notification!.body}');

        // Show the local notification
        showLocalNotification(message.notification!);

        // Capture the current time
        DateTime currentTime = DateTime.now();
        print('Current Time: $currentTime');

        // Create a notification model
        Notification_model notification = Notification_model(
          title: message.notification!.title,
          body: message.notification!.body,
          timestamp: message.sentTime ?? currentTime, // Use sentTime or current time
        );

        // Insert the notification into the database
        await _databaseHelper.insertNotificationCount(1);
        await _databaseHelper.insertNotification(notification);

      }

      print('Data: ${message.data}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
      if (message.notification!.body != null ) {
        print('Title: ${message.notification!.title}');
        print('Body: ${message.notification!.body}');
        Navigator.push(
          context!,
          MaterialPageRoute(builder: (context) => notifications()),
        );
       
      }
      print('Data: ${message.data}');
    });

  }

  void showLocalNotification(RemoteNotification notification) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'default_channel_id', // id
      'Default', // title
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      platformChannelSpecifics,
    );
  }
}