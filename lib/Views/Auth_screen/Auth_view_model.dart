import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uvento/Views/Utilis/Utilis.dart';

import '../Splash_screen.dart';

class Auth_view_model with ChangeNotifier {
TextEditingController passowrd= TextEditingController();

 Future<void>  checkauth(String password, BuildContext context) async {
   DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance.collection('password').
   doc('QCrfGoeQT7o4BXOQ0D4b').get();
   if(doc['password']==password)
     {
       Utilis.success("Login Successfull");
       Navigator.push(
         context,
         MaterialPageRoute(
             builder: (context) => SplashScreen(),
       ));
 }
else {
Utilis.toastmessage("Invalid password! Please try again");
   }
   }

}