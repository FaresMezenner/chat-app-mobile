import 'package:chat_app/features/add_contact/domaine/providers/fetch_user_api.dart';
import 'package:chat_app/shared/logic/domaine/models/user.dart';

class FetchUserRepository {
  static Future<User> fetchUserByPhone(String phone) async {
    try {
      final user = await FetchUserApi.fetchRawUserByPhone(phone);
      return User.fromMap(user);
    } catch (e) {
      rethrow;
    }
  }
}
