import 'package:uvento/models/Attendees.dart';

import '../Data/network/Base_api_services.dart';
import '../Data/network/Network_api_services.dart';
import '../Res/App_url.dart';
import '../models/Comittee_model.dart';


class Comittee_repository {

  BaseApiservices apiservices=Network_APi_services();

  Future<CommitteeData> userlist() async {

    dynamic resposne =await apiservices.getapiResponse(Appurl.Comitteeurl);
    return resposne=CommitteeData.fromJson(resposne);
  }


}