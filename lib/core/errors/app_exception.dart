abstract class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}

// All Exception

class LocationException extends AppException {
  LocationException(super.message);
}

class AuthException extends AppException {
  AuthException(super.message);
}

class NetworkException extends AppException {
  NetworkException(super.message);
}

class DatabaseException extends AppException {
  DatabaseException(super.message);
}
