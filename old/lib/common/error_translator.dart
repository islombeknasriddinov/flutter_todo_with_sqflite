import 'package:darmon/common/resources.dart';

class ErrorTranslator {
  static final String CONNECTION_FAIL = "Connection failed".toLowerCase();
  static final String CONNECTION_REFUSED = "Connection refused".toLowerCase();
  static final String HTTP_NOT_FOUND = "Status 404".toLowerCase();
  static final String HTTP_NOT_FOUND2 = "Http status error [404]".toLowerCase();
  static final String CONNECTION_TIMEOUT = "Connecting timed out".toLowerCase();
  static final String NUMERIC_OR_VALUE = "numeric or value".toLowerCase();
  static final String NO_DATA_FOUND = "no data found".toLowerCase();
  static final String NO_ADDRESS_ASSOCIATED_WITH_HOSTNAME = "no address associated with hostname".toLowerCase();

  static final String OAUTH_NUMERIC_OR_VALUE = "numeric or value".toLowerCase();
  static final String OAUTH_NO_DATA_FOUND = "no data found".toLowerCase();

  static String translateError(String error) {
    if (error == null) return null;
    String err = error.toLowerCase();
    if (err.contains(CONNECTION_FAIL)) {
      return R.strings.error.error_conection_fail;
    } else if (err.contains(CONNECTION_REFUSED)) {
      return R.strings.error.error_conection_refused;
    } else if (err.contains(HTTP_NOT_FOUND) || err.contains(HTTP_NOT_FOUND2)) {
      return R.strings.error.error_http_not_found;
    } else if (err.contains(CONNECTION_TIMEOUT)) {
      return R.strings.error.error_connection_timeout;
    } if (err.contains(NO_ADDRESS_ASSOCIATED_WITH_HOSTNAME)) {
      return R.strings.error.error_conection_fail;
    }
    return err;
  }
}
