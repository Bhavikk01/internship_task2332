
import 'dart:developer';

import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {

  static ApiClient get to => Get.find();
  String token = '';
  String appBaseUrl = 'http://10.10.40.217:5000/';

  Future<Response> getData(String uri) async{
    try{
      var response = await get(appBaseUrl+uri);
      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

  Future<Response> postData(String uri,dynamic body)async{
    try{
      log('$token is the current token');
      var response = await post(
          uri,
          body,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Token': token,
          }
      );
      return response;
    }catch(e){
      log(e.toString());
      return Response(statusCode: 1,statusText: e.toString());
    }
  }
}