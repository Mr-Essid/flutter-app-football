import 'package:project_flutter_football/models/model_protocol.dart';
import 'package:project_flutter_football/ui/features/match/MatchComponent.dart';

class OwnMatchModel extends ModelProtocol{
  final String id;
  final DateTime date;
  final String userId;
  final OwnMatchModelTerrain terrain;
  final List<OwnMatchModelPlayer> playersOfMatch;

  OwnMatchModel({
    required this.id,
    required this.date,
    required this.userId,
    required this.terrain,
    required this.playersOfMatch,
  });

  factory OwnMatchModel.fromJson(Map<String, dynamic> json) {
    return OwnMatchModel(
      id: json['_id'],
      date: DateTime.parse(json['date']),
      userId: json['userId'],
      terrain: OwnMatchModelTerrain.fromJson(json['terrainId']),
      playersOfMatch: (json['playersOfMatch'] as List)
          .map((player) => OwnMatchModelPlayer.fromJson(player))
          .toList(),
    );
  }



  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'date': date.toIso8601String(),
      'userId': userId,
      'terrainId': terrain.toJson(),
      'playersOfMatch': playersOfMatch.map((player) => player.toJson()).toList(),
    };
  }
}

class OwnMatchModelTerrain {
  final String id;
  final DateTime date;
  final String label;
  final String description;
  final String width;
  final String height;
  final String price;
  final String longitude;
  final String latitude;

  OwnMatchModelTerrain({
    required this.id,
    required this.date,
    required this.label,
    required this.description,
    required this.width,
    required this.height,
    required this.price,
    required this.longitude,
    required this.latitude,
  });

  factory OwnMatchModelTerrain.fromJson(Map<String, dynamic> json) {
    return OwnMatchModelTerrain(
      id: json['_id'],
      date: DateTime.parse(json['date']),
      label: json['label'],
      description: json['description'],
      width: json['width'].toString(),
      height: json['height'].toString(),
      price: json['price'].toString(),
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'date': date.toIso8601String(),
      'label': label,
      'description': description,
      'width': width,
      'height': height,
      'price': price,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}

class OwnMatchModelPlayer {
  final String id;
  final bool isAccepted;
  final OwnMatchModelUser user;

  OwnMatchModelPlayer({
    required this.id,
    required this.isAccepted,
    required this.user,
  });

  factory OwnMatchModelPlayer.fromJson(Map<String, dynamic> json) {
    return OwnMatchModelPlayer(
      id: json['_id'],
      isAccepted: json['isAccepted'],
      user: OwnMatchModelUser.fromJson(json['userId']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'isAccepted': isAccepted,
      'userId': user.toJson(),
    };
  }
}

class OwnMatchModelUser {
  final String id;
  final String email;
  final String name;
  final String? phone;

  OwnMatchModelUser({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
  });

  factory OwnMatchModelUser.fromJson(Map<String, dynamic> json) {
    return OwnMatchModelUser(
      id: json['_id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'name': name,
      'phone': phone,
    };
  }
}
