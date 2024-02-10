// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

class Message {
  final String? id;
  final String message;
  final String contact;
  final bool received;
  final DateTime sentDate;

  Message({
    this.id,
    required this.message,
    required this.contact,
    required this.received,
    required this.sentDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'contact': contact,
      'received': received ? 1 : 0,
      'sentDate': sentDate.toIso8601String(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] != null ? map['id'] as String : null,
      message: map['message'] as String,
      contact: map['contact'] as String,
      received: map['received'] is bool
          ? map['received'] as bool
          : map['received'] as int == 1,
      sentDate: DateTime.parse(map['sentDate'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(id: $id, message: $message, contact: $contact, received: $received, sentDate: $sentDate)';
  }
}
