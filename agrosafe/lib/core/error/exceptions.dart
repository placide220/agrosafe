class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Server exception occurred']);

  @override
  String toString() => message;
}

class AuthException implements Exception {
  final String message;
  AuthException([this.message = 'Authentication exception occurred']);

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Cache exception occurred']);

  @override
  String toString() => message;
}
