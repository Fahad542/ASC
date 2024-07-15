import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uvento/Views/Utilis/App_colors.dart';

class circular_bar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,

      body: Center(child: CircularProgressIndicator(color:AppColors.whiteColor,),),);
  }
}
