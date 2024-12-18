
import 'dart:convert';

import 'package:project_flutter_football/models/model_protocol.dart';

class MessageResponsePayload extends ModelProtocol {

  final String userName;
  final String userId;
  final String content;
  final String createdAt;

  MessageResponsePayload({required this.userName, required this.content, required this.createdAt, required this.userId});
  
  factory MessageResponsePayload.fromJson(Map<String, dynamic> map_) {
    final userMap = map_['userId'];
    final createdAt = map_['createdAt'] as String;
    final content = map_['content'] as String;
    final userName = userMap['name'] as String;
    final userId = userMap['_id'] as String;
    return MessageResponsePayload(userId: userId, userName: userName, content: content, createdAt: createdAt);
  }

  factory MessageResponsePayload.fromJsonWithResponse(Map<String, dynamic> json) {
    return MessageResponsePayload(userName: json['userName'], content: json['content'], createdAt: json['datetime_'], userId: json['userId']);
  }


}