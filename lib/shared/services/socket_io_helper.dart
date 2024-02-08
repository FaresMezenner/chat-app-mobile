import 'package:chat_app/core/constants/endpoints.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketIoHelper {
  late final Socket _socket;

  SocketIoHelper({
    required String token,
    required Function(dynamic) onDisconnect,
    required Function(dynamic) onConnect,
    required Function(dynamic) onError,
  }) {
    _socket = io(
        Endpoints.socketIoUrl,
        OptionBuilder()
            .setTransports(['websocket'])
            .setQuery({
              'token': token,
            })
            .setPath("/socket.io/")
            .setReconnectionAttempts(0)
            .setReconnectionDelay(0)
            .build());

    _socket.onDisconnect(onDisconnect);
    _socket.onConnect(onConnect);
    _socket.onError((error) {
      print('socket io error: $error');
    });

    connect();
  }

  void connect() {
    _socket.connect();
  }

  void disconnect() {
    _socket.disconnect();
  }

  void sendMessage(String message) {
    _socket.emit('message', message);
  }

  void listenToMessages(void Function(String) onMessage) {
    _socket.on('message', (data) {
      onMessage(data);
    });
  }
}
