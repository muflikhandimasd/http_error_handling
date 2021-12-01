class CustomApiException implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  @override
  String toString() {
    // ignore: avoid_print
    print("http error : $_message");
    return "$_prefix$_message";
  }

  CustomApiException(this._message, this._prefix);
}

class FetchDataException extends CustomApiException {
  FetchDataException(message) : super(message, 'Failed to get data :\n');
}

class BadRequestException extends CustomApiException {
  BadRequestException(message) : super(message, 'Invalid request :\n');
}

class UnauthorizedException extends CustomApiException {
  UnauthorizedException(message) : super(message, 'Unauthorized :\n');
}

class InvalidInputException extends CustomApiException {
  InvalidInputException(message) : super(message, 'Invalid input :\n');
}
