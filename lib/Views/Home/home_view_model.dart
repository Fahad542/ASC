import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/change_notifier.dart';



class HomeViewModel extends ChangeNotifier {
  String selecteddate = "";

  Stream<DocumentSnapshot<Map<String, dynamic>>> getdata=FirebaseFirestore.instance.collection('data').doc('HnkmiNvEPcoeYcqpFabw').snapshots();
  void setSelectedDate(String date) {
    selecteddate = date;
    notifyListeners();
  }
  Future<void> initialdate() async {
    var snapshot=await getdata.first;
    if(snapshot.exists){
      var data=snapshot.data();
      if(data != null && data.isNotEmpty){
        selecteddate =data.keys.first;
        notifyListeners();
      }
    }
    }
  }





