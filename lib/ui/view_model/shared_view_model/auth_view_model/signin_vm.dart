import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_flutter_football/data/repository/user_repository.dart';
import 'package:project_flutter_football/models/auth/signin_model.dart';
import 'package:project_flutter_football/models/auth/token_model.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:project_flutter_football/utils/sesssion_managements.dart';
import 'package:project_flutter_football/utils/ui_state.dart';

class SignInVM with ChangeNotifier {
  TokenModel? token;
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var session = SesssionManagements();

  var isLoading = false;

  UiState uiState = IdealState();

  submitLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future<UiState?> signInController() async {
    try {
      await for (var event in authentication(SignInModel(
          email: userNameController.text, password: passwordController.text))) {
        if (event is SuccessEvent<TokenModel>) {
          token = event.data;
          await session.putToken(event.data);
          return NavigationState(navigationCallback: () {}, route: "/dashboard");
        } else if (event is ErrorEvent<TokenModel>) {
          return ErrorState(error: event.error, onDismis: () {});
        } else if (event is LoadingEvent<TokenModel>) {
          submitLoading(true);
        } else {
          print("Same things went wrong");
        }
      }
    } catch (e) {
      // submitState(ErrorState(
      //     error: e.toString(),
      //     onDismis: () {
      //       submitState(IdealState());
      //     }));
    } finally {
      submitLoading(false);
    }
    return null;
  }
}
