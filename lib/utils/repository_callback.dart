import 'dart:convert';

import 'package:project_flutter_football/models/model_protocol.dart';
import 'package:project_flutter_football/models/root_model.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:http/http.dart' as http;

Stream<Events<T>> runRequest<T extends ModelProtocol>(
    Future<http.Response> Function() apiCall,
    int successStatusCode,
    T Function(Map<String, dynamic>) fromJson) async* {
  yield LoadinEvent();
  try {
    var response = await apiCall();

    if (response.statusCode == successStatusCode) {
      final mapResponse = jsonDecode(response.body);
      var data = RootModel.fromJson(mapResponse, fromJson);

      if (data.status) {
        yield SuccessEvent<T>(message: "Request successful", data: data.data!);
      } else {
        yield ErrorEvent(
            error: data.errors?.join("\n") ?? "unexpected error just happened",
            statusCode: response.statusCode);
      }
    } else {
      yield ErrorEvent(
          error: "Request failed with status: ${response.statusCode}");
    }
  } catch (e) {
    yield ErrorEvent(error: "Technical error: $e");
  }
}
