import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:project_flutter_football/ApplicationEventTrain.dart';
import 'package:project_flutter_football/data/repository/match_repository.dart';
import 'package:project_flutter_football/models/fucking_match_model/JoinedMatch.dart';
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
    eventBus.on<BEvent<Map<SimpleEventData, Object>>>().listen((event) {
        print("There is Event");
        // first
        Object? value = event.resource[SimpleEventData.ADD_MATCH_EVENT];
        if(value is MatchItemActivities) {
          matchItemActivitiesList?.insert(0,value);
          notifyListeners();
        }


        // second
        Object? unJoinedMatchRequestId = event.resource[SimpleEventData.UNJOIN_MATCH_EVEN];
        print("removed joined match here $unJoinedMatchRequestId");

        if(unJoinedMatchRequestId is JoinedMatchModel? && unJoinedMatchRequestId != null) {
          print("event triggered");
          final indexOfMatchToReplace = matchItemActivitiesList?.indexWhere((e) => e.id == unJoinedMatchRequestId.match.id);
          // replace the match
          if(indexOfMatchToReplace != -1 && indexOfMatchToReplace != null) {
            final match = matchItemActivitiesList?.removeAt(
                indexOfMatchToReplace);

            match?.playersOfMatch.removeWhere((e) =>
            e.id == unJoinedMatchRequestId.id);
            final newMatch = match?.copyWith();
            if (newMatch != null) {
              // synchronize the match members
              matchItemActivitiesList?.insert(indexOfMatchToReplace, newMatch);
              notifyListeners();
            }
          }
        }


        // third
        Object? joinMatchValue = event.resource[SimpleEventData.JOIN_MATCH_EVENT];
        if(joinMatchValue is PlayerMatchItem) {
          final indexOfMatchToReplace = matchItemActivitiesList?.indexWhere((e) => e.id == joinMatchValue.matchId);
          // replace the match
          if(indexOfMatchToReplace != -1 && indexOfMatchToReplace != null) {
            final match = matchItemActivitiesList?.removeAt(indexOfMatchToReplace);

            match?.playersOfMatch.removeWhere((e) => e.id == joinMatchValue.id);
            match?.playersOfMatch.add(joinMatchValue);
            final newMatch = match?.copyWith();
            if(newMatch != null) {
              // synchronize the match members
              matchItemActivitiesList?.insert(indexOfMatchToReplace, newMatch);
              notifyListeners();
            }
          }

          // final index = ourMatchData?.playersOfMatch.indexWhere((e) => e.id == joinMatchValue.id);
          // if(index !=  null && index != -1) {
          //   ourMatchData?.playersOfMatch.removeAt(index);
          //   ourMatchData?.playersOfMatch.insert(index, joinMatchValue);
          // }
        }

    });
  }


  loadMatches() async {
    try {
      await for (var event in getMatches()) {
        if (event is SuccessEvent<List<MatchItemActivities>>) {
          matchItemActivitiesList = event.data.reversed.toList(growable: true);
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






@override
  void dispose() {
    // TODO: implement dispose

    print("activites viewModel disposed");
    super.dispose();
  }





}