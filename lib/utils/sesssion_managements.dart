import 'package:project_flutter_football/models/auth/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SesssionManagements {

  var sharedPreference = SharedPreferencesAsync();
  final tokenName = "TOKEN";
  final refrechToken = "RTOKEN";
  Future<String?> getToken() async {
    return await sharedPreference.getString(tokenName);
  }

  Future<String?> getRefreshToken() async {
    return await sharedPreference.getString(refrechToken);
  }

  putToken(TokenModel token) async {
    await sharedPreference.setString(tokenName, token.accessToken);
    await sharedPreference.setString(refrechToken, token.refreshToken);
  }

  putTokenS(String token, String rtoken) async {
    await sharedPreference.setString(tokenName, token);
    await sharedPreference.setString(refrechToken, rtoken);
  }

  putKey<T>(String key, T value) async {
    if (T is String) {
      sharedPreference.setString(key, value as String);
    }
    if (T is int) {
      sharedPreference.setInt(key, value as int);
    }
    if (T is double) {
      sharedPreference.setDouble(key, value as double);
    }
    if (T is List<String>) {
      sharedPreference.setStringList(key, value as List<String>);
    }
    if (T is bool) {
      sharedPreference.setBool(key, value as bool);
    } else {
      throw ArgumentError("Session Management: Not Supported Type");
    }
  }
}
