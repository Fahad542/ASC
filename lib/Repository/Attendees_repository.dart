import 'package:uvento/models/Attendees.dart';

import '../Data/network/Base_api_services.dart';
import '../Data/network/Network_api_services.dart';
import '../Res/App_url.dart';


class attendies_repository {

  BaseApiservices apiservices=Network_APi_services();

  Future<MemberList> userlist() async {

    dynamic resposne =await apiservices.getapiResponse(Appurl.Attendeesurl);
    return resposne=MemberList.fromJson(resposne);
  }


}