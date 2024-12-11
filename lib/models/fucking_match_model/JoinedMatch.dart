class JoinedMatchModel {
  final String id;
  final bool isAccepted;
  final String userId;
  final Match match;

  JoinedMatchModel({
    required this.id,
    required this.isAccepted,
    required this.userId,
    required this.match,
  });

  factory JoinedMatchModel.fromJson(Map<String, dynamic> json) {
    return JoinedMatchModel(
      id: json['_id'],
      isAccepted: json['isAccepted'],
      userId: json['userId'],
      match: Match.fromJson(json['matchId']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'isAccepted': isAccepted,
      'userId': userId,
      'matchId': match.toJson(),
    };
  }
}

class Match {
  final String id;
  final DateTime date;
  final String userId;
  final String terrainId;
  final List<String> playersOfMatch;

  Match({
    required this.id,
    required this.date,
    required this.userId,
    required this.terrainId,
    required this.playersOfMatch,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['_id'],
      date: DateTime.parse(json['date']),
      userId: json['userId'],
      terrainId: json['terrainId'],
      playersOfMatch: List<String>.from(json['playersOfMatch']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'date': date.toIso8601String(),
      'userId': userId,
      'terrainId': terrainId,
      'playersOfMatch': playersOfMatch,
    };
  }

}
