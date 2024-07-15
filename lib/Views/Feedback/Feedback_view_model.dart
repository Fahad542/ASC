import 'package:flutter/cupertino.dart';
import 'package:uvento/Data/response/api_response.dart';
import 'package:uvento/Repository/Feedback_repository.dart';

import '../../Repository/Attendees_repository.dart';
import '../../Services.dart';
import '../../models/Attendees.dart';
import '../Utilis/Utilis.dart';

class Feedback_view_model with ChangeNotifier {

  String rating = '';

  bool _check=false;

  DatabaseHelper dbHelper = DatabaseHelper();

  bool get check => _check;

  void setCheck(bool value) {

    _check = value;

    notifyListeners();
  }
  final repo = attendies_repository();

  final repo1 = feedback_repository();

  final TextEditingController controller = TextEditingController();

  final TextEditingController code = TextEditingController();

  ApiResponse<MemberList> list=ApiResponse.loading();

  void setlist(ApiResponse<MemberList> data){

    list=data;

    notifyListeners();

  }
  Future<void> attendees() async{

    setCheck(true);
    try {

      setlist(ApiResponse.loading());

      final value =await repo.userlist();

      setlist(ApiResponse.complete(value));

      setCheck(false);

    }
    catch(e){
      setlist(ApiResponse.error(e.toString()));
      setCheck(false);
    }
  }
  Future<void> submit() async{
    setCheck(true);
    try {

      final value =await repo1.feedback(code.text.toString(), rating, controller.text.toString());

      if(value['code']== 200)
        {

          await dbHelper.insertFeedback(code.text.toString(), controller.text.toString(), rating);

          Utilis.submit(value['message'].toString());

          setCheck(false);

        }
      else {
        Utilis.submit(value['message'].toString());
      }
      }
    catch(e){

      print( e.toString());

      setCheck(false);
    }
  }
  Future<bool> loadData() async {

    bool hasFeedbacks = await dbHelper.hasFeedbacks();

    return hasFeedbacks;

  }
}