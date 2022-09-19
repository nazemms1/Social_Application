import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        // headers: {
        //   'Content-Type':'application/json',
        // }
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    required String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? querys,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return await dio.post(
      url,
      queryParameters: querys,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? querys,
   Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    return await dio.put(
      url,
      queryParameters: querys,
      data: data,
    );
  }
}
