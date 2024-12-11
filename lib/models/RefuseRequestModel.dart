import 'package:project_flutter_football/models/model_protocol.dart';

class RefuseModel extends ModelProtocol {
  final bool acknowledged;
  final String deletedCount;

  RefuseModel({
    required this.acknowledged,
    required this.deletedCount,
  });

  // Factory method to create an instance from a JSON map
  factory RefuseModel.fromJson(Map<String, dynamic> json) {
    return RefuseModel(
      acknowledged: json['acknowledged'] as bool,
      deletedCount: json['deletedCount'].toString(),
    );
  }

  // Method to convert an instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'acknowledged': acknowledged,
      'deletedCount': deletedCount,
    };
  }
}
