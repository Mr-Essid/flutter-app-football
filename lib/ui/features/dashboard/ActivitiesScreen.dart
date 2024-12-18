import 'package:flutter/material.dart';
import 'package:go_provider/go_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:project_flutter_football/main.dart';
import 'package:project_flutter_football/models/MatchRequestReponseModel.dart';
import 'package:project_flutter_football/models/fucking_match_model/MatchItemModel.dart';
import 'package:project_flutter_football/models/user/user_model.dart';
import 'package:project_flutter_football/ui/features/match/MatchComponent.dart';
import 'package:project_flutter_football/ui/view_model/JoinMatchViewModel.dart';
import 'package:project_flutter_football/ui/view_model/dashboard_view_model/activites/ActivitesViewModel.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/dashboard_view_model/scaffold_dashbaord_vm.dart';
import 'package:project_flutter_football/utils/ui_state.dart';
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
          IconButton(onPressed: () async {
            await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => ChangeNotifierProvider(
              create: (_) => JoinMatchViewModel(),
              child: Center(
                  child: Consumer<JoinMatchViewModel>(
                    builder: (BuildContext context, value, Widget? child) {
                      final currentState = value.matchRequestResponseModel;
                      return AlertDialog(
                        actions: [
                          if(currentState is ErrorState<MatchRequestResponseModel> || currentState is SuccessState<MatchRequestResponseModel>)
                          TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text("ok")
                          ),
                          if(currentState is ErrorState<MatchRequestResponseModel>)
                            TextButton(
                                onPressed: () {
                                  currentState.onDismis();
                                },
                                child: const Text("retry")
                            ),
                          if(currentState is IdealState<MatchRequestResponseModel>)
                            ...[
                              TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: const Text("cancel")
                              ),
                              TextButton(
                                  onPressed: () {
                                    value.requestJoinMatchX();
                                  },
                                  child: Text("submit", style: TextStyle(color: Theme.of(context).colorScheme.tertiary))
                              ),
                              ],
                        ],
                        title: (currentState is ErrorState<MatchRequestResponseModel>) ? const  Text("Error", ) : (currentState is SuccessState<MatchRequestResponseModel>) ? const Text("Success"): null,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            if(currentState is LoadingState<MatchRequestResponseModel>)
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                            if(currentState is ErrorState<MatchRequestResponseModel>)
                            Text(currentState.error, style: Theme.of(context).textTheme.titleMedium),
                            if(currentState is SuccessState<MatchRequestResponseModel>)
                              Text(currentState.message, style: Theme.of(context).textTheme.titleMedium),
                            if(currentState is IdealState<MatchRequestResponseModel>)
                              ...[
                                 Row(
                                  children: [
                                    Text("Join With Id", style: Theme.of(context).textTheme.titleMedium,)
                                  ],
                                ),
                                const SizedBox(height: 8,),
                                Form(
                                  key:value.keyForm,
                                  child: TextFormField(
                                    validator: (value) {
                                      if(RegExp(r"^[a-zA-Z0-9]{24}$").hasMatch(value ?? "")) {
                                        return null;
                                      }
                                      return  "id constitute 24 alphanum characters";
                                    },

                                  decoration: InputDecoration(
                                    errorStyle: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.redAccent) ,
                                    hintText: "match id",
                                    hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.grey),
                                  ),
                                  controller: value.controller,
                                    style: Theme.of(context).textTheme.labelLarge,
                                    autocorrect: false,
                                ))
                              ],
                          ],
                        ),
                      );
                    },
                  )),
            ));

          }, icon: const Icon(Icons.password)
          )
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
    return MatchUIRepresentation(model.id, date: model.date.toString(), labelOfTerrain: model.terrain.label, isMine: user?.isOwnResource(model.user.id)?? false , playersCount: model.playersOfMatch.length, price: model.terrain.price, onClick: (){
      context.pushNamed("match-details", extra: model.id);
    });
  }
}

class MatchComponentViewModel extends ChangeNotifier {

  int counter =0;

  increment() {
    counter++;
    notifyListeners();
  }


  decrement() {
    counter--;
    notifyListeners();
  }



  MatchComponentViewModel() {
    print("Match Component Created");
  }

  @override
  void dispose() {
    print("Match Component Disposed");
    super.dispose();
  }


}





