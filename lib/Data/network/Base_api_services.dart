abstract class BaseApiservices {

  Future<dynamic> getapiResponse(String url);
  Future<dynamic> postapiResponse(String url, dynamic data);
}