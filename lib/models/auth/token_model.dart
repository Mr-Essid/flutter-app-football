import 'package:project_flutter_football/models/model_protocol.dart';

class TokenModel extends ModelProtocol {
  final String accessToken;
  final String refreshToken;

  TokenModel({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}
