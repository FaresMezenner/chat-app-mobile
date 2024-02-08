class SocketIoState {}

class SocketIoInitial extends SocketIoState {}

class SocketIoConnected extends SocketIoState {}

class SocketIoDisconnected extends SocketIoState {
  final String message;

  SocketIoDisconnected(
      {this.message = "Maybe server is down, please try again later."});
}

class SocketIoError extends SocketIoState {
  final String message;

  SocketIoError(
      {this.message = "Something went wrong, please try again later."});
}
