import 'package:flutter/material.dart';
import 'package:project_flutter_football/main.dart';
import 'package:project_flutter_football/models/match_model.dart';
import 'package:project_flutter_football/ui/features/match/MatchComponent.dart';
import 'package:project_flutter_football/ui/view_model/user_view_model/ActivitesViewModel.dart';
import 'package:project_flutter_football/utils/RenderListComponents.dart';
import 'package:project_flutter_football/utils/ui_state.dart';
import 'package:provider/provider.dart';


class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    final uiState = context.watch<ActivitiesViewModel>().matchesState;
    final matches = context.watch<ActivitiesViewModel>().matches;
    return Scaffold(
      appBar: AppBar(title: const Text("Activities"),),
      body: SizedBox(),
    );
  }
}






