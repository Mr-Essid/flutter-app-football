
class AddMatchResponse {
  final String date;
  final AddMatchResponseUser userId;
  final AddMatchResponseTerrain terrainId;
  final List<dynamic> playersOfMatch;
  final String id;
  final String createdAt;
  final String updatedAt;
  final int version;

  AddMatchResponse({
    required this.date,
    required this.userId,
    required this.terrainId,
    required this.playersOfMatch,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory AddMatchResponse.fromJson(Map<String, dynamic> json) {
    return AddMatchResponse(
      date: json['date'],
      userId: AddMatchResponseUser.fromJson(json['userId']),
      terrainId: AddMatchResponseTerrain.fromJson(json['terrainId']),
      playersOfMatch: List<dynamic>.from(json['playersOfMatch']),
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'userId': userId.toJson(),
      'terrainId': terrainId.toJson(),
      'playersOfMatch': playersOfMatch,
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': version,
    };
  }
}

class AddMatchResponseUser {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String lastName;

  AddMatchResponseUser({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.lastName,
  });

  factory AddMatchResponseUser.fromJson(Map<String, dynamic> json) {
    return AddMatchResponseUser(
      id: json['_id'],
      email: json['email'],
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

class AddMatchResponseTerrain {
  final String id;
  final String date;
  final String label;
  final String description;
  final int width;
  final int height;
  final int price;
  final String longitude;
  final String latitude;
  final String createdAt;
  final String updatedAt;
  final int version;

  AddMatchResponseTerrain({
    required this.id,
    required this.date,
    required this.label,
    required this.description,
    required this.width,
    required this.height,
    required this.price,
    required this.longitude,
    required this.latitude,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory AddMatchResponseTerrain.fromJson(Map<String, dynamic> json) {
    return AddMatchResponseTerrain(
      id: json['_id'],
      date: json['date'],
      label: json['label'],
      description: json['description'],
      width: json['width'],
      height: json['height'],
      price: json['price'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'date': date,
      'label': label,
      'description': description,
      'width': width,
      'height': height,
      'price': price,
      'longitude': longitude,
      'latitude': latitude,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': version,
    };
  }
}
