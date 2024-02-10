import 'package:chat_app/features/home/domaine/providers/contacts_api.dart';
import 'package:chat_app/shared/domaine/models/message.dart';
import 'package:chat_app/shared/domaine/models/user.dart';

class ContactsRepository {
  static Future<User> fetchUser(Map<String, dynamic> fetchOptions) async {
    try {
      final user = await ContactsApi.fetchRawUser(fetchOptions);
      return User.fromMap(user);
    } catch (e) {
      rethrow;
    }
  }

  static Future<User> fetchUserByPhone(String phone) async {
    try {
      final user = await ContactsApi.fetchRawUserByPhone(phone);
      return User.fromMap(user);
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<User>> fetchAllContacts() async {
    try {
      List<Map<String, dynamic>> contacts =
          await ContactsApi.fetchRawContacts();
      return contacts.map((e) => User.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Map<User, Map<String, dynamic>>>>
      fetchAllContactsWithLastMessage() async {
    try {
      List<Map<String, dynamic>> contacts =
          await ContactsApi.fetchRawContacts();
      return contacts
          .map((e) => {
                User.fromMap(e): {
                  "lastMessageSentDate":
                      DateTime.tryParse(e["lastMessageSentDate"]),
                  "lastMessageContent": e["lastMessageContent"],
                }
              })
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> insertMessage(Message message) async {
    try {
      Map<String, dynamic> messageMap = message.toMap();
      messageMap.remove("id");
      await ContactsApi.insertRawMessage(messageMap);
    } catch (e) {
      rethrow;
    }
  }
}
