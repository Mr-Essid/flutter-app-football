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

  UiState uiState = IdealState();

  submitState(UiState state) {
    uiState = state;
    notifyListeners();
  }

  Stream<UiState> signInController() async* {
    try {
      await for (var event in authentication(SignInModel(
          email: userNameController.text, password: passwordController.text))) {
        if (event is SuccessEvent<TokenModel>) {
          print("Successfully logged in");
          token = event.data;
          await session.putToken(event.data);
          yield NavigationState(navigationCallback: () {}, route: "/dashboard");
        } else if (event is ErrorEvent<TokenModel>) {
          print("Error occurred during sign-in");
          yield ErrorState(
              error: "we have Sucessfully go",
              onDismis: () {
                submitState(IdealState());
              });
        } else if (event is LoadinEvent<TokenModel>) {
          // yield LoadingState();
        } else {
          print("Same things went wrong");
        }
      }
    } catch (e) {
      submitState(ErrorState(
          error: e.toString(),
          onDismis: () {
            submitState(IdealState());
          }));
    }
  }
}
