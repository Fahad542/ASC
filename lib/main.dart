import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Views/Services/Push_notifications.dart';
import 'Views/Utilis/App_colors.dart';
import 'Views/splash.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(); // Initialize Firebase
  await Permission.storage.request();
   await FirebaseApi().initNotification();

  runApp(
    MyApp(),
  );
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColors.primaryColor, // Set the default background color


      ),
      home: Splash(),
    );
  }
}

