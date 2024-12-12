import 'package:flutter/material.dart';
import 'package:project_flutter_football/data/repository/match_repository.dart';
import 'package:project_flutter_football/models/MatchRequestReponseModel.dart';
import 'package:project_flutter_football/models/RefuseRequestModel.dart';
import 'package:project_flutter_football/models/fucking_match_model/JoinedMatch.dart';
import 'package:project_flutter_football/models/fucking_match_model/MatchItemModel.dart';
import 'package:project_flutter_football/ui/features/match/AcceptUserMatch.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:project_flutter_football/utils/ui_state.dart';

class MatchDetailsViewModel extends ChangeNotifier {

  MatchItemActivities? matchItemActivities;
  List<PlayerMatchItem>? listPlayerItem;
  UiState<MatchItemActivities>  uiStateMatchItem = IdealState();
  UiState<MatchParticipant>  acceptMatch = IdealState();

  MatchDetailsViewModel(String idOfMatch) {
     loadCurrentMatch(idOfMatch);
  }

  renderMatchItem(MatchItemActivities matchItem) {
    matchItemActivities = matchItem ;
    listPlayerItem = matchItem.playersOfMatch;
    notifyListeners();
  }


  submitUiState(UiState<MatchItemActivities> matchItem) {
    uiStateMatchItem = matchItem;
    notifyListeners();
  }


  submitMatchParticipiantUiState(UiState<MatchParticipant> matchParticipient) {
    acceptMatch = matchParticipient;
    notifyListeners();
  }

  acceptUserState(MatchParticipant matchParticipent) {
    final item = listPlayerItem?.firstWhere((e) => e.id == matchParticipent.id);
    if(item !=  null) {
      final newItem = PlayerMatchItem(id: item.id, isAccepted: true, user: item.user, matchId: item.matchId);
      listPlayerItem?.remove(item);
      notifyListeners();
      listPlayerItem?.add(newItem);
      notifyListeners();
    }
  }


  loadCurrentMatch(String idMatch) async {
    try {
      await for (var event in getMatch(idMatch)) {
        if (event is SuccessEvent<MatchItemActivities>) {
          renderMatchItem(event.data);

        } else if (event is ErrorEvent<MatchItemActivities>) {
          submitUiState(ErrorState(error: event.error, onDismis:  (){uiStateMatchItem = IdealState();}));

        } else if (event is LoadingEvent<MatchItemActivities>) {
          submitUiState(LoadingState<MatchItemActivities>());
        } else {}
      }
    } catch (e) {
      submitUiState(ErrorState(error: e.runtimeType.toString(), onDismis:  (){uiStateMatchItem = IdealState();}));
      rethrow;
    }
  }

  Future<UiState<MatchParticipant>?> acceptUserX(String userId) async {
    try {
      await for (var event in acceptUser(userId)) {
        if (event is SuccessEvent<MatchParticipant>) {
          acceptUserState(event.data);

          return SuccessState(message: "User Accepted", onDismis: () {});


        } else if (event is ErrorEvent<MatchParticipant>) {
          return ErrorState(error: event.error, onDismis:  (){uiStateMatchItem = IdealState();});
        } else if (event is LoadingEvent<MatchParticipant>) {

        } else {}


      }
    } catch (e) {
      submitUiState(ErrorState(error: e.runtimeType.toString(), onDismis:  (){uiStateMatchItem = IdealState();}));
      rethrow;
    }
  }

  Future<UiState<RefuseModel>?> refuseRequest(String requestId) async {
    try {
      await for (var event in refuseUser(requestId)) {
        if (event is SuccessEvent<RefuseModel>) {
          listPlayerItem?.removeWhere((e) => e.id == requestId);
          return SuccessState(message: "User Refused", onDismis: () {});


        } else if (event is ErrorEvent<MatchParticipant>) {
          return ErrorState(error: event.error, onDismis:  (){uiStateMatchItem = IdealState();});
        } else if (event is LoadingEvent<MatchParticipant>) {
        } else {}
      }
    } catch (e) {
      submitUiState(ErrorState(error: e.runtimeType.toString(), onDismis:  (){uiStateMatchItem = IdealState();}));
      rethrow;
    }
  }



  Future<UiState<PlayerMatchItem>?> requestJoinMatchX(String matchId) async {
    try {
      await for (var event in joinMatchRequest(matchId)) {
        if (event is SuccessEvent<PlayerMatchItem>) {
          listPlayerItem?.add(event.data);
          notifyListeners();
          return SuccessState(message: "You've Joined Successfully", onDismis: () {});

        } else if (event is ErrorEvent<PlayerMatchItem>) {

          return ErrorState(error: event.error, onDismis:  (){uiStateMatchItem = IdealState();});

        } else if (event is LoadingEvent<MatchRequestResponseModel>) {
        } else {}
      }
    } catch (e) {
      submitUiState(ErrorState(error: e.runtimeType.toString(), onDismis:  (){uiStateMatchItem = IdealState();}));
      rethrow;
    }
  }
}
