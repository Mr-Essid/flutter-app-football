


import 'package:project_flutter_football/models/fucking_match_model/OwnMatch.dart';
import 'package:project_flutter_football/models/model_protocol.dart';

class OwnMatchModelWapper extends ModelProtocol {

  late String id;
  late List<OwnMatchModel> ownMatches;

  OwnMatchModelWapper({required this.id, required this.ownMatches});

  factory OwnMatchModelWapper.fromJson(Map<String, dynamic> json) {
    String id = json['_id'];

    List<dynamic> listOfOwnModel =  json['ownMatchs'];



    return OwnMatchModelWapper(
      id: id,
      ownMatches: listOfOwnModel.map((e) => OwnMatchModel.fromJson(e)).toList(growable: false)
    );
  }







}