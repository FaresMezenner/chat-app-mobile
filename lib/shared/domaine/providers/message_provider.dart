import 'package:chat_app/core/constants/enums/tables.dart';
import 'package:chat_app/shared/services/sqlite_helper.dart';

class MessagesProvider {
  static Future<int> addRawMessage(Map<String, dynamic> message) async {
    int lastId = await SqliteHelper().insert(
      message,
      Tables.messages.getName(),
    );

    return lastId;
  }
}
