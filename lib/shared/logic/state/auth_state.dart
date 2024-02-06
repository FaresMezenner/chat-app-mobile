// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final bool connected;
  final String? token;

  const AuthState({
    required this.connected,
    this.token,
  });

  @override
  List<Object?> get props => [connected, token];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'connected': connected,
      'token': token,
    };
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(
      connected: map['connected'] as bool,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthState.fromJson(String source) =>
      AuthState.fromMap(json.decode(source) as Map<String, dynamic>);
}
