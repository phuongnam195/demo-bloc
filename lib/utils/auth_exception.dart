enum AuthSource { email, password, unknown }

class AuthException implements Exception {
  AuthException(this.message, this.source);

  final String message;
  final AuthSource source;

  @override
  String toString() {
    return message;
  }
}
