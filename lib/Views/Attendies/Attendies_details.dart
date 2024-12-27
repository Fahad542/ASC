
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Services/local_db.dart';
import '../Utilis/App_colors.dart';
import '../Utilis/Widgets/container.dart';

class Attendies_detail extends StatefulWidget {
  final String imgeAssetPath;
  final String name;
  final String decs;
   var room_no;
   var  table_no;
  final String number;
  final String branch;
  final String hotel_name;
   Attendies_detail({super.key, required this.imgeAssetPath, required this.name, required this.decs, required this.room_no, required this.table_no, required this.number, required this.hotel_name, required this.branch});

  @override
  State<Attendies_detail> createState() => _Attendies_detailState();
}

class _Attendies_detailState extends State<Attendies_detail> {
  @override
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  Future<void> _makePhoneCall(String phoneNumber) async {
    var status = await Permission.phone.status;
    if (status.isDenied) {

      await Permission.phone.request();
      status = await Permission.phone.status;
    }

    if (status.isGranted) {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        print('Could not launch $phoneNumber');
      }
    } else {
      print('Phone permission denied');
    }
  }
  Future<void> showNamesDialog(BuildContext context, String roomNumber, String name) async {
    try {
      // Fetch names from the database
      List<String> names = await _databaseHelper.getnames(roomNumber, name); // Replace with your actual database method

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Adjust border radius here
            ),
            child: Container(
              decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.all(16.0), // Adjust padding as needed
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ensures the dialog takes up only as much space as needed
                children: <Widget>[
                  Text(
                    'Room Memebers',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: AppColors.yellow
                    ),
                  ),
                  SizedBox(height: 12.0), // Adjust spacing between title and content
                  names.isEmpty
                      ? Text('No members found.' , style: TextStyle(color: AppColors.yellow),)
                      : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: names.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(names[index], style: TextStyle(color: AppColors.whiteColor),),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12.0), // Adjust spacing before the button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: Text('Close', style: TextStyle(color: AppColors.yellow),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print("Failed to retrieve names: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13.0), // Adjust border radius here
            ),
            child: Container(
              padding: EdgeInsets.all(16.0), // Adjust padding as needed
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Error',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 12.0), // Adjust spacing between title and content
                  Text('Failed to retrieve names from database.'),
                  SizedBox(height: 12.0), // Adjust spacing before the button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        title: Text("Personal Data", style: TextStyle(color: AppColors.whiteColor)),
      ),
      body: SingleChildScrollView(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            SizedBox(height: 16),
            Column(
              children: [
                Center(
                  child: ClipOval(
                    child: Image.network(
                      widget.imgeAssetPath,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Container(
                          height: 100,
                          width: 100,
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          child: Image.asset(
                            'assets/person_icon.webp',

                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8,),

                Text(
                  widget.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                    fontSize: 22,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Divider(color: AppColors.primaryColor.withOpacity(0.1), thickness: 4.0,),
                ),

              ],
            ),
            SizedBox(height: 34),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.work, color: AppColors.yellow),
                      SizedBox(width: 8),
                      Text(
                        "Designation:",
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text("         ${widget.decs}"
                    ,
                    style: TextStyle(fontSize: 16, color: AppColors.whiteColor),
                  ),
                  Divider(color: AppColors.whiteColor.withOpacity(0.7)),
                  Row(
                    children: [
                      Icon(Icons.table_bar, color: AppColors.yellow),
                      SizedBox(width: 8),
                      Text(
                        "Table No:",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.yellow
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text("         ${widget.table_no.toString()}"
                    ,
                    style: TextStyle(fontSize: 16, color: AppColors.whiteColor),
                  ),
                  Divider(color: AppColors.whiteColor.withOpacity(0.7)),
                  Row(
                    children: [
                      Icon(Icons.room, color: AppColors.yellow),
                      SizedBox(width: 8),
                      Text(
                        "Room No:",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.yellow
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("         ${widget.room_no.toString()}"
                        ,
                        style: TextStyle(fontSize: 16, color: AppColors.whiteColor),
                      ),
                      // InkWell(
                      //   onTap: (){
                      //
                      //     showNamesDialog(context,widget.room_no, widget.name);
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.all(8),
                      //
                      //     decoration: BoxDecoration(color: AppColors.yellow, borderRadius: BorderRadius.circular(8)),
                      //
                      //     child: Text('See Memebers', style: TextStyle(color: AppColors.primaryColor, fontSize: 9, fontWeight: FontWeight.bold),),),
                      // ),
        if (widget.room_no != "0" && RegExp(r'^[0-9]+$').hasMatch(widget.room_no))

                      containerwidget(title: "Room Mates", color: AppColors.yellow, ontap:(){showNamesDialog(context,widget.room_no.toString(), widget.name);}, Textcolor: AppColors.primaryColor,)

                    ],
                  ),


                  SizedBox(height: 8),
                  Divider(color: AppColors.whiteColor.withOpacity(0.7)),
                  Row(
                    children: [
                      Icon(Icons.phone, color: AppColors.yellow),
                      SizedBox(width: 8),
                      Text(
                        "Phone:",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.yellow
                        ),
                      ),


                    ],

                  ),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      _makePhoneCall(widget.number);
                      // const url = 'https://www.google.com';
                      // try {
                      //   if (await canLaunch(url)) {
                      //     await launch(url);
                      //   } else {
                      //     throw 'Could not launch $url';
                      //   }
                      // } catch (e) {
                      //   print(e);
                      // }
                      //_makePhoneCall(mobile);
                    },

                    child: Text(
                      "         ${widget.number}",
                      style: TextStyle(fontSize: 16, color: AppColors.whiteColor),
                    ),
                  ),


                  Divider(color: AppColors.whiteColor.withOpacity(0.7)),
                  Row(
                    children: [
                      Icon(Icons.hotel, color: AppColors.yellow),
                      SizedBox(width: 8),
                      Text(
                        "Hotel of stay:",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.yellow
                        ),
                      ),


                    ],

                  ),
                  SizedBox(height: 8),
                  Text(
                    "         ${widget.hotel_name}",
                    style: TextStyle(fontSize: 16, color: AppColors.whiteColor)
                  ),
                  Divider(color: AppColors.whiteColor.withOpacity(0.7)),
                  Row(
                    children: [
                      Icon(Icons.home, color: AppColors.yellow),
                      SizedBox(width: 8),
                      Text(
                        "Branch:",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.yellow
                        ),
                      ),


                    ],

                  ),
                  SizedBox(height: 8),
                  Text(
                      "         ${widget.branch}",
                      style: TextStyle(fontSize: 16, color: AppColors.whiteColor)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

