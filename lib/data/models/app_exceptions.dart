import 'package:finance_news/data/constants/strings.dart';

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, Strings.errorDuringCommunication);
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, Strings.invalidRequest);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, Strings.unauthorised);
}

class ForbiddenException extends AppException {
  ForbiddenException([String? message]) : super(message, Strings.forbidden);
}

class NotFoundException extends AppException {
  NotFoundException([String? message]) : super(message, Strings.notFound);
}

class ConflictException extends AppException {
  ConflictException([String? message]) : super(message, Strings.conflict);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super(message, Strings.invalidInput);
}
