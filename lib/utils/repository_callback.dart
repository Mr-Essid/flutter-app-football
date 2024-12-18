import 'dart:convert';

import 'package:project_flutter_football/models/model_protocol.dart';
import 'package:project_flutter_football/models/root_model.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:http/http.dart' as http;
import 'package:project_flutter_football/utils/sesssion_managements.dart';




Stream<Events<T>> runRequest<T extends ModelProtocol>(

    Future<http.Response> Function(String? token)  apiCall,
    int successStatusCode,
    T Function(Map<String, dynamic>) fromJson) async* {
  yield LoadingEvent();
  try {


    var token = await SesssionManagements().getToken();

    var response = await apiCall(token);

    print(response.statusCode);
    if (response.statusCode == successStatusCode) {

      final mapResponse = jsonDecode(response.body);

      final data_ = RootModel.fromJson(mapResponse, fromJson);
      if (data_.status) {
        yield SuccessEvent<T>(message: "Request successful", data: data_.data!);
      } else {
        yield ErrorEvent(
            error: data_.errors?.join("\n") ?? "unexpected error just happened",
            statusCode: response.statusCode);
      }
    } else {
      final jsonErrorOfBody = jsonDecode(response.body);

      yield ErrorEvent(
          error:  jsonErrorOfBody['message'] ?? "unexpected error just happened");
    }
  } catch (e) {
    yield ErrorEvent(
        error: e.runtimeType.toString() );
    rethrow;
  }
}

Stream<Events<List<T>>> runRequestWithList<T extends ModelProtocol>(
    Future<http.Response> Function(String? token)  apiCall,
    int successStatusCode,
    T Function(Map<String, dynamic>) fromJson) async* {
  yield LoadingEvent();


  try {

    var token = await SesssionManagements().getToken();

    var response = await apiCall(token);

    if (response.statusCode == successStatusCode) {
      final mapResponse = jsonDecode(response.body);

      final data_ = RootModel.fromJsonList(mapResponse, fromJson);

      if (data_.status) {
        yield SuccessEvent<List<T>>(message: "Request successful", data: data_.data!);
      } else {
        yield ErrorEvent(
            error: data_.errors?.join("\n") ?? "unexpected error just happened",
            statusCode: response.statusCode);
      }
    } else {
      yield ErrorEvent(
          error: "Request failed with status: ${response.statusCode}");
    }
  } catch (e) {
    yield ErrorEvent(
        error: "Request failed with status: ${e.runtimeType.toString()}");
    rethrow;
  }
}




















