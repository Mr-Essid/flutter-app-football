import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:project_flutter_football/ApplicationEventTrain.dart';
import 'package:project_flutter_football/data/repository/match_repository.dart';
import 'package:project_flutter_football/models/RefuseRequestModel.dart';
import 'package:project_flutter_football/models/fucking_match_model/JoinedMatch.dart';
import 'package:project_flutter_football/models/fucking_match_model/MatchItemModel.dart';
import 'package:project_flutter_football/models/fucking_match_model/OwnMatch.dart';
import 'package:project_flutter_football/models/fucking_match_model/models_wrappers/JointedMachModelWrapper.dart';
import 'package:project_flutter_football/models/fucking_match_model/models_wrappers/OwnMatchesWapper.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:project_flutter_football/utils/ui_state.dart';


class HomeViewModel extends ChangeNotifier {

  HomeViewModel() {
    loadOwnMatches();
    loadJointedMatches();
    eventBus.on<BEvent<Map<SimpleEventData, Object>>>().listen((event) {
      Object? value = event.resource[SimpleEventData.ADD_MATCH_EVENT];
        if(value is MatchItemActivities) {
          ownMatchModels?.insert(0,value.toOwnMatch());
          notifyListeners();
        }

      Object? joinMatchValue = event.resource[SimpleEventData.JOIN_MATCH_EVENT];
      if(joinMatchValue is PlayerMatchItem) {
        loadJoinedMatch(joinMatchValue.id);
        notifyListeners();
      }

      }

    );

  }

  List<OwnMatchModel>? ownMatchModels;
  UiState<OwnMatchModel> ownMachModelState = IdealState<OwnMatchModel>();

  List<JoinedMatchModel>? jointedMachModel;
  UiState<JoinedMatchModel> jointedMatchModelState = IdealState<JoinedMatchModel>();

  loadOwnMatches() async {
    try {
      await for (var event in ownMatches()) {

        if (event is SuccessEvent<OwnMatchModelWapper>) {

          ownMatchModels = event.data.ownMatches.reversed.toList(growable: true);
          ownMachModelState = SuccessState(message: "data retrieved", onDismis: () {});
          notifyListeners();

        } else if (event is ErrorEvent<OwnMatchModelWapper>) {
          ownMachModelState = ErrorState(error: event.error, onDismis:  (){ownMachModelState = IdealState();});
          notifyListeners();

        } else if (event is LoadingEvent<OwnMatchModelWapper>) {
          ownMachModelState = LoadingState();
          notifyListeners();

        }
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

        jointedMachModel = event.data.jointedMatches.reversed.toList(growable: true);
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



 JoinedMatchModel? preCancelRequest(String requestId) {
    final index_ = jointedMachModel?.indexWhere((e) => e.id == requestId);
    return jointedMachModel?.removeAt(index_ ?? -1);
 }



  Future<UiState<RefuseModel>?> cancelRequestX(String requestId) async {
    try {
      await for (var event in cancelRequest(requestId)) {
        if (event is SuccessEvent<RefuseModel>) {
          final removeJoinedMatch = preCancelRequest(requestId);

          notifyListeners();
          eventBus.fire(BEvent(resource: {SimpleEventData.UNJOIN_MATCH_EVEN: removeJoinedMatch}, message: "disjoint match"));

          return SuccessState<RefuseModel>(message: "Request canceled", onDismis: () {});
        } else if (event is ErrorEvent<RefuseModel>) {
          return ErrorState<RefuseModel>(error: event.error, onDismis:  (){});

        } else if (event is LoadingEvent<RefuseModel>) {
        }
      }
    } catch (e) {
      return ErrorState(error: e.runtimeType.toString(), onDismis:  (){});
    }
    return null;
  }


  loadJoinedMatch(String joinId) async {
    try {
      await for (var event in getSingleJoinedMatch(joinId)) {

        if (event is SuccessEvent<JoinedMatchModel>) {
            jointedMachModel?.insert(0, event.data);
          notifyListeners();
        } else if (event is ErrorEvent<JoinedMatchModel>) {
          jointedMatchModelState = ErrorState(error: event.error, onDismis: () {jointedMatchModelState = IdealState();});
          notifyListeners();
        } else if (event is LoadingEvent<JoinedMatchModel>) {

          notifyListeners();
        } else {}
      }
    } catch (e) {

      rethrow;
    }
  }

  @override
  void dispose() {
    print("home viewModel disposed");
    super.dispose();
  }
}
