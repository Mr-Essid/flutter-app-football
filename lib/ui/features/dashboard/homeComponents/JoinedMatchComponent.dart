import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_flutter_football/models/RefuseRequestModel.dart';
import 'package:project_flutter_football/ui/view_model/dashboard_view_model/activites/HomeViewModel.dart';
import 'package:project_flutter_football/utils/ui_state.dart';
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
    return (listOfData != null) ? ListView.builder(itemBuilder: (context, index) {
        bool isDismissed = false;

         return Dismissible(
           onDismissed: (direction) async {
             final response = await Provider.of<HomeViewModel>(context, listen: false).cancelRequestX(listOfData[index].id);
             print(response.runtimeType);
             if(response is ErrorState<RefuseModel>) {
               if(context.mounted) {
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
                           title: const Text("Error"),
                           content: Column(
                             mainAxisSize: MainAxisSize.min,
                             children: [Text(response.error)],
                           ),
                         )));
               }
             }
             else if(response == null) {
               if(context.mounted) {
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
                           title: const Text("Error"),
                           content: const Column(
                             mainAxisSize: MainAxisSize.min,
                             children: [Text("Sorry Same things went wrong")],
                           ),
                         )));
               }
             }
           },
             onUpdate: (dismissDetails) {
              if(dismissDetails.progress == 1.0)  {
                isDismissed = true;
              }
             },
           confirmDismiss: (direction) async {
            await Future.delayed(const Duration(seconds: 2));
            return isDismissed;
           },
            background:  Card(
              color: Colors.redAccent.withAlpha(100),
              child:  Align(
                alignment: Alignment.centerRight ,
                child: TextButton(onPressed: () {
                  isDismissed = false;
                } , child: const Text("UNDO", style: TextStyle(color: Colors.white),),) ,
              ),
            ),
            direction: (listOfData[index].isAccepted == true)? DismissDirection.none: DismissDirection.endToStart,
             dismissThresholds: const {
              DismissDirection.endToStart: 0.7
             },
             key: Key(index.toString()),
             child: JoinedMatchComponentCard(joinedMatchModel: listOfData[index])

         );
         },
          itemCount: listOfData.length,) : const Center(child: CircularProgressIndicator());
  }
}
