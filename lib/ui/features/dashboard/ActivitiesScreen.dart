import 'package:flutter/material.dart';
import 'package:go_provider/go_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:project_flutter_football/main.dart';
import 'package:project_flutter_football/models/fucking_match_model/MatchItemModel.dart';
import 'package:project_flutter_football/models/user/user_model.dart';
import 'package:project_flutter_football/ui/features/match/MatchComponent.dart';
import 'package:project_flutter_football/ui/view_model/dashboard_view_model/activites/ActivitesViewModel.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/dashboard_view_model/scaffold_dashbaord_vm.dart';
import 'package:provider/provider.dart';


class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
   User? user;


  @override
  Widget build(BuildContext context) {
    final activitiesList = context.watch<ActivitiesViewModel>().matchItemActivitiesList?.map((e) => fromMatchItemActivitiesToMachUiRe(context, e)).toList(growable: false);
    user = context.read<DashboardScaffoldViewModel>().user!;
    return Scaffold(
      appBar: AppBar(

        title: const Text("Activities"),
        actions: [
          IconButton(onPressed: () {
          }, icon: const Icon(Icons.dialpad_outlined))
        ],


      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        context.pushNamed("match-add");
      },
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        child: Icon(Icons.add, color:  Theme.of(context).colorScheme.tertiary),),
      body:
         (activitiesList != null) ? ListView.builder(padding: const EdgeInsets.only(left: 8, right: 8),itemBuilder: (context, index) => MatchComponent(uiRepresentation: activitiesList[index]), itemCount: activitiesList.length,) : const Center(child: CircularProgressIndicator(),)
      ,
    );
  }
  MatchUIRepresentation fromMatchItemActivitiesToMachUiRe(BuildContext context, MatchItemActivities model) {
    return MatchUIRepresentation(date: model.date.toString(), labelOfTerrain: model.terrain.label, isMine: user?.isOwnResource(model.user.id)?? false , playersCount: model.playersOfMatch.length, price: model.terrain.price, onClick: (){
      context.pushNamed("match-details", extra: model.id);
    });
  }
}






