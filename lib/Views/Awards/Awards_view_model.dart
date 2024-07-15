import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:uvento/Data/response/api_response.dart';
import '../../Repository/Awards_repository.dart';
import '../../models/Awards.dart';

class Awards_view_model with ChangeNotifier
{
  Stream<DocumentSnapshot<Map<String, dynamic>>> getdata =FirebaseFirestore.instance.collection('Awards').doc('n50tqT6Dn9R632NQOlAD-award').snapshots();
  final repo = awards_repository();
  String searchquery='';
  TextEditingController controller=TextEditingController();
  void updatesearchquery(String query){
    searchquery=query;
    notifyListeners();
  }
  ApiResponse<AwardList>list =ApiResponse.loading();
  void setlist(ApiResponse<AwardList> data){
    list=data;
    notifyListeners();
  }
  Future<void> attendees() async {

    try {
      setlist(ApiResponse.loading());
      final value =await repo.userlist();
      setlist(ApiResponse.complete(value));

    }
    catch(e){
      setlist(ApiResponse.error(e.toString()));
    }
  }
}