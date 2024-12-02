import 'package:flutter/material.dart';
import 'package:project_flutter_football/data/repository/user_repository.dart';
import 'package:project_flutter_football/models/auth/signin_model.dart';
import 'package:project_flutter_football/models/auth/token_model.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:project_flutter_football/utils/ui_state.dart';

class SignUpVM with ChangeNotifier {
  var fullNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  UiState uiState = IdealState();

  submitState(UiState state) {
    uiState = state;
    notifyListeners();
  }

  // signInController() async {
  //   try {
  //     await for (var event in authentication(SignInModel(
  //         email: fullNameController.text, password: passwordController.text))) {
  //       if (event is SuccessEvent<TokenModel>) {
  //         print("Successfully logged in");
  //         token = event.data;
  //         submitState(SuccessState(
  //             message: "we have god data",
  //             onDismis: () {
  //               submitState(IdealState());
  //             }));
  //       } else if (event is ErrorEvent<TokenModel>) {
  //         print("Error occurred during sign-in");
  //         print(event.error);
  //         submitState(ErrorState(
  //             error: event.error,
  //             onDismis: () {
  //               submitState(IdealState());
  //             }));
  //       } else if (event is LoadinEvent<TokenModel>) {
  //         submitState(LoadingState());
  //       } else {
  //         print("Same things went wrong");
  //       }
  //     }
  //   } catch (e) {
  //     submitState(ErrorState(
  //         error: e.toString(),
  //         onDismis: () {
  //           submitState(IdealState());
  //         }));
  //   }
  // }
}
