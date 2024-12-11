sealed class Events<T> {
}

class SuccessEvent<T> extends Events<T> {
  T data;
  String? message;
  SuccessEvent({required this.data, this.message});
}

class ErrorEvent<T> extends Events<T> {
  late String error;
  late int? statusCode;
  ErrorEvent({required this.error, this.statusCode});
}

class LoadingEvent<T> extends Events<T> {}
