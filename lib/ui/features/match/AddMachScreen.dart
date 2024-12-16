import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:project_flutter_football/constaints.dart';
import 'package:project_flutter_football/main.dart';
import 'package:project_flutter_football/models/fucking_match_model/MatchItemModel.dart';
import 'package:project_flutter_football/models/fucking_match_model/OwnMatch.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/AddMatchViewModel.dart';
import 'package:project_flutter_football/utils/LatLngWapper.dart';
import 'package:project_flutter_football/utils/ui_state.dart';
import 'package:project_flutter_football/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../models/terrain/TerrainModel.dart';

class AddMatchScreen extends StatefulWidget {
  @override
  _AddMatchScreenState createState() => _AddMatchScreenState();
}

class _AddMatchScreenState extends State<AddMatchScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   final listOfTerrains = context.watch<AddMatchViewModel>().terrains;
   var selectedIndex = context.watch<AddMatchViewModel>().selectedIndex;
   final currentDate = context.watch<AddMatchViewModel>().dateOfMatch;
   final currentTime = context.watch<AddMatchViewModel>().timeOfDay;
   final isLoading = context.watch<AddMatchViewModel>().isAddMatchInProgress;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Match"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          if(!isLoading)
          IconButton(
            onPressed: () async {
              final event = await Provider.of<AddMatchViewModel>(context, listen: false).createMatch();

              if(event is ErrorState<MatchItemActivities>) {
                if (context.mounted) {
                  await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => Center(
                          child: AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    event.onDismis();
                                    context.pop();
                                  },
                                  child: const Text("OK"))
                            ],
                            title: const Text("Error"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [Text(event.error)],
                            ),
                          )));
                }
              }
              if(event is SuccessState<MatchItemActivities>) {
                if (context.mounted) {
                  await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => Center(
                          child: AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    event.onDismis();
                                    context.pop();
                                  },
                                  child: const Text("OK"))
                            ],
                            title: const Text("Success Status"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [Text(event.message)],
                            ),
                          )));
                }
              }

            },
            icon: const Icon(Icons.check),
          )
         else
          const SizedBox(
            width: 20,
            height: 20,
            child:  Center(child:
              CircularProgressIndicator(),
            ),
          )
          ,
          IconButton(
            onPressed: () async {
              final listOfLatLong = listOfTerrains?.map((e) => LatLongWapper(latitude: e.latitude, longitude:  e.longitude, id_: e.id)).toList(growable: false);
              // listOfLatLong null only when the listOfTerrains not returned at all
              if(listOfLatLong != null) {
                 final id_ = await context.pushNamed<String>("terrainMaps", extra: listOfLatLong);
                  if (kDebugMode) {
                    print("We've got id $id_");
                  }
                  if(id_ != null) {
                    if(context.mounted) {
                      Provider.of<AddMatchViewModel>(context, listen: false).updateSelectedIndex(listOfTerrains?.indexWhere((e) => e.id == id_) ?? 0);
                    }
                  }
              }
            },
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Date"),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      final dateTime = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 30)));
                      if(context.mounted && dateTime != null) {
                        Provider.of<AddMatchViewModel>(context, listen: false).updateDate(dateTime);
                      }
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
                  Text(
                      (currentDate != null)? currentDate.toString().split(" ").first : "Select a Day"
                  )
                ],
              ),
              const SizedBox(height: 16),
              const Text("Time"),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      final selectedTime = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      if(context.mounted && selectedTime != null) {
                        Provider.of<AddMatchViewModel>(context, listen: false).updateTime(selectedTime);
                      }
                    },

                    icon: const Icon(Icons.access_time),
                  ),
                  Text(
                      (currentTime != null)? "${currentTime.hour}:${currentTime.minute}" : "Select a time"
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "Soccer Fields Exist",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              if(listOfTerrains != null)
                  for(int i = 0; i < listOfTerrains.length; i++)
                    TerrainCard(
                      terrainModel: listOfTerrains[i].toTerrainMachItem(i),
                      isSelected: selectedIndex == i, onTap: () {
                      Provider.of<AddMatchViewModel>(context, listen: false).updateSelectedIndex(i);
                    },
                      onLocationClick: () {},
                        onSelectionChange: (bool? isSelected) { Provider.of<AddMatchViewModel>(context, listen: false).updateSelectedIndex(i);
                      }
                      ,)
              else
                const Center(child: CircularProgressIndicator(),)
            ],
          ),
        ),
      ),
    );
  }
}

class TerrainCard extends StatelessWidget {
  final TerrainMachItem terrainModel;
  final bool isSelected;
  final Function(bool?) onSelectionChange;
  final VoidCallback onTap;
  final VoidCallback onLocationClick;

  TerrainCard({
    required this.terrainModel,
    required this.isSelected,
    required this.onTap,
    required this.onLocationClick,
    required this.onSelectionChange,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(

      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Checkbox(
          value:  isSelected,
          onChanged: onSelectionChange ,
        ),
        title: Text(terrainModel.label.capitalize()),
        subtitle: Text("${terrainModel.price.capitalize()}\$ Match"),
        trailing: IconButton(onPressed: (){
        },
          icon: const Icon(  Icons.location_on)
        ),
        onTap: onTap,
        selected: isSelected,
      ),
    );
  }
}
