import 'package:flutter/material.dart';
import 'package:project_flutter_football/data/repository/user_repository.dart';
import 'package:project_flutter_football/models/auth/signin_model.dart';
import 'package:project_flutter_football/models/auth/signup_model.dart';
import 'package:project_flutter_football/models/auth/token_model.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:project_flutter_football/utils/sesssion_managements.dart';
import 'package:project_flutter_football/utils/ui_state.dart';

class SignUpVM with ChangeNotifier {
  var fullNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var codeOTP = TextEditingController();
  final List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());
  final formKey = GlobalKey<FormState>(); // To validate the form
  var isLoadingState = false;
  var currentPage = 1;




  submitLoading(bool value) {
    isLoadingState = value;
    notifyListeners();
  }

  _submitPageIsFirstPage(bool firstPage)  {
    if(firstPage) {
      currentPage = 1;
    } else {
      currentPage = 2;
    }
    notifyListeners();
  }


  Future<UiState?> submitFormFirstPage() async {
    if(formKey.currentState?.validate() ?? false) {
      var names = fullNameController.value.text.split(" ");
        try {
          await for (var event in signup(
              UserSignUpModel(name: names.first, lastName: (names.length > 2) ? names.sublist(1).join(""): null,
              email: emailController.text, password: passwordController.text, phone: phoneNumberController.text, role: "user"))

          ) {
            if (event is SuccessEvent<TokenModel>) {
              SesssionManagements().putToken(event.data);
              _submitPageIsFirstPage(false);
            } else if (event is ErrorEvent<TokenModel>) {

              return ErrorState(error: event.error, onDismis: (){});

            } else if (event is LoadingEvent<TokenModel>) {
              submitLoading(true);
            } else {
              print("Same things went wrong");

            }
          }
        } catch (e) {

          return ErrorState(error: "unexpected error just happened", onDismis: (){});

        }finally {
          submitLoading(false);
        }
    }else{
      print("form is not valid");
    }
    return null;
  }


  Future<UiState?> sendOTP() async {
    try {
      await for (var event in submitOTACode(SendOTP(email: emailController.text))) {
        if (event is SuccessEvent<Message>) {

        } else if (event is ErrorEvent<Message>) {

          return ErrorState(error: event.error, onDismis: (){});

        } else if (event is LoadingEvent<Message>) {
          submitLoading(true);
        } else {
          print("Same things went wrong");
        }
      }
    } catch (e) {
      return ErrorState(error: "unexpected error just happened", onDismis: (){});
    }finally {
      submitLoading(false);
    }
    return null;
  }


  Future<UiState?> verifyOTPCode() async {
    if(controllers.any((e) => e.text.isEmpty)) {
     return ErrorState(error: "You have to complete the code in order to submit it", onDismis: () {});
    }
    final code = controllers.map((e) => e.text).join();
    try {
      await for (var event in verifyOTACode(VerifyOTA(code: code, email: emailController.text))) {
        if (event is SuccessEvent<Message>) {
          return NavigationState(navigationCallback: () {}, route: "/dashboard");
        } else if (event is ErrorEvent<Message>) {

          return ErrorState(error: event.error, onDismis: (){});

        } else if (event is LoadingEvent<Message>) {
          submitLoading(true);
        } else {
          print("Same things went wrong");
        }
      }
    } catch (e) {
      return ErrorState(error: "unexpected error just happened", onDismis: (){});
    }finally {
      submitLoading(false);
    }
    return null;
  }






 @override
  void dispose() {
   fullNameController.dispose();
   phoneNumberController.dispose();
   passwordController.dispose();
   emailController.dispose();
   codeOTP.dispose();
    super.dispose();
  }

  // Future<UiState> signUpController() async {
  //
  // }
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
