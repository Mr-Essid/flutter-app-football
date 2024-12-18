import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:project_flutter_football/constaints.dart';
import 'package:project_flutter_football/models/fucking_match_model/OwnMatch.dart';
import 'package:project_flutter_football/ui/features/match/MatchComponent.dart';
import 'package:project_flutter_football/ui/features/shared/ShowlistComponent.dart';
import 'package:project_flutter_football/ui/view_model/dashboard_view_model/activites/HomeViewModel.dart';
import 'package:project_flutter_football/utils/RenderListComponents.dart';
import 'package:provider/provider.dart';


class OwnMatchComponent extends StatefulWidget {
  const OwnMatchComponent({super.key});

  @override
  State<OwnMatchComponent> createState() => _OwnMatchComponentState();
}



class _OwnMatchComponentState extends State<OwnMatchComponent> {
  var _isDragging = false;
  @override
  Widget build(BuildContext context) {
    final List<OwnMatchModel>? listOfOwnMatches = context.watch<HomeViewModel>().ownMatchModels;
    final List<MatchUIRepresentation>? listOfData = listOfOwnMatches?.map(fromOwnMatchModelToUIRepresentation).toList(growable: false);
    return (listOfData != null) ? Stack(
      children:[
        ListView.builder(itemBuilder: (context, index)
      => LongPressDraggable<MatchUIRepresentation>(
        data: listOfData[index],
          onDragCompleted: () {
            print("Drag completed");
          },
          onDragEnd: (_) {
          setState(() {
            _isDragging = false;
          });
            print("Drag ended");

          },
          onDragStarted: () {
          setState(() {
            _isDragging = true;
          });
          },
          feedback:  SizedBox(
            height: 100,
            width: 160,
            child: Card(
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.sports_soccer_outlined),
                  const SizedBox(width: 4,),
                  Text("Match", style: Theme.of(context).textTheme.labelLarge)
                ]
                ),
              ),
            ),
          ),
          child: MatchComponent(uiRepresentation: listOfData[index])),
        itemCount: listOfData.length,),
        if(_isDragging)
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 200,
            height: 120,
            child: DragTarget<MatchUIRepresentation>(
              onAcceptWithDetails: (data) async {
                if(data.data.index == null) {
                  return;
                }
                await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Center(
                    child: AlertDialog(
                      actions: [
                        TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: const Text("OK"))
                      ],
                      title: const Text("Participants"),
                      content: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 300),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...?(
                                  listOfOwnMatches?.firstWhere((e) => e.id == data.data.index).playersOfMatch.map((e) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          leading: const Icon(Icons.person),
                                          title: Text( e.user.name.capitalize()),
                                          subtitle: Text(e.user.email),
                                        ),
                                        const Divider()
                                      ],
                                    );
                                  }
                                  ).toList()
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                )
                );
              },
              builder: (BuildContext context, List<MatchUIRepresentation?> candidateData, List<dynamic> rejectedData) {
               return Card(
                    color: (candidateData.isEmpty)? Colors.white60 : Colors.orangeAccent,
                   child: Padding(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                     child: Center(child: Text("Participants", style: Theme.of(context).textTheme.labelLarge,)),
                   ) ,
                 );
              },
            ),
          ),
        ),
        if(_isDragging)
        Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
            height: 120,
            width: 200,
            child: DragTarget<MatchUIRepresentation>(
              onAcceptWithDetails: (data) async {
                if(data.data.index == null) {
                  return;
                }
                await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => Center(
                        child: AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: const Text("OK"))
                          ],
                          title: const Text("Match Details"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.date_range),
                                title: Text(parseDate(data.data.date)['date'] ?? "unspecified"),
                              ),

                              ListTile(
                                leading: const Icon(Icons.access_time_outlined),
                                title: Text(parseDate(data.data.date)['time'] ?? "unspecified"),
                              ),
                              ListTile(
                                leading: const Icon(Icons.location_on_outlined),
                                title: Text(data.data.labelOfTerrain),
                              ),
                              ListTile(
                                leading: const Icon(Icons.width_normal_outlined),
                                title: Text("Terrain Width: ${listOfOwnMatches?.firstWhere((e) => e.id == data.data.index).terrain.width ?? "unspecified"}m"),
                              ),
                              ListTile(
                                leading: const Icon(Icons.height),
                                title: Text("Terrain Height: ${listOfOwnMatches?.firstWhere((e) => e.id == data.data.index).terrain.height ?? "unspecified"}m"),
                              )
                            ],
                          ),
                        )));
              },
              builder: (BuildContext context, List<MatchUIRepresentation?> candidateData, List<dynamic> rejectedData) {
                return Card(
                  color: (candidateData.isEmpty)? Colors.white60 : Colors.orangeAccent,
                  child: Padding(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Center(child: Text("Match Details", style: Theme.of(context).textTheme.labelLarge,))
                  ) ,
                );
              },
            ),
          ),
        )
      ])

      : const Center(child: CircularProgressIndicator(),
    );
  }


  MatchUIRepresentation fromOwnMatchModelToUIRepresentation(OwnMatchModel model) {
    return MatchUIRepresentation(model.id, date: model.date.toString(), labelOfTerrain: model.terrain.label, isMine: false, playersCount: model.playersOfMatch.length, price: model.terrain.price, onClick: (){});
  }


}
