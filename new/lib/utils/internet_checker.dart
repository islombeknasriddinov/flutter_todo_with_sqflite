
import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<void> execute(InternetConnectionChecker internetConnectionChecker,) async {
  final StreamSubscription<InternetConnectionStatus> listener =
  InternetConnectionChecker().onStatusChange.listen(
        (InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
        // ignore: avoid_print
          print('Data connection is available.');
          break;
        case InternetConnectionStatus.disconnected:
        // ignore: avoid_print
          print('You are disconnected from the internet.');
          break;
      }
    },
  );
}