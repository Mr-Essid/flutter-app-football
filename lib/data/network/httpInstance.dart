import 'package:pretty_http_logger/src/logger/log_level.dart';
import 'package:pretty_http_logger/src/logger/logging_middleware.dart';
import 'package:pretty_http_logger/src/middleware/http_with_middleware.dart';


HttpWithMiddleware httpI = HttpWithMiddleware.build(middlewares: [
  HttpLogger(logLevel: LogLevel.NONE),
]);

