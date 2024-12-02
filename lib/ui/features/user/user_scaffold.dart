import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_flutter_football/main.dart';
import 'package:project_flutter_football/ui/features/support_ui_status.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/dashboard_view_model/scaffold_dashbaord_vm.dart';
import 'package:project_flutter_football/utils/ui_state.dart';
import 'package:provider/provider.dart';

class UserScaffold extends StatefulWidget {
  const UserScaffold({Key? key}) : super(key: key);

  @override
  _UserScaffoldState createState() => _UserScaffoldState();
}

class _UserScaffoldState extends State<UserScaffold> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardScaffoldViewModel(),
      child: Scaffold(
        body: Builder(builder: (context) {
          return Consumer<DashboardScaffoldViewModel>(
              builder: (condext, viewModel, _) {
            if (viewModel.uiState is NavigationState) {
              String route = (viewModel.uiState as NavigationState).route;
              (viewModel.uiState as NavigationState).navigationCallback();
              condext.go(route);
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (viewModel.user != null)
                    Text("Welcome ${viewModel.user!.name}")
                ],
              ),
            );
          });
        }),
      ),
    );
  }
}
