class Result<T, E extends Exception> {
  const Result._();

  const factory Result.success(T data) = _SuccessResult<T, E>;

  const factory Result.failure(E exception) = _FailureResult<T, E>;

  T get data => (this as _SuccessResult).data as T;

  E get exception => (this as _FailureResult).exception as E;

  bool get isSuccess => this is _SuccessResult;

  bool get isFailure => this is _FailureResult;
}

class _SuccessResult<T, E extends Exception> extends Result<T, E> {
  const _SuccessResult(this.data) : super._();

  @override
  final T data;
}

class _FailureResult<T, E extends Exception> extends Result<T, E> {
  const _FailureResult(this.exception) : super._();

  @override
  final E exception;
}
