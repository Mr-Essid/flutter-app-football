


import 'package:project_flutter_football/models/fucking_match_model/JoinedMatch.dart';

import '../../model_protocol.dart';

class JointedMatchModelWapper extends ModelProtocol {

  late String id;
  late List<JoinedMatchModel> jointedMatches;

  JointedMatchModelWapper({required this.id, required this.jointedMatches});

  factory  JointedMatchModelWapper.fromJson(Map<String, dynamic> json) {

    String id = json['_id'];
    List<dynamic> listOfOwnModel =  json['jointedMatch'];



    return JointedMatchModelWapper(
        id: id,
        jointedMatches: listOfOwnModel.map((e) => JoinedMatchModel.fromJson(e)).toList(growable: false)
    );
  }







}
