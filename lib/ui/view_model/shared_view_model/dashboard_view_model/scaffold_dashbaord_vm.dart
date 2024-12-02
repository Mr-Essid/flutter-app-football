import 'package:flutter/material.dart';
import 'package:project_flutter_football/data/repository/user_repository.dart';
import 'package:project_flutter_football/models/user/user_model.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:project_flutter_football/utils/sesssion_managements.dart';
import 'package:project_flutter_football/utils/ui_state.dart';

class DashboardScaffoldViewModel with ChangeNotifier {
  User? user;
  var session = SesssionManagements();

  UiState uiState = IdealState();

  DashboardScaffoldViewModel() {
    loadCurrentUserVM();
  }

  submitState(UiState state) {
    uiState = state;
    notifyListeners();
  }

  loadCurrentUserVM() async {
    try {
      final token = await session.getToken();

      await for (var event in currentUser(token ?? "not authenticated")) {
        if (event is SuccessEvent<User>) {
          user = event.data;
          print(user!.email ?? "noemail");
          notifyListeners();
          print("we got data successfully");
        } else if (event is ErrorEvent<User>) {
          submitState(ErrorState(
              error: event.error,
              onDismis: () {
                submitState(IdealState());
              }));
        } else if (event is LoadinEvent<User>) {
          submitState(LoadingState());
        } else {}
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
