import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_flutter_football/constaints.dart';
import 'package:project_flutter_football/main.dart';
import 'package:project_flutter_football/models/RefuseRequestModel.dart';
import 'package:project_flutter_football/models/fucking_match_model/MatchItemModel.dart';
import 'package:project_flutter_football/ui/features/match/AcceptUserMatch.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/MatchDetailsViewModel.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/dashboard_view_model/scaffold_dashbaord_vm.dart';
import 'package:project_flutter_football/utils/ui_state.dart';
import 'package:provider/provider.dart';

class MatchScreen extends StatelessWidget {

  const MatchScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final matchModel = context.watch<MatchDetailsViewModel>().matchItemActivities;
    final listOfPlayers = context.watch<MatchDetailsViewModel>().listPlayerItem;
    final matchLoadState = context.read<MatchDetailsViewModel>().uiStateMatchItem;
    final user = context.read<DashboardScaffoldViewModel>().user!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Match"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {},
          ),
        ],
      ),
      body:(matchModel != null) ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(!(user.isOwnResource(matchModel.user.id) || user.isManager() || matchModel.playersOfMatch.any((e) => e.user.id == user.id)))
              Column(
               children: [
                 const Text("Status", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                 const SizedBox(height: 4,),
                 TextButton(onPressed: () async {
                   final response = await Provider.of<MatchDetailsViewModel>(context, listen: false).requestJoinMatchX(matchModel.id);

                   if(response is ErrorState<PlayerMatchItem>) {
                     if (context.mounted) {
                       await showDialog(
                           context: context,
                           barrierDismissible: false,
                           builder: (context) => Center(
                               child: AlertDialog(
                                 actions: [
                                   TextButton(
                                       onPressed: () {
                                         response.onDismis();
                                         context.pop();
                                       },
                                       child: const Text("OK"))
                                 ],
                                 title: const Text("Error"),
                                 content: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   children: [Text(response.error)],
                                 ),
                               )));
                     }
                   }

                   if(response is SuccessState<PlayerMatchItem>) {
                     if (context.mounted) {
                       await showDialog(
                           context: context,
                           barrierDismissible: false,
                           builder: (context) => Center(
                               child: AlertDialog(
                                 actions: [
                                   TextButton(
                                       onPressed: () {
                                         response.onDismis();
                                         context.pop();
                                       },
                                       child: const Text("OK"))
                                 ],
                                 title: const Text("Success Status"),
                                 content: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   children: [Text(response.message)],
                                 ),
                               )));
                     }
                   }

                 }, child: const Text("join request", style: TextStyle(color: Colors.deepPurpleAccent),),
                 )
               ], 
              ),
              Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                const Icon(Icons.share, size: 16, color: Colors.grey,),
                 const SizedBox(width: 4,),
                 const Icon(Icons.copy, size: 16, color: Colors.grey,),
                 const SizedBox(width: 4,),
                 Text("Id: ${matchModel.id}", style: const TextStyle(color: Colors.grey),) // id
               ],
             ),
            const SizedBox(height: 32,),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: _BuildItem("Time",parseDate(matchModel.date.toIso8601String())['time'] ?? "unspecified", Icons.access_time),
                    ),
        
                    Expanded(
                        child:
                        _BuildItem("Date",parseDate(matchModel.date.toIso8601String())['date'] ?? "unspecified", Icons.calendar_today),
                    )
        
                  ],
                ),
                const SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: _BuildItem("Price","${matchModel.terrain.price}\$", Icons.attach_money)),
                    Expanded(child: _BuildItem("Place",matchModel.terrain.label, Icons.location_on_outlined))
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32,),
            Column(children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Members", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 8,),
                        const Text("Creator", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 4,),
                        _PersonMatch(matchModel.user.name.capitalize(), matchModel.user.id, true, () {}, () {}, isShowSuggestions: false),
                        const SizedBox(height: 16,),
                        const Text("Members", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                        if(listOfPlayers != null)
                        ...(listOfPlayers.map((e) {
                          return _PersonMatch(e.user.name.capitalize(), e.user.id, e.isAccepted, () async {
                             final response = await  Provider.of<MatchDetailsViewModel>(context, listen: false).acceptUserX(e.id);
                             if(response is ErrorState<MatchParticipant>) {
                               if (context.mounted) {
                                 await showDialog(
                                     context: context,
                                     barrierDismissible: false,
                                     builder: (context) => Center(
                                         child: AlertDialog(
                                           actions: [
                                             TextButton(
                                                 onPressed: () {
                                                   response.onDismis();
                                                   context.pop();
                                                 },
                                                 child: const Text("OK"))
                                           ],
                                           title: const Text("Error"),
                                           content: Column(
                                             mainAxisSize: MainAxisSize.min,
                                             children: [Text(response.error)],
                                           ),
                                         )));
                               }
                             }

                             if(response is SuccessState<MatchParticipant>) {
                               if (context.mounted) {
                                 await showDialog(
                                     context: context,
                                     barrierDismissible: false,
                                     builder: (context) => Center(
                                         child: AlertDialog(
                                           actions: [
                                             TextButton(
                                                 onPressed: () {
                                                   response.onDismis();
                                                   context.pop();
                                                 },
                                                 child: const Text("OK"))
                                           ],
                                           title: const Text("Success Status"),
                                           content: Column(
                                             mainAxisSize: MainAxisSize.min,
                                             children: [Text(response.message)],
                                           ),
                                         )));
                               }
                             }

                          }, () async {
                            final response = await  Provider.of<MatchDetailsViewModel>(context, listen: false).refuseRequest(e.id);
                            if(response is ErrorState<RefuseModel>) {
                              if (context.mounted) {
                                await showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => Center(
                                        child: AlertDialog(
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  response.onDismis();
                                                  context.pop();
                                                },
                                                child: const Text("OK"))
                                          ],
                                          title: const Text("Error"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [Text(response.error)],
                                          ),
                                        )));
                              }
                            }

                            if(response is SuccessState<RefuseModel>) {
                              if (context.mounted) {
                                await showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => Center(
                                        child: AlertDialog(
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  response.onDismis();
                                                  context.pop();
                                                },
                                                child: const Text("OK"))
                                          ],
                                          title: const Text("Success Status"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [Text(response.message)],
                                          ),
                                        )));
                              }
                            }
                          }, isShowSuggestions: user.isOwnResource(matchModel.user.id) );
                        }).toList(growable: false))
                        else
                         const Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 SizedBox(height: 8,),
                                 Text("No Members Available Right Now", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                               ],
                             ),

                           ]
                         )
        
                      ],
                    ),
                  )
                  ],
                )
              ],)
            ],)
          ),
      ) : const Center(child: CircularProgressIndicator(),),
      );
  }
}

