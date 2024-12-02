import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_flutter_football/ui/features/auth/signin_screen.dart';
import 'package:project_flutter_football/ui/features/user/user_scaffold.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/dashboard_view_model/scaffold_dashbaord_vm.dart';

final GoRouter routerConfig = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return SigninScreen();
      }),
  GoRoute(
      path: '/dashboard',
      name: "dashboard",
      builder: (BuildContext context, GoRouterState state) {
        return UserScaffold();
      })
]);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routerConfig,
    );
  }
}
