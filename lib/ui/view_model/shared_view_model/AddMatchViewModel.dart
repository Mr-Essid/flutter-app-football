import 'package:flutter/material.dart';
import 'package:project_flutter_football/data/repository/match_repository.dart';
import 'package:project_flutter_football/models/fucking_match_model/AddMatchModel.dart';
import 'package:project_flutter_football/models/fucking_match_model/MatchItemModel.dart';
import 'package:project_flutter_football/models/terrain/TerrainModel.dart';
import 'package:project_flutter_football/utils/ui_state.dart';

import '../../../utils/events.dart';

class AddMatchViewModel extends ChangeNotifier {
  DateTime? dateOfMatch;
  TimeOfDay? timeOfDay;
  List<TerrainModel>? terrains;
  UiState<TerrainModel> terrainState = IdealState<TerrainModel>();
  int selectedIndex = -1;
  UiState<MatchItemActivities> matchItemState = IdealState();
  bool isAddMatchInProgress = false;



  updateSelectedIndex(int newSelectedIndex)  {
    selectedIndex = newSelectedIndex;
    notifyListeners();
  }




  AddMatchViewModel() {
    loadTerrains();
  }


  updateTime(TimeOfDay? time) {
    timeOfDay = time;
    notifyListeners();
  }

  updateDate(DateTime? date) {
    dateOfMatch = date;
    notifyListeners();
  }


  isLoading(bool isLoading) {
    isAddMatchInProgress = isLoading;
    notifyListeners();
  }



  loadTerrains() async {
    try {
      await for (var event in getTerrains()) {
        if (event is SuccessEvent<List<TerrainModel>>) {
          terrains = event.data;
          notifyListeners();
        } else if (event is ErrorEvent<List<TerrainModel>>) {
          terrainState = ErrorState(error: event.error, onDismis:  (){terrainState = IdealState();});
          notifyListeners();

        } else if (event is LoadingEvent<List<TerrainModel>>) {
          terrainState = LoadingState();
          notifyListeners();
        } else {}
      }
    } catch (e) {
      terrainState = ErrorState(error: e.runtimeType.toString(), onDismis:  (){terrainState = IdealState();});
      rethrow;
    }
  }


  submitUiStateAddMatch(UiState<MatchItemActivities> uiState) {
    matchItemState = uiState;
    notifyListeners();
  }

  Future<UiState<MatchItemActivities>?> createMatch() async {
    isLoading(true);
    if(selectedIndex == -1) {
      isLoading(false);
      return ErrorState<MatchItemActivities>(error: "You Haven't Select Terrain", onDismis: () {submitUiStateAddMatch(IdealState());});
    }
   if(terrains?[selectedIndex] == null) {
     isLoading(false);
    return ErrorState<MatchItemActivities>(error: "You Haven't Select Terrain", onDismis: () {submitUiStateAddMatch(IdealState());});
   }
   if(dateOfMatch == null) {
     isLoading(false);
     return ErrorState<MatchItemActivities>(error: "You Haven't Select The Date", onDismis: () {submitUiStateAddMatch(IdealState());});
   }

   if(timeOfDay == null) {
     isLoading(false);
     return ErrorState<MatchItemActivities>(error: "You Haven't Select The Time", onDismis: () {submitUiStateAddMatch(IdealState());});
   }
    try {
      await for (var event in addNewMatch(terrains![selectedIndex].id, dateOfMatch!.add(Duration(hours: timeOfDay!.hour, minutes: timeOfDay!.minute)).toIso8601String())) {
        if (event is SuccessEvent<MatchItemActivities>) {
          updateTime(null);
          updateDate(null);
          updateSelectedIndex(-1);
          isLoading(false);
          return SuccessState<MatchItemActivities>(message: "Match Added With Success State", onDismis: () {submitUiStateAddMatch(IdealState());});
        } else if (event is ErrorEvent<MatchItemActivities>) {
          isLoading(false);
          return ErrorState<MatchItemActivities>(error: event.error, onDismis: () {submitUiStateAddMatch(IdealState());});
        }
      }
    } catch (e) {
        return ErrorState(error: e.runtimeType.toString(), onDismis:  (){terrainState = IdealState();});
    }finally {
     isLoading(false);
    }
  }




}