Widget _BuildItem(String label, String value, IconData icon) {
 return Row(
   mainAxisAlignment: MainAxisAlignment.center,
   mainAxisSize: MainAxisSize.max,
   children: [
     
     Column(
       children: [
         Icon(icon),
         const SizedBox(height: 4),
         Text(label.capitalize(), style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
         const SizedBox(height: 4),
         Text(value.capitalize(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
       ],
     ),
   ],
 );

}

Widget _PersonMatch(String name, String id, bool isAccepted, Function() onAccept, Function() onRefuse, {bool isShowSuggestions = false}) {
  return Card.outlined(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style:const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                      "id: $id",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  )
                ],
              ),
              if(!isAccepted && isShowSuggestions)
              Row(children: [
                IconButton(onPressed: onAccept, icon: const Icon(Icons.check),),
                IconButton(onPressed: () {}, icon: const Icon(Icons.clear))
              ],)
              else if(isAccepted)
                Icon(Icons.check)
              else
                Icon(Icons.access_time)
            ],
      ),
    ),
  );
}




void main() {
  // runApp(
  //   MaterialApp(
  //     home: MatchScreen(
  //       matchId: "12345",
  //       matchDetails: const {
  //         'date': "2024-12-11",
  //         'time': "19:17",
  //         'price': "50",
  //         'members': 5,
  //         'players': [
  //           {'name': "John Doe", 'id': "1"},
  //           {'name': "Jane Smith", 'id': "2"},
  //         ],
  //       },
  //       onJoinMatch: () => print("Joining Match"),
  //       onNavigateToMap: () => print("Navigating to Map"),
  //     ),
  //   ),
  // );
}
