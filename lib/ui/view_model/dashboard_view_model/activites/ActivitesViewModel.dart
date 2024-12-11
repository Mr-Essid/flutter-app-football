import 'package:flutter/foundation.dart';
import 'package:project_flutter_football/data/repository/match_repository.dart';
import 'package:project_flutter_football/models/fucking_match_model/MatchItemModel.dart';
import 'package:project_flutter_football/ui/features/dashboard/ActivitiesScreen.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:project_flutter_football/utils/ui_state.dart';

class ActivitiesViewModel extends ChangeNotifier {

  // 1: UI, 2: DataHolders, 3: Data
  //   UI
  //   | bidirectional
  // DataHolders : viewModels
  //    |
  //   Data // repositories


  List<MatchItemActivities>? matchItemActivitiesList;
  UiState<MatchItemActivities>  matchItemActivitiesState = IdealState<MatchItemActivities>();

  ActivitiesViewModel() {
    loadMatches();
  }


  loadMatches() async {
    try {
      await for (var event in getMatches()) {
        if (event is SuccessEvent<List<MatchItemActivities>>) {
          matchItemActivitiesList = event.data;
          matchItemActivitiesState = SuccessState(message: "data retrieved", onDismis: () {});
          notifyListeners();

        } else if (event is ErrorEvent<List<MatchItemActivities>>) {
          matchItemActivitiesState = ErrorState(error: event.error, onDismis:  (){matchItemActivitiesState = IdealState();});
          notifyListeners();

        } else if (event is LoadingEvent<List<MatchItemActivities>>) {

          matchItemActivitiesState = LoadingState();
          notifyListeners();

        } else {}
      }
    } catch (e) {
      matchItemActivitiesState = ErrorState(error: e.runtimeType.toString(), onDismis:  (){matchItemActivitiesState = IdealState();});
      rethrow;
    }
  }














  // async Await
  //












}