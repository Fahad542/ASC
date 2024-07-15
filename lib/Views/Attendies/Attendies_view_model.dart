import 'package:flutter/widgets.dart';
import 'package:uvento/Data/response/api_response.dart';
import 'package:uvento/Repository/Attendees_repository.dart';
import 'package:uvento/models/Attendees.dart';

import '../../Repository/Feedback_repository.dart';

class Attendies_view_model with ChangeNotifier
{
  final repo = attendies_repository();
  final repo1 = feedback_repository();
  String searchquery='';
  TextEditingController controller=TextEditingController();
  void updatesearchquery(String query){
    searchquery=query;
    notifyListeners();
  }
  ApiResponse<MemberList>list =ApiResponse.loading();
  void setlist(ApiResponse<MemberList> data){
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
  List<Member> get filterlist {
    if(searchquery.isEmpty){
      return list.data?.datalist ?? [];
    }
    else {
      return list.data!.datalist.where((element) => element.memberName.toLowerCase().contains(searchquery)).toList();
    }
  }

}