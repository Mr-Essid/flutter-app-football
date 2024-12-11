import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:project_flutter_football/data/repository/match_repository.dart';
import 'package:project_flutter_football/models/fucking_match_model/JoinedMatch.dart';
import 'package:project_flutter_football/models/fucking_match_model/OwnMatch.dart';
import 'package:project_flutter_football/models/fucking_match_model/models_wrappers/JointedMachModelWrapper.dart';
import 'package:project_flutter_football/models/fucking_match_model/models_wrappers/OwnMatchesWapper.dart';
import 'package:project_flutter_football/models/match_model.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:project_flutter_football/utils/ui_state.dart';


class HomeViewModel extends ChangeNotifier {

  HomeViewModel() {
    loadOwnMatches();
    loadJointedMatches();
  }


  List<OwnMatchModel>? ownMatchModels;
  UiState<OwnMatchModel> ownMachModelState = IdealState<OwnMatchModel>();

  List<JoinedMatchModel>? jointedMachModel;
  UiState<JoinedMatchModel> jointedMatchModelState = IdealState<JoinedMatchModel>();

  loadOwnMatches() async {
    try {
      await for (var event in ownMatches()) {

        if (event is SuccessEvent<OwnMatchModelWapper>) {

          ownMatchModels = event.data.ownMatches;
          ownMachModelState = SuccessState(message: "data retrieved", onDismis: () {});
          notifyListeners();

        } else if (event is ErrorEvent<OwnMatchModelWapper>) {

          ownMachModelState = ErrorState(error: event.error, onDismis:  (){ownMachModelState = IdealState();});
          notifyListeners();

        } else if (event is LoadingEvent<OwnMatchModelWapper>) {

          ownMachModelState = LoadingState();
          notifyListeners();

        } else {}
      }
    } catch (e) {
      ownMachModelState = ErrorState(error: e.runtimeType.toString(), onDismis:  (){ownMachModelState = IdealState();});
      rethrow;
    }
  }





loadJointedMatches() async {
  try {
    await for (var event in joinedMatch()) {

      if (event is SuccessEvent<JointedMatchModelWapper>) {
        jointedMachModel = event.data.jointedMatches;
        jointedMatchModelState = SuccessState(message: "data retrieved", onDismis: (){});
        notifyListeners();
      } else if (event is ErrorEvent<JointedMatchModelWapper>) {
        jointedMatchModelState = ErrorState(error: event.error, onDismis:  (){jointedMatchModelState = IdealState();});
        notifyListeners();
      } else if (event is LoadingEvent<JointedMatchModelWapper>) {
        jointedMatchModelState = LoadingState();
        notifyListeners();
      } else {}
    }
  } catch (e) {
    jointedMatchModelState = ErrorState(error: e.runtimeType.toString(), onDismis:  (){jointedMatchModelState = IdealState();});
    rethrow;
  }
}
}
