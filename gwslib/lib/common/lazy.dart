import 'package:gwslib/log/logger.dart';

class Lazy<T> {
  T data;
  bool _isLoaded;
  final T Function() onLoadLazy;

  Lazy(this.onLoadLazy) : _isLoaded = false;

  T load() {
    try {
      data = onLoadLazy?.call();
      return data;
    } catch (e, st) {
      Log.error("Error($e)\n$st");
      return null;
    } finally {
      _isLoaded = true;
      Log.debug("Lazy.load($data)");
    }
  }

  T get() {
    if (_isLoaded) {
      return data;
    }
    return load();
  }
}
