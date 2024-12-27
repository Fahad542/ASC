import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uvento/Views/Auth_screen/Auth_view.dart';

import 'Splash_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String? agendaLogo;
  String? homepageLogo;
  String? homepageMain;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    //getAndSaveImages();
    startTimer();
  }

  void startTimer() {
    Timer(Duration(seconds: 2), () async {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance.collection('password').
      doc('QCrfGoeQT7o4BXOQ0D4b').get();
      if(doc['ischeck']=="true") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Auth_screen()),
      );
    }
      else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SplashScreen()),
        );
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          ],
        ),
      ),
    );
  }
}