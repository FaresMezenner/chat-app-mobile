// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String phone;
  final String name;
  final bool read;

  User({
    required this.id,
    required this.phone,
    required this.name,
    this.read = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'phone': phone,
      'name': name,
      'read': read ? 1 : 0,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      phone: map['phone'] as String,
      name: map['name'] as String,
      read: map.containsKey("read")
          ? ['read'] is bool
              ? map['read'] as bool
              : map['read'] as int == 1
          : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, phone: $phone, name: $name, read: $read)';
  }
}
