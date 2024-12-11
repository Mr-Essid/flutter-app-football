

import 'package:project_flutter_football/models/model_protocol.dart';

class MatchParticipant extends ModelProtocol {
  final String id;
  final bool isAccepted;
  final String userId;
  final MatchDetails matchId;
  final int version;
  final DateTime updatedAt;

  MatchParticipant({
    required this.id,
    required this.isAccepted,
    required this.userId,
    required this.matchId,
    required this.version,
    required this.updatedAt,
  });

  factory MatchParticipant.fromJson(Map<String, dynamic> json) {
    return MatchParticipant(
      id: json['_id'] as String,
      isAccepted: json['isAccepted'] as bool,
      userId: json['userId'] as String,
      matchId: MatchDetails.fromJson(json['matchId']),
      version: json['__v'] as int,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'isAccepted': isAccepted,
      'userId': userId,
      'matchId': matchId.toJson(),
      '__v': version,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class MatchDetails {
  final String id;
  final String userId;

  MatchDetails({
    required this.id,
    required this.userId,
  });

  // Factory method to create an instance from JSON
  factory MatchDetails.fromJson(Map<String, dynamic> json) {
    return MatchDetails(
      id: json['_id'] as String,
      userId: json['userId'] as String,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
    };
  }
}
