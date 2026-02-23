import 'dart:async';
import 'package:alert_her/core/utils/app_extension.dart';
import 'package:http/http.dart' as http;
import '../constants/api_const.dart';
import 'local_storage.dart';

class HttpClient {
  static const String baseUrl = ApiConst.baseURL;

  static Future<Map<String, String>> getHeaders() async {
    String? token = await LocalStorage().getToken();
    Dbg.p("token :: $token");
    return {
      'content-type': 'application/json; charset=UTF-8',
      'accept-encoding': 'gzip, deflate, br',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<http.Response> get(String endPoint) async {
    final headers = await getHeaders();
    return await http.get(Uri.parse('$baseUrl$endPoint'), headers: headers);
  }

  static Future<http.Response> delete(String endPoint) async {
    final headers = await getHeaders();
    return await http.delete(Uri.parse('$baseUrl$endPoint'), headers: headers);
  }

  static Future<http.Response> post(String endPoint, Object body) async {
    final headers = await getHeaders();
    return await http.post(Uri.parse('$baseUrl$endPoint'), body: body, headers: headers);
  }

  static Future<http.Response> postCustomWithToken(String endPoint, Object body,String verifyToken) async {
    final headers = {
      'Content-Type': 'application/json',
      if (verifyToken != null) 'Authorization': 'Bearer $verifyToken',
    };
    return await http.post(Uri.parse('$baseUrl$endPoint'), body: body, headers: headers);
  }

}
