import 'package:uvento/models/Attendees.dart';

import '../Data/network/Base_api_services.dart';
import '../Data/network/Network_api_services.dart';
import '../Res/App_url.dart';
import '../models/Awards.dart';


class awards_repository {

  BaseApiservices apiservices=Network_APi_services();

  Future<AwardList> userlist() async {

    dynamic resposne =await apiservices.getapiResponse(Appurl.awards);
    return resposne=AwardList.fromJson(resposne);
  }
}