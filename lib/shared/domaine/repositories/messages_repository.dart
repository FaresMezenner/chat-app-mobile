import 'package:chat_app/shared/domaine/models/message.dart';
import 'package:chat_app/shared/domaine/providers/message_provider.dart';

class MessagesRepository {
  static Future<int> addMessage(Message message) async {
    return await MessagesProvider.addRawMessage(message.toMap());
  }
}
