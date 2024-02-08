import 'package:chat_app/features/socket_io/logic/state/socket_io_state.dart';
import 'package:chat_app/shared/services/socket_io_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocketIoCubit extends Cubit<SocketIoState> {
  late final SocketIoHelper _socketIoHelper;

  SocketIoCubit() : super(SocketIoInitial());

  void connect(String token) {
    _socketIoHelper = SocketIoHelper(
      token: token,
      onDisconnect: (_) {
        emit(SocketIoDisconnected());
      },
      onConnect: (_) {
        emit(SocketIoConnected());
      },
      onError: (_) {
        emit(SocketIoError());
      },
    );
  }

  void disconnect() {
    _socketIoHelper.disconnect();
    emit(SocketIoDisconnected());
  }
}
