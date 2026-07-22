/// Result class
///
/// Represents the result with several conditions:
/// [Result.ok] -> use when success getting data (Api, local storage, etc)
/// [Result.error] -> use when error getting data
/// [Result.loading] -> use when loading (between fetching data)
library;

sealed class Result<T, E> {
  const Result();
  const factory Result.ok(T data, String message) = Success._;
  const factory Result.error(E error, String message) = Error._;
  const factory Result.loading() = Loading._;
}

class Success<T, E> extends Result<T, E> {
  const Success._(this.data, this.message);

  final T data;
  final String message;
}

class Error<T, E> extends Result<T, E> {
  const Error._(this.error, this.message);

  final E error;
  final String message;
}

class Loading<T, E> extends Result<T, E> {
  const Loading._();
}