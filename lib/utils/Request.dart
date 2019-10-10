import 'package:dio/dio.dart';

class Request {
  static Future<Map<String, dynamic>> get(
      String url, Map<String, dynamic> params) async {
        print(url);
    if (url != null && params != null && params.isNotEmpty) {
      // 请求
      Response<Future<Map<String, dynamic>>> res = await Dio().get(url, queryParameters: params);
      return res.data;
    }
    return null;
  }

  static Future<Map<String, dynamic>> post(String url, Map<String, dynamic> params) async {
    if (url != null && params != null && params.isNotEmpty) {
      // 请求
      Response<Future<Map<String, dynamic>>> res = await Dio().post(url, queryParameters: params);
      return res.data;
    }
    return null;
  }
}
