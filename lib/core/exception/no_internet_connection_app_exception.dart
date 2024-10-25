import 'package:demo_app/core/exception/app_exception.dart';

class NoInternetConnectionAppException extends AppException {
  NoInternetConnectionAppException({
    required super.message,
    required super.stackTrace,
  });
}
