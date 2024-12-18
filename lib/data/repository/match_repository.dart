// get all matches



import 'package:project_flutter_football/data/network/httpInstance.dart';
import 'package:project_flutter_football/models/RefuseRequestModel.dart';
import 'package:project_flutter_football/models/fucking_match_model/AddMatchModel.dart';
import 'package:project_flutter_football/models/fucking_match_model/JoinedMatch.dart';
import 'package:project_flutter_football/models/fucking_match_model/MatchItemModel.dart';
import 'package:project_flutter_football/models/fucking_match_model/models_wrappers/JointedMachModelWrapper.dart';
import 'package:project_flutter_football/models/fucking_match_model/models_wrappers/OwnMatchesWapper.dart';
import 'package:project_flutter_football/models/message_on_response_model.dart';
import 'package:project_flutter_football/models/terrain/TerrainModel.dart';
import 'package:project_flutter_football/ui/features/match/AcceptUserMatch.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:project_flutter_football/utils/repository_callback.dart';

import '../../constaints.dart';






Stream<Events<OwnMatchModelWapper>> ownMatches() {
  return runRequest<OwnMatchModelWapper>((token) async {
    var endpoint = "/user/matches";

    var url = Uri.http(BASE_URL, endpoint);
    return httpI.get(url, headers: {"Authorization": "Bearer $token"});
  }, 200, OwnMatchModelWapper.fromJson);
}




Stream<Events<JointedMatchModelWapper>> joinedMatch() {
  return runRequest<JointedMatchModelWapper>((token) async {
    var endpoint = "/user/match/joined";

    var url = Uri.http(BASE_URL, endpoint);
    return httpI.get(url, headers: {"Authorization": "Bearer $token"});
  }, 200, JointedMatchModelWapper.fromJson);
}




Stream<Events<JoinedMatchModel>> getSingleJoinedMatch(String joinedMatchId) {
  return runRequest<JoinedMatchModel>((token) async {
    var endpoint = "/match-player/$joinedMatchId";

    var url = Uri.http(BASE_URL, endpoint);
    return httpI.get(url, headers: {"Authorization": "Bearer $token"});
  }, 200, JoinedMatchModel.fromJson);
}


Stream<Events<List<MatchItemActivities>>> getMatches() {
  return runRequestWithList<MatchItemActivities>((token) async {
    var endpoint = "/match";

    var url = Uri.http(BASE_URL, endpoint);
    return httpI.get(url, headers: {"Authorization": "Bearer $token"});
  }, 200, MatchItemActivities.fromJson);
}




Stream<Events<List<TerrainModel>>> getTerrains() {
  return runRequestWithList<TerrainModel>((token) async {
    var endpoint = "/terrain";


    var url = Uri.http(BASE_URL, endpoint);

    return httpI.get(url, headers: {"Authorization": "Bearer $token"});
  }, 200, TerrainModel.fromJson);
}






Stream<Events<MatchItemActivities>> addNewMatch(String terrainId, String fullDate) {
  return runRequest<MatchItemActivities>((token) async {
    var endpoint = "/match";

    final model = AddMatchModel(terrainId: terrainId, date: fullDate);

    var url = Uri.http(BASE_URL, endpoint);
    return httpI.post(url, headers: {"Authorization": "Bearer $token"}, body: model.toJson());
  }, 201, MatchItemActivities.fromJson);
}


Stream<Events<MatchItemActivities>> getMatch(String idMatch) {
  return runRequest<MatchItemActivities>((token) async {
    var endpoint = "/match/$idMatch";


    var url = Uri.http(BASE_URL, endpoint);

    return httpI.get(url, headers: {"Authorization": "Bearer $token"});

  }, 200, MatchItemActivities.fromJson);
}



Stream<Events<MatchParticipant>> acceptUser(String playerId) {
  return runRequest<MatchParticipant>((token) async {
    var endpoint = "/match-player/accept/$playerId";

    var url = Uri.http(BASE_URL, endpoint);

    return httpI.put(url, headers: {"Authorization": "Bearer $token"});

  }, 200, MatchParticipant.fromJson);
}

Stream<Events<RefuseModel>> refuseUser(String requestId) {
  return runRequest<RefuseModel>((token) async {
    var endpoint = "/match-player/refuse/$requestId";


    var url = Uri.http(BASE_URL, endpoint);
    return httpI.put(url, headers: {"Authorization": "Bearer $token"});


  }, 200, RefuseModel.fromJson);


}




Stream<Events<PlayerMatchItem>> joinMatchRequest(String requestId) {
  return runRequest<PlayerMatchItem>((token) async {
    var endpoint = "/match-player/join/$requestId";

    var url = Uri.http(BASE_URL, endpoint);
    return httpI.post(url, headers: {"Authorization": "Bearer $token"});

  }, 201, PlayerMatchItem.fromJson);

}


Stream<Events<RefuseModel>> cancelRequest(String requestId) {
  return runRequest<RefuseModel>((token) async {
    final endpoint = "/match-player/cancel/$requestId";

    var url = Uri.http(BASE_URL, endpoint);
    return httpI.put(url, headers: {"Authorization": "Bearer $token"});
  }, 200, RefuseModel.fromJson);
}


Stream<Events<List<MessageResponsePayload>>> loadAllMessages(String idMatch) {
  return runRequestWithList<MessageResponsePayload>((token) async {
    final endpoint = "/message/match/$idMatch";

    var url = Uri.http(BASE_URL, endpoint);
    return httpI.get(url, headers: {"Authorization": "Bearer $token"});
  }, 200, MessageResponsePayload.fromJson);
}
