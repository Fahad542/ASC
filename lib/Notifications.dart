import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'Services.dart';
import 'models/Notification_model.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
DatabaseHelper _databaseHelper = DatabaseHelper();
Future<void> backgroundMessageHandler(RemoteMessage message) async {

  print("Handling a background message: ${message.messageId}");
  if (message.notification != null) {
    print('Title: ${message.notification!.title}');
    print('Body: ${message.notification!.body}');

    // Convert to Notification_model and save to the database
    Notification_model notification = Notification_model(
      title: message.notification!.title,
      body: message.notification!.body,
      timestamp: message.sentTime ?? DateTime.now(), // Use sentTime or current time
    );

    // Access your database helper instance

    await _databaseHelper.insertnotification(notification);
  }
  print('Payload data: ${message.data}');
}

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> initNotification() async {
    await Firebase.initializeApp();

    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Request permission
    await _firebaseMessaging.requestPermission();

    // Get FCM token
    await _firebaseMessaging.subscribeToTopic('general');
    print("Subscribed to topic 'general'");

    // Set up message handlers
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
        await _databaseHelper.insertnotification(notification);
      }

      print('Data: ${message.data}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
      if (message.notification != null) {
        print('Title: ${message.notification!.title}');
        print('Body: ${message.notification!.body}');
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