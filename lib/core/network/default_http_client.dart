import 'dart:async';

import 'package:demo_app/core/exception/app_exception.dart';
import 'package:demo_app/core/exception/no_internet_connection_app_exception.dart';
import 'package:demo_app/core/exception/server_error_app_exception.dart';
import 'package:demo_app/core/network/http_client.dart';
import 'package:demo_app/core/result.dart';
import 'package:dio/dio.dart';

typedef InvokeCallback = Future<Response<dynamic>> Function();

class DefaultHttpClient implements HttpClient {
  DefaultHttpClient() : _dio = Dio();

  final Dio _dio;

  static const _timeout = Duration(seconds: 30);

  @override
  Future<Result<T, AppException>> get<T>({
    required String url,
    required ResponseMapper<T> responseMapper,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _guardInvoker<T>(
      () => _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      ),
      responseMapper: responseMapper,
    );
  }

  Future<Result<T, AppException>> _guardInvoker<T>(
    InvokeCallback invoke, {
    required ResponseMapper<T> responseMapper,
  }) async {
    try {
      final response = await invoke().timeout(_timeout);

      return Result.success(responseMapper(response.data));
    } on TimeoutException catch (e, stackTrace) {
      return Result.failure(
        NoInternetConnectionAppException(
          message: e.toString(),
          stackTrace: stackTrace,
        ),
      );
    } on DioException catch (e) {
      final appException = _handleDioError(e);

      return Result.failure(appException);
    }
  }
}

AppException _handleDioError(DioException error) {
  return switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.connectionError =>
      NoInternetConnectionAppException(
        message: 'No internet connection',
        stackTrace: error.stackTrace,
      ),
    DioExceptionType.badResponse => ServerErrorAppException(
        message: 'Server error: ${error.response?.statusCode}',
        stackTrace: error.stackTrace,
      ),
    _ => AppException(
        message: 'Something went wrong',
        stackTrace: error.stackTrace,
      ),
  };
}
