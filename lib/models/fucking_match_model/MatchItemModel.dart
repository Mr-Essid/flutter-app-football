class MatchModel {
  final String id;
  final DateTime date;
  final String userId;
  final Terrain terrain;
  final List<Player> playersOfMatch;

  MatchModel({
    required this.id,
    required this.date,
    required this.userId,
    required this.terrain,
    required this.playersOfMatch,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['_id'],
      date: DateTime.parse(json['date']),
      userId: json['userId'],
      terrain: Terrain.fromJson(json['terrainId']),
      playersOfMatch: (json['playersOfMatch'] as List)
          .map((player) => Player.fromJson(player))
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

class Terrain {
  final String id;
  final DateTime date;
  final String label;
  final String description;
  final int width;
  final int height;
  final int price;
  final String longitude;
  final String latitude;

  Terrain({
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

  factory Terrain.fromJson(Map<String, dynamic> json) {
    return Terrain(
      id: json['_id'],
      date: DateTime.parse(json['date']),
      label: json['label'],
      description: json['description'],
      width: json['width'],
      height: json['height'],
      price: json['price'],
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

class Player {
  final String id;
  final bool isAccepted;
  final User user;

  Player({
    required this.id,
    required this.isAccepted,
    required this.user,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['_id'],
      isAccepted: json['isAccepted'],
      user: User.fromJson(json['userId']),
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

class User {
  final String id;
  final String email;
  final String name;
  final String? phone;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
