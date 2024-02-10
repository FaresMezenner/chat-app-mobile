import 'package:chat_app/features/home/logic/cubit/contacts_cubit.dart';
import 'package:chat_app/shared/services/socket_io_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'package:chat_app/features/socket_io/logic/state/socket_io_state.dart';

class SocketIoCubit extends Cubit<SocketIoState> {
  late final SocketIoHelper _socketIoHelper;
  late final ContactsCubit contactsCubit;

  SocketIoCubit({
    required this.contactsCubit,
  }) : super(SocketIoInitial());

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
      onNewMessage: (message) {
        contactsCubit.receiveMessage(
          message,
        );
      },
    );
  }

  void disconnect() {
    _socketIoHelper.disconnect();
    emit(SocketIoDisconnected());
  }
}
