import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
    });
  }

  Future<void> getAndSaveImages() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance
          .collection('logos')
          .doc('OVLPo8vmMvDWzU1LZHA0-logos')
          .get();

      Map<String, dynamic>? data = doc.data();
      print('Data retrieved from Firestore: $data');

      if (data != null) {
        String agendaLogo = data['agenda_logo'];
        String homepageLogo = data['homepage_logo'];
        String homepageMain = data['homepage_main'];

        // Check if URLs are not empty or null
        if (agendaLogo.isNotEmpty && homepageLogo.isNotEmpty && homepageMain.isNotEmpty) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('agenda_logo', agendaLogo);
          await prefs.setString('homepage_logo', homepageLogo);
          await prefs.setString('homepage_main', homepageMain);

          print('Images saved to SharedPreferences');

          setState(() {
            this.agendaLogo = agendaLogo;
            this.homepageLogo = homepageLogo;
            this.homepageMain = homepageMain;
            isLoading = false;
          });
        } else {
          print('One or more image URLs are empty.');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('No data found in Firestore');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error getting data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (agendaLogo != null)
              Image.asset(
                "assets/Parwaaz.png",
                errorBuilder: (context, error, stackTrace) {
                  return Text('Error loading image', style: TextStyle(color: Colors.red));
                },
              )
            else
              Text('No logo available', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}