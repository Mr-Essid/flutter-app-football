import 'package:flutter/material.dart';
import 'package:project_flutter_football/ui/view_model/dashboard_view_model/activites/HomeViewModel.dart';
import 'package:provider/provider.dart';

import '../../match/JoindMatchComponent.dart';



class JoinedMatchComponent extends StatefulWidget {
  const JoinedMatchComponent({super.key});

  @override
  State<JoinedMatchComponent> createState() => _JoinedMatchComponentState();
}

class _JoinedMatchComponentState extends State<JoinedMatchComponent> {

  @override
  Widget build(BuildContext context) {
    final listOfData = context.watch<HomeViewModel>().jointedMachModel;
    return (listOfData != null) ? ListView.builder(itemBuilder: (context, index) => JoinedMatchComponentCard(joinedMatchModel: listOfData[index]), itemCount: listOfData.length,) : const Center(child: CircularProgressIndicator(),);
  }
}
