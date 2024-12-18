import 'package:project_flutter_football/models/fucking_match_model/OwnMatch.dart';
import 'package:project_flutter_football/models/model_protocol.dart';

class MatchItemActivities extends ModelProtocol {
  String id;
  DateTime date;
  UserMatchItem user;
  TerrainMachItem terrain;
  List<PlayerMatchItem> playersOfMatch;



  MatchItemActivities({
    required this.id,
    required this.date,
    required this.user,
    required this.terrain,
    required this.playersOfMatch,
  });
  MatchItemActivities copyWith({
    String? id,
    DateTime? date,
    UserMatchItem? user,
    TerrainMachItem? terrain,
    List<PlayerMatchItem>? playersOfMatch,
  }) {
    return MatchItemActivities(
      id: id ?? this.id,
      date: date ?? this.date,
      user: user ?? this.user,
      terrain: terrain ?? this.terrain,
      playersOfMatch: playersOfMatch ?? this.playersOfMatch,
    );
  }


  factory MatchItemActivities.fromJson(Map<String, dynamic> json) {
    return MatchItemActivities(
      id: json['_id'],
      date: DateTime.parse(json['date']),
      user: UserMatchItem.fromJson(json['userId']),
      terrain: TerrainMachItem.fromJson(json['terrainId']),
      playersOfMatch: (json['playersOfMatch'] as List)
          .map((player) => PlayerMatchItem.fromJson(player))
          .toList(),
    );
  }


  OwnMatchModel toOwnMatch() {
   return OwnMatchModel(
       id: id,
       date: date,
       userId: user.id,
       terrain: OwnMatchModelTerrain(id: terrain.id, date: terrain.date, label: terrain.label, description: terrain.description, width: terrain.width, height: terrain.height, price: terrain.price, longitude: terrain.longitude, latitude: terrain.latitude),
      playersOfMatch: playersOfMatch.map((e) => OwnMatchModelPlayer(id: e.id, isAccepted: e.isAccepted, user: OwnMatchModelUser(id: user.id, email: user.email, name: user.name))).toList(growable: true)

   );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'date': date.toIso8601String(),
      'userId': user.toJson(),
      'terrainId': terrain.toJson(),
      'playersOfMatch': playersOfMatch.map((player) => player.toJson()).toList(),
    };
  }
}

class UserMatchItem {
  String id;
  String email;
  String name;
  String? phone;
  String? lastName;

  UserMatchItem({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.lastName,
  });

  factory UserMatchItem.fromJson(Map<String, dynamic> json) {
    return UserMatchItem(
      id: json['_id'],
      email: json['email'] ?? '',
      name: json['name'],
      phone: json['phone'],
      lastName: json['last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'last_name': lastName,
    };
  }
}

class TerrainMachItem {
  String id;
  DateTime date;
  String label;
  String description;
  String width;
  String height;
  String price;
  String longitude;
  String latitude;

  TerrainMachItem({
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

  factory TerrainMachItem.fromJson(Map<String, dynamic> json) {
    return TerrainMachItem(
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

class PlayerMatchItem extends ModelProtocol {
  String id;
  bool isAccepted;
  UserMatchItem user;
  String matchId;

  PlayerMatchItem({
    required this.id,
    required this.isAccepted,
    required this.user,
    required this.matchId,
  });

  factory PlayerMatchItem.fromJson(Map<String, dynamic> json) {
    return PlayerMatchItem(
      id: json['_id'],
      isAccepted: json['isAccepted'],
      user: UserMatchItem.fromJson(json['userId']),
      matchId: json['matchId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'isAccepted': isAccepted,
      'userId': user.toJson(),
      'matchId': matchId,
    };
  }
}
