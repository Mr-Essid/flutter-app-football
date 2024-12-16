import 'package:flutter/material.dart';
import 'package:project_flutter_football/ui/view_model/dashboard_view_model/activites/ActivitesViewModel.dart';
import 'package:project_flutter_football/ui/view_model/dashboard_view_model/activites/HomeViewModel.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/dashboard_view_model/scaffold_dashbaord_vm.dart';
import 'package:provider/provider.dart';

import 'ActivitiesScreen.dart';
import 'HomeScreen.dart';
import 'ProfileScreen.dart';


class DashboardScaffoldScreen extends StatefulWidget {
  const DashboardScaffoldScreen({super.key});

  @override
  State<DashboardScaffoldScreen> createState() => _DashboardScaffoldScreenState();
}

class _DashboardScaffoldScreenState extends State<DashboardScaffoldScreen> {


  PageController pageController = PageController();

  final screens = [
    HomeScreen(),
    ActivitiesScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {

    final user = context.watch<DashboardScaffoldViewModel>().user;
    final currentPage = context.watch<DashboardScaffoldViewModel>().currentPageIndex;
    final viewModel = Provider.of<DashboardScaffoldViewModel>(context, listen: false);

    var currentPageTitle = "";

    if(user != null) {
      switch(currentPage) {
        case 0: {currentPageTitle = "${user.name}'s Board";}
        case 1: {currentPageTitle = "Activities";}
        case 2: {currentPageTitle = "Profile";}
      }
    }
    return (user != null) ? MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => ActivitiesViewModel())

      ],
      child: Scaffold(
        body: PageView(
          controller: viewModel.pageController,
          onPageChanged: (index) {
            viewModel.changePage(index);
          },
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          selectedItemColor: Theme.of(context).colorScheme.tertiary,
          onTap: viewModel.changePage
           , items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home', activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.sports_soccer), label: 'Activities'),
          BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: 'Profile', activeIcon: Icon(Icons.person)),
        ]),
      ),
    ) : Container(color: Colors.white, child: const Center( child:  CircularProgressIndicator()),);
  }
}
