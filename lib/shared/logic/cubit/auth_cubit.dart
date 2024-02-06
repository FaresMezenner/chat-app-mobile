import 'package:chat_app/shared/logic/state/auth_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthCubit extends Cubit<AuthState> with HydratedMixin {
  AuthCubit() : super(const AuthState(connected: false));

  void connect(String token) {
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
