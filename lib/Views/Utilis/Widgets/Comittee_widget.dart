import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../App_colors.dart';

class Comitteewidget extends StatelessWidget {

  String desc;
  String name;
  String number;
  String imgeAssetPath;

  /// later can be changed with imgUrl
  Comitteewidget({required this.desc, required this.name, required this.number, required this.imgeAssetPath,

  });

  @override
  Widget build(BuildContext context) {
    return  Container(
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

            InkWell(
              onTap: (){
                launch('https://wa.me/${number}');
              },
              child: Padding(
                  padding: EdgeInsets.only(right: 1),
                  child: Image.asset('assets/whatsapp.png', height: 40, width: 40,color: AppColors.yellow,)
            )),
            InkWell(
              onTap: (){
                launch('tel:${number.replaceFirst('+92', '0')}');

              },
              child: Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(Icons.phone, color: AppColors.yellow,size: 20,)),
            )
          ],
        ),

    );
  }
}
