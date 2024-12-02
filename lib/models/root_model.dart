import 'package:project_flutter_football/models/model_protocol.dart';

class RootModel<T> extends ModelProtocol {
  T? data;
  String? message;
  late bool status;
  List<String>? errors;

  RootModel({
    this.data,
    this.errors,
    this.message,
    this.status = false,
  });

  factory RootModel.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic> json) fromJsonRoot) {
    return RootModel<T>(
        data: json["data"] != null ? fromJsonRoot(json["data"]) : null,
        message: json["message"],
        status: json["status"] ?? false,
        errors: json["errors"]);
  }
}
