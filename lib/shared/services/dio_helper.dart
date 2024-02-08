import 'package:chat_app/core/constants/endpoints.dart';
import 'package:chat_app/core/constants/errors/backend_erro.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init({String? token}) {
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
          "Authorization": token ?? "",
        },
        validateStatus: (status) => true,
      ),
    );
  }

  static setToken(String token) {
    dio.options.headers.addAll({
      "Authorization": token,
    });
  }

  static String _addLastSlash(String path) {
    if (path.endsWith("/")) {
      return path;
    }
    return "$path/";
  }

  static Future<Response> getData({
    required String path,
    String parameter = "",
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    String? token,
  }) async {
    path = _addLastSlash(path);
    path = path + parameter;
    if (token != null) {
      headers?.addAll({
        "Authorization": token,
      });
    }
    Response res = await dio.get(
      path,
      queryParameters: query,
      options: Options(
        headers: headers,
      ),
    );

    if (res.statusCode == 200) {
      return res;
    } else {
      throw BackendException(res.data["message"], res.statusCode!);
    }
  }

  static Future<Response> postData({
    required String path,
    required Map<String, dynamic> data,
    String parameter = "",
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    String? token,
  }) async {
    path = _addLastSlash(path);
    path = path + parameter;
    if (token != null) {
      headers?.addAll({
        "Authorization": token,
      });
    }
    Response res = await dio.post(
      path,
      data: data,
      queryParameters: query,
      options: Options(
        headers: headers,
      ),
    );

    if (res.statusCode == 200) {
      return res;
    } else {
      throw BackendException(res.data["message"], res.statusCode!);
    }
  }
}
