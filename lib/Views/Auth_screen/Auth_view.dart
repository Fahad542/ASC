import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uvento/Views/Utilis/Utilis.dart';
import 'package:uvento/Views/Utilis/Widgets/button.dart';

import '../Utilis/App_colors.dart';
import 'Auth_view_model.dart';

class Auth_screen extends StatefulWidget {
  const Auth_screen({super.key});

  @override
  State<Auth_screen> createState() => _Auth_screenState();
}

class _Auth_screenState extends State<Auth_screen> {
  @override

  Auth_view_model model = Auth_view_model();
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider<Auth_view_model>(
        create: (context) => model,
    child:

      Scaffold(
      body:
    Consumer<Auth_view_model>(
    builder: (context, model, child) {
      return
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Column(
mainAxisAlignment: MainAxisAlignment.center,
                children: [
SizedBox(height: 70,),
                  Image.asset("assets/a.png", height: 200,width: 200,),
                  Text("AUTHENTICATION", style: TextStyle( fontSize: 24,color: AppColors.yellow, fontWeight: FontWeight.bold, ),),
                  SizedBox(height: 60,),
                  TextField(
                    controller: model.passowrd,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: AppColors.yellow,),
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: 'Please Enter Passowrd',
                      hintStyle: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                  SizedBox(height: 40,),
                  roundbutton(title: "LOGIN", onpress: () {
                    if(model.passowrd.text.isNotEmpty) {
                      model.checkauth(model.passowrd.text, context);
                    }
                  else {
                    Utilis.toastmessage("Please enter your password");
                    }
                  })
                ],),
            ),
        );

    })));}}

