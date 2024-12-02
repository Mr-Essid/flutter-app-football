import 'package:project_flutter_football/constaints.dart';
import 'package:project_flutter_football/models/auth/signin_model.dart';
import 'package:project_flutter_football/models/auth/token_model.dart';
import 'package:project_flutter_football/models/user/user_model.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:project_flutter_football/utils/repository_callback.dart';
import 'package:pretty_http_logger/src/logger/log_level.dart';
import 'package:pretty_http_logger/src/logger/logging_middleware.dart';
import 'package:pretty_http_logger/src/middleware/http_client_with_middleware.dart';
import 'package:pretty_http_logger/src/middleware/http_with_middleware.dart';

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
  return runRequest<User>(() {
    var endoint = "/user";

    HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var url = Uri.http(BASE_URL, endoint);
    return httpI.get(url, headers: {"Authorization": "Bearer $token"});
  }, 200, User.fromJson);
}
// Stream<Events<TokenModel>> signup() {
  // return runRequest<TokenModel>(() {
  //   var endoint = "/auth/login";

  //   HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
  //     HttpLogger(logLevel: LogLevel.BODY),
  //   ]);

  //   var url = Uri.http(BASE_URL, endoint);
  //   return httpI.post(url, body: model.toJson());
  // }, 200, TokenModel.fromJson);
// }
