import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../app_expections.dart';
import 'Base_api_services.dart';

class Network_APi_services extends BaseApiservices{
  @override
  Future getapiResponse(String url) async {
  dynamic responsedata;
    try {
      final response = await http.get(Uri.parse(url));
      responsedata=returnResponse(response);
      print(responsedata);
    }
        on SocketException{
      throw FetchDataExpections("No Internet Connection");
        }
    return responsedata;
  }

  @override
  Future postapiResponse(String url, dynamic data) async {
    dynamic responsedata;
    var username = 'UraanApi';
    var password = 'x2FstVsz';
    String basicAuth = 'Basic' + base64Encode(utf8.encode('$username:$password'));
    try {
      Response response = await http.post(Uri.parse(url),
         body: data ,
        headers: {
        'Authorization': basicAuth,
        },

      );
      responsedata=returnResponse(response);
    }
    on SocketException {
      throw FetchDataExpections("No Internet Connection ");
    }
return responsedata;
  }

  dynamic returnResponse (http.Response response){
    switch(response.statusCode){
      case 200:
          dynamic resposnejson =jsonDecode(response.body);
          return resposnejson;
      case 400:
        throw BadRequestExpections(response.body.toString());
      case 404:
        throw UnauthorisedExpections(response.body.toString());

      default:
        throw FetchDataExpections("Error occured while communicating with server"+"with status code "+"${response.statusCode.toString()}");
    }
  }
}