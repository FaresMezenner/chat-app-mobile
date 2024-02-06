import 'package:chat_app/core/constants/endpoints.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 1),
        receiveDataWhenStatusError: true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {
          "Content-Type": "application/json",
          "Accept-Language": "EN",
        },
      ),
    );
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    String token = '',
  }) async {
    headers?.addAll({
      "Authorization": token,
    });
    return await dio.get(
      path,
      queryParameters: query,
      options: Options(
        headers: headers,
      ),
    );
  }

  static Future<Response> postData({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    String token = '',
  }) async {
    headers?.addAll({
      "Authorization": token,
    });
    return await dio.post(
      path,
      data: data,
      queryParameters: query,
      options: Options(
        headers: headers,
      ),
    );
  }
}
