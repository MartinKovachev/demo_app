import 'package:demo_app/core/exception/app_exception.dart';
import 'package:demo_app/core/result.dart';

typedef Json = Map<String, dynamic>;
typedef ResponseMapper<T> = T Function(Json json);

abstract interface class HttpClient {
  Future<Result<T, AppException>> get<T>({
    required String url,
    required ResponseMapper<T> responseMapper,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });
}
