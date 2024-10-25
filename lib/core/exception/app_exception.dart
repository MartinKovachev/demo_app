class AppException implements Exception {
  const AppException({
    required this.message,
    required this.stackTrace,
  });

  final StackTrace stackTrace;
  final String message;
}
