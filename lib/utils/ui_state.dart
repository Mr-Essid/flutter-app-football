import 'package:flutter/material.dart';

sealed class UiState {}

class LoadingState extends UiState {}

class IdealState extends UiState {}

class ErrorState extends UiState {
  String error;
  Function() onDismis;
  ErrorState({required this.error, required this.onDismis});
}

class SuccessState extends UiState {
  String message;
  Function() onDismis;
  SuccessState({required this.message, required this.onDismis});
}

class NavigationState extends UiState {
  Function() navigationCallback;
  String route;
  NavigationState({required this.navigationCallback, required this.route});
}
