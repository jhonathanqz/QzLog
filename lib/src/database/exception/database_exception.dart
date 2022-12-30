abstract class DatabaseExceptions implements Exception {
  final String message;

  DatabaseExceptions(this.message);
}

class DatabaseNotFoundException extends DatabaseExceptions {
  DatabaseNotFoundException(String message) : super(message);
}
