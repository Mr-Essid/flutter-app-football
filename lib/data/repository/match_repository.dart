// get all matches


import 'dart:convert';

import 'package:project_flutter_football/models/MatchRequestReponseModel.dart';
import 'package:project_flutter_football/models/RefuseRequestModel.dart';
import 'package:project_flutter_football/models/fucking_match_model/AddMatchModel.dart';
import 'package:project_flutter_football/models/fucking_match_model/JoinedMatch.dart';
import 'package:project_flutter_football/models/fucking_match_model/MatchItemModel.dart';
import 'package:project_flutter_football/models/fucking_match_model/OwnMatch.dart';
import 'package:project_flutter_football/models/fucking_match_model/models_wrappers/JointedMachModelWrapper.dart';
import 'package:project_flutter_football/models/fucking_match_model/models_wrappers/OwnMatchesWapper.dart';
import 'package:project_flutter_football/models/match_model.dart';
import 'package:project_flutter_football/models/terrain/TerrainModel.dart';
import 'package:project_flutter_football/models/user/user_model.dart';
import 'package:project_flutter_football/ui/features/match/AcceptUserMatch.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:project_flutter_football/utils/repository_callback.dart';

import 'package:pretty_http_logger/src/logger/log_level.dart';
import 'package:pretty_http_logger/src/logger/logging_middleware.dart';
import 'package:pretty_http_logger/src/middleware/http_with_middleware.dart';
import '../../constaints.dart';
import '../../utils/sesssion_managements.dart';

Stream<Events<OwnMatchModelWapper>> ownMatches() {
  return runRequest<OwnMatchModelWapper>(() async {
    var endpoint = "/user/matches";

    var pref = await SesssionManagements().getToken();

    HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var url = Uri.http(BASE_URL, endpoint);
    return httpI.get(url, headers: {"Authorization": "Bearer $pref"});
  }, 200, OwnMatchModelWapper.fromJson);
}




Stream<Events<JointedMatchModelWapper>> joinedMatch() {
  return runRequest<JointedMatchModelWapper>(() async {
    var endpoint = "/user/match/joined";

    var pref = await SesssionManagements().getToken();

    HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var url = Uri.http(BASE_URL, endpoint);
    return httpI.get(url, headers: {"Authorization": "Bearer $pref"});
  }, 200, JointedMatchModelWapper.fromJson);
}



Stream<Events<List<MatchItemActivities>>> getMatches() {
  return runRequestWithList<MatchItemActivities>(() async {
    var endpoint = "/match";
    var pref = await SesssionManagements().getToken();

    HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var url = Uri.http(BASE_URL, endpoint);
    return httpI.get(url, headers: {"Authorization": "Bearer $pref"});
  }, 200, MatchItemActivities.fromJson);
}




Stream<Events<List<TerrainModel>>> getTerrains() {
  return runRequestWithList<TerrainModel>(() async {
    var endpoint = "/terrain";
    var pref = await SesssionManagements().getToken();

    HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var url = Uri.http(BASE_URL, endpoint);

    return httpI.get(url, headers: {"Authorization": "Bearer $pref"});
  }, 200, TerrainModel.fromJson);
}






Stream<Events<MatchItemActivities>> addNewMatch(String terrainId, String fullDate) {
  return runRequest<MatchItemActivities>(() async {
    var endpoint = "/match";
    var pref = await SesssionManagements().getToken();

    HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final model = AddMatchModel(terrainId: terrainId, date: fullDate);

    var url = Uri.http(BASE_URL, endpoint);
    return httpI.post(url, headers: {"Authorization": "Bearer $pref"}, body: model.toJson());
  }, 201, MatchItemActivities.fromJson);
}


Stream<Events<MatchItemActivities>> getMatch(String idMatch) {
  return runRequest<MatchItemActivities>(() async {
    var endpoint = "/match/$idMatch";

    var pref = await SesssionManagements().getToken();

    HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var url = Uri.http(BASE_URL, endpoint);

    return httpI.get(url, headers: {"Authorization": "Bearer $pref"});

  }, 200, MatchItemActivities.fromJson);
}



Stream<Events<MatchParticipant>> acceptUser(String playerId) {
  return runRequest<MatchParticipant>(() async {
    var endpoint = "/match-player/accept/$playerId";

    var pref = await SesssionManagements().getToken();

    HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var url = Uri.http(BASE_URL, endpoint);

    return httpI.put(url, headers: {"Authorization": "Bearer $pref"});

  }, 200, MatchParticipant.fromJson);
}

Stream<Events<RefuseModel>> refuseUser(String requestId) {
  return runRequest<RefuseModel>(() async {
    var endpoint = "/match-player/refuse/$requestId";

    var pref = await SesssionManagements().getToken();

    HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var url = Uri.http(BASE_URL, endpoint);
    return httpI.put(url, headers: {"Authorization": "Bearer $pref"});


  }, 200, RefuseModel.fromJson);




}




Stream<Events<PlayerMatchItem>> joinMatchRequest(String requestId) {
  return runRequest<PlayerMatchItem>(() async {
    var endpoint = "/match-player/join/$requestId";

    var pref = await SesssionManagements().getToken();

    HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var url = Uri.http(BASE_URL, endpoint);
    return httpI.post(url, headers: {"Authorization": "Bearer $pref"});

  }, 201, PlayerMatchItem.fromJson);

}


Stream<Events<RefuseModel>> cancelRequest(String requestId) {
  return runRequest<RefuseModel>(() async {
    var endpoint = "/match-player/cancel/$requestId";

    var pref = await SesssionManagements().getToken();

    HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var url = Uri.http(BASE_URL, endpoint);
    return httpI.put(url, headers: {"Authorization": "Bearer $pref"});
  }, 200, RefuseModel.fromJson);
}

