import 'package:dio/src/dio_error.dart';
import 'package:gwslib/common/util.dart';
import 'package:gwslib/localization/app_lang.dart';

class ErrorMessage {
  static final String CONNECTION_FAIL = "Connection failed".toLowerCase();
  static final String CONNECTION_REFUSED = "Connection refused".toLowerCase();
  static final String HTTP_NOT_FOUND = "Status 404".toLowerCase();
  static final String HTTP_NOT_FOUND2 = "Http status error [404]".toLowerCase();
  static final String CONNECTION_TIMEOUT = "Connecting timed out".toLowerCase();
  static final String OAUTH_NUMERIC_OR_VALUE = "numeric or value".toLowerCase();
  static final String OAUTH_NO_DATA_FOUND = "no data found".toLowerCase();

  static String getMessage(String error) {
    String err = error.toLowerCase();
    if (err.contains(CONNECTION_FAIL)) {
      return "gwslib:error:error_conection_fail".translate();
    } else if (err.contains(CONNECTION_REFUSED)) {
      return "gwslib:error:error_conection_refused".translate();
    } else if (err.contains(HTTP_NOT_FOUND) || err.contains(HTTP_NOT_FOUND2)) {
      return "gwslib:error:error_http_not_found".translate();
    } else if (err.contains(CONNECTION_TIMEOUT)) {
      return "gwslib:error:error_connection_timeout".translate();
    } else if (err.contains(OAUTH_NUMERIC_OR_VALUE) || err.contains(OAUTH_NO_DATA_FOUND)) {
      return "gwslib:error:error_incorrect_login_or_password".translate();
    }
    return err;
  }

  final String message;
  final String stacktrace;

  ErrorMessage(String message, {String stacktrace})
      : this.message = getMessage(message),
        this.stacktrace = nvl(stacktrace);

  factory ErrorMessage.parse(dynamic error) {
    return ErrorMessage.parseWithStacktrace(error, "");
  }

  factory ErrorMessage.parseWithStacktrace(dynamic error, dynamic stacktrace) {
    final message = error is DioError && error.type == DioErrorType.RESPONSE
        ? error.response.data.toString()
        : error.toString();
    return ErrorMessage(message.trim(), stacktrace: stacktrace?.toString() ?? "");
  }

  @override
  String toString() {
    if (stacktrace == null || stacktrace.trim().isEmpty) {
      return message;
    }
    return "$message\n$stacktrace";
  }
}
