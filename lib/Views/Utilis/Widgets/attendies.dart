import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uvento/Views/Polls/Polls_view.dart';

import '../App_colors.dart';

class Attendieswidget extends StatelessWidget {

  String desc;
  String name;
  String tablenumber;
  String imgeAssetPath;
 final VoidCallback ontap;
  /// later can be changed with imgUrl
  Attendieswidget({required this.desc, required this.name, required this.tablenumber, required this.imgeAssetPath,
    required this.ontap
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 70,
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
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imgeAssetPath,
                  height: 80,
                  width: 50,
                  fit: BoxFit.fill,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Container(
                      height: 80,
                      width: 50,
                      alignment: Alignment.center,
                      color: Colors.transparent, // You can customize the background color
                      child: Image.asset('assets/person_icon.webp')
                    );
                  },
                ),
              )

            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 8),
                width: MediaQuery.of(context).size.width - 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(name, style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    ),),
                    SizedBox(height: 4,),
                    Row(
                      children: <Widget>[

                        Expanded(
                          child: Text(desc, style: TextStyle(
                              color: AppColors.yellow,
                              fontSize: 10,

                          ),),
                        )
                      ],
                    ),
                    SizedBox(height: 4,),


                  ],
                ),
              ),
            ),


Icon(Icons.arrow_forward, color: AppColors.whiteColor,)
          ],
        ),
      ),
    );
  }
}


class Awardswidget extends StatelessWidget {

  String desc;
  String name;
  String tablenumber;
  String imgeAssetPath;
  /// later can be changed with imgUrl
  Awardswidget({required this.desc, required this.name, required this.tablenumber, required this.imgeAssetPath
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Polls()),
        // );
      },
      child: Container(
        height: 70,
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(
              color: AppColors.whiteColor,


              offset: Offset(0,0)

          )],
        ),
        child: Row(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imgeAssetPath,
                    height: 80,
                    width: 50,
                    fit: BoxFit.fill,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Container(
                          height: 80,
                          width: 50,
                          alignment: Alignment.center,
                          color: Colors.transparent, // You can customize the background color
                          child: Image.asset('assets/person_icon.webp')
                      );
                    },
                  ),
                )

            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 8),
                width: MediaQuery.of(context).size.width - 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(name, style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 4,),
                    Row(
                      children: <Widget>[

                        Expanded(
                          child: Text(desc, style: TextStyle(
                              color: AppColors.yellow,
                              fontSize: 10,
                              fontWeight: FontWeight.bold
                          ),),
                        )
                      ],
                    ),
                    SizedBox(height: 4,),


                  ],
                ),
              ),
            ),

            Icon(Icons.arrow_back)

          ],
        ),
      ),
    );
  }
}

