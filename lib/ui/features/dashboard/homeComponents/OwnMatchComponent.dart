import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final List<MatchUIRepresentation>? listOfData = context.watch<HomeViewModel>().ownMatchModels?.map(fromOwnMatchModelToUIRepresentation).toList(growable: false);
    return (listOfData != null) ? ListView.builder(itemBuilder: (context, index) => MatchComponent(uiRepresentation: listOfData[index]), itemCount: listOfData.length,) : const Center(child: CircularProgressIndicator(),);
  }


  MatchUIRepresentation fromOwnMatchModelToUIRepresentation(OwnMatchModel model) {
    return MatchUIRepresentation(date: model.date.toString(), labelOfTerrain: model.terrain.label, isMine: false, playersCount: model.playersOfMatch.length, price: model.terrain.price, onClick: (){});
  }


}
