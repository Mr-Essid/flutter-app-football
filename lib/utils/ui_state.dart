import 'package:flutter/material.dart';

sealed class UiState<T> {
}

class LoadingState<T> extends UiState<T> {}

class IdealState<T> extends UiState<T> {}

class ErrorState<T> extends UiState<T> {
  String error;
  Function() onDismis;
  ErrorState({required this.error, required this.onDismis});
}

class SuccessState<T> extends UiState<T> {
  String message;
  Function() onDismis;
  SuccessState({required this.message, required this.onDismis});
}

class NavigationState extends UiState {
  Function() navigationCallback;
  String route;
  NavigationState({required this.navigationCallback, required this.route});
}
