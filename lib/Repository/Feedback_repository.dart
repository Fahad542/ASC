import '../Data/network/Base_api_services.dart';
import '../Data/network/Network_api_services.dart';
import '../Res/App_url.dart';


class feedback_repository {

  BaseApiservices apiservices=Network_APi_services();

  Future<dynamic> feedback(String code,String ratings, String feedback) async {

    dynamic resposne =await apiservices.getapiResponse('${Appurl.baseurl+'/submit_feedback.php?emp_code=${code}&rating=${ratings}&feedback=${feedback}'}');
    print(resposne);
    return resposne['Response'];
  }
}