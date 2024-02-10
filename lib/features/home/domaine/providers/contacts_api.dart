import 'package:chat_app/core/constants/endpoints.dart';
import 'package:chat_app/core/constants/enums/tables.dart';
import 'package:chat_app/shared/services/dio_helper.dart';
import 'package:chat_app/shared/services/sqlite_helper.dart';

class ContactsApi {
  static Future<Map<String, dynamic>> fetchRawUser(
      Map<String, dynamic> fetchOptions) async {
    try {
      final response = await DioHelper.getData(
        path: Endpoints.user,
        headers: fetchOptions,
      );
      response.data["user"]["id"] = response.data["user"]["_id"];
      response.data.remove("_id");
      return response.data["user"] as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

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

  static Future<List<Map<String, dynamic>>> fetchRawContacts() async {
    try {
      return SqliteHelper().rawQuery('''
  SELECT
    ${Tables.contacts.getName()}.id AS id,
    ${Tables.contacts.getName()}.phone AS phone,
    ${Tables.contacts.getName()}.name AS name,
    MAX(${Tables.messages.getName()}.sentDate) AS lastMessageSentDate,
    ${Tables.messages.getName()}.message AS lastMessageContent
  FROM
    ${Tables.contacts.getName()}
  LEFT JOIN
    ${Tables.messages.getName()} ON ${Tables.contacts.getName()}.id = ${Tables.messages.getName()}.contact
  GROUP BY
    ${Tables.contacts.getName()}.id
''');
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> insertRawMessage(Map<String, dynamic> message) async {
    try {
      await SqliteHelper().insert(message, Tables.messages.getName());
    } catch (e) {
      rethrow;
    }
  }
}
