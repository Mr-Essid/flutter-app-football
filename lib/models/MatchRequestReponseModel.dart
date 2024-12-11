import 'package:project_flutter_football/models/fucking_match_model/MatchItemModel.dart';
import 'package:project_flutter_football/models/model_protocol.dart';

class MatchRequestResponseModel extends ModelProtocol{
  final bool isAccepted;
  final UserMatchItem userId;
  final String matchId;
  final String id;


  MatchRequestResponseModel(
  {
    required this.isAccepted,
    required this.userId,
    required this.matchId,
    required this.id
}
      );


  factory MatchRequestResponseModel.fromJson(Map<String, dynamic> json) {
    return MatchRequestResponseModel(
      isAccepted: json['isAccepted'] as bool,
      userId: UserMatchItem.fromJson(json['userId']),
      matchId: json['matchId'],
      id: json['_id'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'isAccepted': isAccepted,
      'userId': userId.toJson(),
      'matchId': matchId,
      '_id': id,
    };
  }

}


