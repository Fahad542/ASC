import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart';

class downloadViewModel extends ChangeNotifier {
  bool _ischeck = false;
  bool get ischeck =>_ischeck;
  void setcheck(bool value){
    _ischeck =value;
    notifyListeners();}
  List<dynamic> datalist=[];
  Stream<DocumentSnapshot<Map<String, dynamic>>> getdata = FirebaseFirestore.instance.collection('downloads').doc('Zk1i9QPGi1yBuHuvYF85').snapshots();

  // Future<void> initialdate() async {
  //   try {
  //     setcheck(true);
  //   var snapshot=await getdata.first;
  //   if(snapshot.exists){
  //     var data=snapshot.data();
  //     if(data != null && data.isNotEmpty){
  //       datalist=data.values.toList();
  //      print(datalist);
  //       setcheck(false);
  //       notifyListeners();
  //     }
  //   } }
  //       catch(e){
  //         setcheck(false);
  //       }
  // }

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      // Show a message to the user or handle the case where permission is denied
      print('Storage permission denied');
      return;
    }
    print('Storage permission granted');
  }
  // Future<void> downloadPdf(String url, BuildContext context) async {
  //   try {
  //     // Request permission to access storage
  //     var status = await Permission.storage.request();
  //     if (!status.isGranted) {
  //       // Handle permission denied
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Storage permission denied')),
  //       );
  //       return;
  //     }
  //
  //     // Get the document directory
  //     final directory = await getExternalStorageDirectory();
  //     if (directory == null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to get external storage directory')),
  //       );
  //       return;
  //     }
  //     final filePath = '${directory.path}/${url.split('/').last}';
  //
  //     // Show progress indicator
  //     final dio = Dio();
  //     await dio.download(
  //       url,
  //       filePath,
  //       onReceiveProgress: (received, total) {
  //         if (total != -1) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text('Downloading: ${((received / total) * 100).toStringAsFixed(0)}%')),
  //           );
  //         }
  //       },
  //     );
  //
  //     // Notify user that the file has been downloaded
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('File downloaded to $filePath')),
  //     );
  //
  //     // Optionally, open the downloaded file
  //     final result = await OpenFile.open(filePath);
  //     if (result.type != ResultType.done) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to open the file')),
  //       );
  //     }
  //   } catch (e) {
  //     // Handle errors
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error downloading file: $e')),
  //     );
  //   }
  // }



}

