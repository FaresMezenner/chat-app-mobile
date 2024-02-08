import 'package:chat_app/shared/logic/state/auth_state.dart';
import 'package:chat_app/shared/services/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit() : super(const AuthState(connected: false));

  void connect(String token) {
    DioHelper.setToken(token);
    emit(AuthState(connected: true, token: token));
  }

  void disconnect() {
    emit(const AuthState(connected: false));
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toMap();
  }
}
