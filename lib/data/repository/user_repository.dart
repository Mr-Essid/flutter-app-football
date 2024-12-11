import 'package:project_flutter_football/constaints.dart';
import 'package:project_flutter_football/models/auth/signin_model.dart';
import 'package:project_flutter_football/models/auth/signup_model.dart';
import 'package:project_flutter_football/models/auth/token_model.dart';
import 'package:project_flutter_football/models/user/user_model.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:project_flutter_football/utils/repository_callback.dart';
import 'package:pretty_http_logger/src/logger/log_level.dart';
import 'package:pretty_http_logger/src/logger/logging_middleware.dart';
import 'package:pretty_http_logger/src/middleware/http_client_with_middleware.dart';
import 'package:pretty_http_logger/src/middleware/http_with_middleware.dart';
import 'package:project_flutter_football/utils/sesssion_managements.dart';

Stream<Events<TokenModel>> authentication(SignInModel model) {
  return runRequest<TokenModel>(() {
    var endoint = "/auth/login";

    HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var url = Uri.http(BASE_URL, endoint);
    return httpI.post(url, body: model.toJson());
  }, 200, TokenModel.fromJson);
}

Stream<Events<User>> currentUser(String token) {
  return runRequest<User>(() async {
    var endpoint = "/user";
    var pref = await SesssionManagements().getToken();
    HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var url = Uri.http(BASE_URL, endpoint);
    return httpI.get(url, headers: {"Authorization": "Bearer $token"});
  }, 200, User.fromJson);
}
Stream<Events<TokenModel>> signup(UserSignUpModel model) {
  return runRequest<TokenModel>(
          () {
    var endpoint = "/auth/signup";
    HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var url = Uri.http(BASE_URL, endpoint);
    return httpI.post(url, body: model.toJson());
  }, 201, TokenModel.fromJson);
}



Stream<Events<Message>> submitOTACode(SendOTP model) {
  return runRequest<Message>(
          () {
        var endpoint = "/auth/otp-send";

        HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);
        var url = Uri.http(BASE_URL, endpoint);
        return httpI.post(url, body: model.toJson());
      }, 200, Message.fromJson);
}

Stream<Events<Message>> verifyOTACode(VerifyOTA model) {
  return runRequest<Message>(
          () {
        var endpoint = "/auth/otp-verify";
        HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);
        var url = Uri.http(BASE_URL, endpoint);
        return httpI.post(url, body: model.toJson());
      }, 200, Message.fromJson);
}


