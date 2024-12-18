
import 'package:flutter/material.dart';
import 'package:project_flutter_football/ApplicationEventTrain.dart';
import 'package:project_flutter_football/data/repository/match_repository.dart';
import 'package:project_flutter_football/models/MatchRequestReponseModel.dart';
import 'package:project_flutter_football/models/fucking_match_model/MatchItemModel.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:project_flutter_football/utils/ui_state.dart';

class JoinMatchViewModel extends ChangeNotifier{
  bool isLoading = false;
  UiState<MatchRequestResponseModel> matchRequestResponseModel = IdealState<MatchRequestResponseModel>();
  TextEditingController controller = TextEditingController();
  final keyForm = GlobalKey<FormState>();

 void submitIsLoading(bool isLoading)  {
    this.isLoading = isLoading;
    notifyListeners();
  }

    requestJoinMatchX() async {
    if(keyForm.currentState?.validate() == false) {
      return;
    }


    try {
      await for (var event in joinMatchRequest(controller.text.trim())) {
        if (event is SuccessEvent<PlayerMatchItem>) {
          matchRequestResponseModel = SuccessState(message: "You've Joined Successfully", onDismis: () {
           matchRequestResponseModel = IdealState();
           notifyListeners();
          });
          eventBus.fire(BEvent(resource: {SimpleEventData.JOIN_MATCH_EVENT: event.data}, message: "match joined"));
          notifyListeners();

        } else if (event is ErrorEvent<PlayerMatchItem>) {
          matchRequestResponseModel = ErrorState(error: event.error, onDismis:  (){
            matchRequestResponseModel = IdealState();
            notifyListeners();
          });
          notifyListeners();
        } else if (event is LoadingEvent<MatchRequestResponseModel>) {
          matchRequestResponseModel = LoadingState<MatchRequestResponseModel>();
          notifyListeners();
        }
      }
    } catch (e) {
      matchRequestResponseModel = ErrorState(error: e.runtimeType.toString(), onDismis:  (){
        matchRequestResponseModel = LoadingState<MatchRequestResponseModel>();
        notifyListeners();
      });
      notifyListeners();

      rethrow;
    }
    return null;
  }


}