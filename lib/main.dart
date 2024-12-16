import 'package:flutter/material.dart';
import 'package:go_provider/go_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_flutter_football/ui/features/auth/signin_screen.dart';
import 'package:project_flutter_football/ui/features/auth/signup_screen.dart';
import 'package:project_flutter_football/ui/features/dashboard/DashboardScaffold.dart';
import 'package:project_flutter_football/ui/features/match/AddMachScreen.dart';
import 'package:project_flutter_football/ui/features/match/MatchScreen.dart';
import 'package:project_flutter_football/ui/features/match/TerrainMap.dart';
import 'package:project_flutter_football/ui/features/shared/ExampleScreen.dart';
import 'package:project_flutter_football/ui/theme.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/AddMatchViewModel.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/MatchDetailsViewModel.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/auth_view_model/signin_vm.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/auth_view_model/signup_vm.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/dashboard_view_model/scaffold_dashbaord_vm.dart';
import 'package:project_flutter_football/utils/LatLngWapper.dart';
import 'package:provider/provider.dart';
import 'utils/example.dart';

final GoRouter routerConfig = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
          name: "example",
          path: "/example",
          builder: (context, state) {
            final list = state.extra as List<LatLongWapper>?;
            return TerrainMap(listOfLatLong: list ?? List.empty(growable: false));
          }),
      GoRoute(
          name: "terrainMaps",
          path: "/terrainMaps",
          builder: (context, state) {
            final list = state.extra as List<LatLongWapper>?;
            return TerrainMap(listOfLatLong: list ?? List.empty(growable: false));
          }),

      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return ChangeNotifierProvider(
              create: (context) => SignInVM(),
              child: SigninScreen(),
            );
          }),


      GoRoute(
          path: "/signup",
          builder: (context, state) {
            return ChangeNotifierProvider(
                create: (context) => SignUpVM(),
              child: SignupScreen(),
            );
          }
      ),


      // GoProviderRoute(
      //     path: "/user",
      //     builder: (context, state) => const Text("Hello World"),
      //     providers: [
      //       ChangeNotifierProvider(
      //         create: (block) => DashboardScaffoldViewModel(),
      //       )
      //     ],
      //     routes: [
      //       GoRoute(path: "/profile",
      //           builder: (context, state) => ProfileScreen()
      //       ),
      //
      //       GoRoute(path: "/settings",
      //           builder: (context, state) => SettingsScreen()
      //       )
      //     ]
      //
      // ),
      GoProviderRoute(
        providers: [
          ChangeNotifierProvider(create: (_) => DashboardScaffoldViewModel())
        ],
          path: '/dashboard',
          name: "dashboard",
          builder: (context, state) {
            return const DashboardScaffoldScreen();
          },
        routes: [
          GoRoute(
              name: "match-add",
              path: "/match-add",
              builder: (context, state) {
                return ChangeNotifierProvider(create: (_) => AddMatchViewModel(),
                  child: AddMatchScreen()
                  ,);
              }),
          GoRoute(
              name: "match-details",
              path: "/match-details",
              builder: (context, state) {
                String matchId = state.extra as String;
                return ChangeNotifierProvider(
                    create: (_) => MatchDetailsViewModel(matchId),
                    child: const MatchScreen()
                );
              }),

        ]
          )
    ]
);


extension GoRouterExtension on GoRouter{
  void clearStackAndNavigate(String location){
    while(canPop()){
      pop();
    }
    pushReplacement(location);
  }
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: customTheme,
      routerConfig: routerConfig,
    );
  }
}
