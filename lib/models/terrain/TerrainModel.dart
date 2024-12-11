import 'package:project_flutter_football/models/fucking_match_model/MatchItemModel.dart';
import 'package:project_flutter_football/models/model_protocol.dart';

class TerrainModel extends ModelProtocol {
  final String id;
  final String date;
  final String label;
  final String description;
  final String width;
  final String height;
  final String price;
  final String longitude;
  final String latitude;
  final int version;

  TerrainModel({
    required this.id,
    required this.date,
    required this.label,
    required this.description,
    required this.width,
    required this.height,
    required this.price,
    required this.longitude,
    required this.latitude,
    required this.version,
  });

  factory TerrainModel.fromJson(Map<String, dynamic> json) {
    return TerrainModel(
      id: json['_id'],
      date: json['date'],
      label: json['label'],
      description: json['description'],
      width:  json['width'].toString(),
      height: json['height'].toString(),
      price: json['price'] .toString(),
      longitude: json['longitude'],
      latitude: json['latitude'],
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
      '__v': version,
    };
  }


  toTerrainMachItem(int selectedIndex) {
    return TerrainMachItem(id: id, date:DateTime.parse(date), label: label, description: description, width: width, height: height, price: price, longitude: longitude, latitude: latitude);
  }
}
