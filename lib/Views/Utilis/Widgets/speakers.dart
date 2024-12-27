import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Polls/Polls_view.dart';
import '../App_colors.dart';
import 'container.dart';

class Awardswidget extends StatelessWidget {

  String desc;
  String date;
  String address;
  final VoidCallback onTap;
  final VoidCallback resultonTap;
  String imgeAssetPath;

  Awardswidget({required this.address,required this.date,required this.imgeAssetPath,required this.desc, required this.onTap, required this.resultonTap});

  @override
  Widget build(BuildContext context) {
    return  Container(

        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                  child: Image.network(imgeAssetPath, height: 90,width: 120, fit: BoxFit.cover,)),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 5),
                width: MediaQuery.of(context).size.width - 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Row(

                      children: [


                       Expanded(child:  Text(desc, style: TextStyle(

                            color: Colors.white,
                            fontSize: 15,
                          fontWeight: FontWeight.w500
                        ),),),
                        // InkWell(
                        //   onTap: onTap,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Container(child: Text('Vote'),)
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 5),
                        //   child: InkWell(
                        //     onTap: onTap,
                        //     child: Container(
                        //       padding: EdgeInsets.all(4),
                        //       decoration: BoxDecoration(color: AppColors.yellow, borderRadius: BorderRadius.circular(8),
                        //
                        //       )
                        //
                        //       ,
                        //       child: Text('VOTE', style: TextStyle(color: AppColors.primaryColor, fontSize: 10, fontWeight: FontWeight.bold),),),
                        //   ),
                        // ),

                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      children: <Widget>[

                        SizedBox(width: 8,),
                        Text(date, style: TextStyle(
                            color: AppColors.yellow,
                            fontSize: 10
                        ),)
                      ],
                    ),
                    SizedBox(height: 4,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(

                        children: <Widget>[
                          Image.asset("assets/location.png", height: 12,color: AppColors.yellow),
                          SizedBox(width: 8,),
                          Text(address, style: TextStyle(
                              color: Colors.white,
                              fontSize: 10
                          ),),
                          Spacer(),
                          containerwidget(title: "VOTE", color: AppColors.yellow, ontap:onTap, Textcolor: AppColors.primaryColor,)
              // containerwidget(title: "Result", color: Colors.green, ontap:resultonTap,)

                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),


          ],
        ),

    );
  }
}

