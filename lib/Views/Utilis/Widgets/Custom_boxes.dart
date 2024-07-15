import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../App_colors.dart';

class custombox extends StatelessWidget {
  final String title;
 final VoidCallback  ontap;

   custombox({Key? key, required this.title , required this.ontap});


  @override
  Widget build(BuildContext context) {
    return    InkWell(
      onTap: ontap,
      child: Container(

        height: 60,
        width: 150,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 5.0,
                spreadRadius: 1.0,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(24), color: AppColors.yellow),
        child: Center(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15
          ),),
        )),
      ),
    );
  }
}
