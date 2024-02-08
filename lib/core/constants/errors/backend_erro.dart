class BackendException implements Exception {
  final String message;
  final int code;

  BackendException(this.message, this.code);

  @override
  String toString() {
    return 'BackendError{message: $message, code: $code}';
  }
}
