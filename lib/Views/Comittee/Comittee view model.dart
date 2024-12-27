import 'package:flutter/widgets.dart';
import 'package:uvento/Data/response/api_response.dart';
import 'package:uvento/Repository/Attendees_repository.dart';
import 'package:uvento/models/Attendees.dart';

import '../../Repository/Comittee_repository.dart';
import '../../Repository/Feedback_repository.dart';
import '../../models/Comittee_model.dart';
import '../Services/local_db.dart';

class Comittee_view_model with ChangeNotifier
{
  final repo = Comittee_repository();
  final repo1 = feedback_repository();
  DatabaseHelper _databaseHelper = DatabaseHelper();
  String searchquery='';
  TextEditingController controller=TextEditingController();
  void updatesearchquery(String query){
    searchquery=query;
    notifyListeners();
  }
  ApiResponse<CommitteeData>list =ApiResponse.loading();
  void setlist(ApiResponse<CommitteeData> data){
    list=data;
    notifyListeners();
  }
  Future<void> attendees() async{

    try {
      setlist(ApiResponse.loading());
      final value =await repo.userlist();
      setlist(ApiResponse.complete(value));


    }
    catch(e){
      setlist(ApiResponse.error(e.toString()));
    }
  }
  List<CommitteeMember> get filterlist {
    if(searchquery.isEmpty){
      return list.data!.datalist ??[];
    }
    else {
      return list.data!.datalist.where((element) => element.memberName.toLowerCase().contains(searchquery)).toList();
    }
  }

}