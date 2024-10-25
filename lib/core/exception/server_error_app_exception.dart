import 'package:demo_app/core/exception/app_exception.dart';

class ServerErrorAppException extends AppException {
  ServerErrorAppException({
    required super.message,
    required super.stackTrace,
  });
}
