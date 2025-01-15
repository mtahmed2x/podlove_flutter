class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}

class BadRequestException extends ApiException {
  BadRequestException(super.message);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message);
}

class NotFoundException extends ApiException {
  NotFoundException(super.message);
}

class InternalServerException extends ApiException {
  InternalServerException(super.message);
}

class NoInternetException extends ApiException {
  NoInternetException(super.message);
}

class TimeoutException extends ApiException {
  TimeoutException(super.message);
}
