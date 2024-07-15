import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../App_colors.dart';

class Resultwidget extends StatelessWidget {

  String title;
  String vote_number;
  bool winner;

  Resultwidget({required this.title, required this.vote_number, required this.winner});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(


        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(

            children: <Widget>[

              Row(
                children: [
                  Text("Nominees : ",style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold), ),
                  Text(title, style: TextStyle(color: AppColors.yellow, fontWeight: FontWeight.bold, fontSize: 16),),
                ],
              ),

Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    padding: EdgeInsets.all(8),

                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)),
                    child:Text(
                      '${vote_number}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),)),
              ),
              if(winner)
              Column(
                children: [
                  Text("Winner", style: TextStyle(color: AppColors.yellow, fontWeight: FontWeight.bold),),
                  Image.asset('assets/1.png', height: 40, width: 50,),
                ],
              ),


                    ],
                  ),
        ),


      ),
    );
  }
}


