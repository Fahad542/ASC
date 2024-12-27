import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uvento/Views/Utilis/Utilis.dart';
import '../Services/local_db.dart';

class Pollsviewmodel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _ischeck = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  bool get ischeck => _ischeck;

  void setcheck(bool value) {
    _ischeck = value;
    notifyListeners();
  }

  DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> incrementVote(String awardId, String nomineeId) async {
    setcheck(true);
    try {
      String? token = await _firebaseMessaging.getToken();
      await _databaseHelper.insertVote(awardId, nomineeId, token.toString());

      // Reference to the Awards document
      DocumentReference awardsRef = _firestore.collection('Awards').doc('n50tqT6Dn9R632NQOlAD-award');
      DocumentSnapshot awardsSnapshot = await awardsRef.get();

      if (awardsSnapshot.exists) {
        Map<String, dynamic> data = awardsSnapshot.data() as Map<String, dynamic>;

        if (data.containsKey(awardId)) {
          if (data[awardId]['nominee'].containsKey(nomineeId)) {
            int currentVotes = data[awardId]['nominee'][nomineeId]['votes'];
            data[awardId]['nominee'][nomineeId]['votes'] = currentVotes + 1;
            await awardsRef.update(data);
            Utilis.success("Vote Submitted Successfully");
          } else {
            throw 'Nominee does not exist';
          }
        } else {
          throw 'Award does not exist';
        }
      } else {
        throw 'Awards document does not exist';
      }
    } catch (e) {
      Utilis.toastmessage(e.toString());
      print('Error incrementing vote: $e');
    } finally {
      setcheck(false);
    }
  }
}
