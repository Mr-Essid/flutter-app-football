import 'package:project_flutter_football/models/model_protocol.dart';

class AddMatchModel extends ModelProtocol {

  String terrainId;
  String date;
  AddMatchModel({required this.terrainId, required this.date});

  factory AddMatchModel.fromJson(Map<String, dynamic> json) {
    return AddMatchModel(terrainId: json['terrainId'], date: json['date']);
  }

  Map<String, dynamic>  toJson() {
    return {
      "date": date,
      "terrainId": terrainId
    };
  }



}