import 'package:chat_app/core/constants/endpoints.dart';
import 'package:chat_app/shared/services/dio_helper.dart';

class FetchUserApi {
  static Future<Map<String, dynamic>> fetchRawUserByPhone(String phone) async {
    try {
      final response = await DioHelper.getData(
        path: Endpoints.user,
        parameter: phone,
      );
      response.data["user"]["id"] = response.data["user"]["_id"];
      return response.data["user"] as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
}
