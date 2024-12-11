import 'package:flutter/material.dart';
import 'package:project_flutter_football/data/repository/user_repository.dart';
import 'package:project_flutter_football/models/user/user_model.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:project_flutter_football/utils/sesssion_managements.dart';
import 'package:project_flutter_football/utils/ui_state.dart';

class DashboardScaffoldViewModel with ChangeNotifier {
  User? user;
  int currentPageIndex = 0;
  PageController pageController = PageController();

  DashboardScaffoldViewModel() {
    loadCurrentUserVM();
  }


  changePage(int pageNumber) {
    currentPageIndex = pageNumber;
    pageController.animateToPage(pageNumber, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    notifyListeners();
  }

  loadCurrentUserVM() async {
    try {
      final token = await SesssionManagements().getToken();

      await for (var event in currentUser(token ?? "not authenticated")) {
        if (event is SuccessEvent<User>) {
          print("we've go the user");
          user = event.data;
          notifyListeners();
        } else if (event is ErrorEvent<User>) {
          print("There is Problem");
        } else if (event is LoadingEvent<User>) {

        } else {}
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
