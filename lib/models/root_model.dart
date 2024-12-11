import 'package:flutter/foundation.dart';
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
      final data_ = fromJsonRoot(json['data']);

    return RootModel<T>(
        data: data_,
        message: json["message"],
        status: json["status"] ?? false,
        errors: json["errors"]);
  }

  static RootModel<List<T>> fromJsonList<T>(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {

    final List<dynamic> data_ = json['data'];
    final List<T> decoded = data_.map((e) => fromJson(e)).toList(growable: false);

    return RootModel<List<T>>(
      data: decoded,
      message: json['message'],
      status: json['status'],
      errors: json['errors']
    );

  }


}



