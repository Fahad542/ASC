import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uvento/Notifications.dart';
import 'package:uvento/Views/Utilis/App_colors.dart';
import 'Views/Splash_screen.dart';
import 'Views/Utilis/Widgets/Connectivity.dart';
import 'Views/splash.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(); // Initialize Firebase
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
      home: SplashScreen(),
    );
  }
}

