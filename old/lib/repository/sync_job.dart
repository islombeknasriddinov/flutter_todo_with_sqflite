import 'dart:isolate';

import 'package:gwslib/gwslib.dart';

typedef SyncProgressListener = Function(SyncStatus);

class SyncJob {
  static const int MESSAGE_STATUS_KEY_BEGIN = 1;
  static const int MESSAGE_STATUS_KEY_PROGRESSING = 2;
  static const int MESSAGE_STATUS_KEY_ERROR = 3;
  static const int MESSAGE_STATUS_KEY_SUCCESSFUL = 4;
  static const String MESSAGE_START_SYNC = "start";

  static SyncJob _instance;

  static SyncJob get instance {
    if (_instance == null) {
      _instance = SyncJob._();
    }
    return _instance;
  }

  static Future<SyncJob> init() async {
    try {
      if (_instance == null) {
        _instance = SyncJob._();
        await _instance._init();
      }
      return _instance;
    } catch (error, st) {
      return null;
    }
  }

  final ReceivePort _request = ReceivePort();
  final List<SyncProgressListener> _statusListeners = [];
  Isolate syncIsolate;
  SendPort _childSendPost;
  SyncStatus _syncStatus;

  SyncJob._() {
    _init();
  }

  Future<void> _init() async {
    Log.debug("_init()");
    syncIsolate = await Isolate.spawn(mySyncWorker, _request.sendPort);
    Log.debug("syncIsolate.debugName = ${syncIsolate.debugName}");
    _request.listen((message) {
      Log.debug("child message = $message");

      if (message is SendPort) {
        _childSendPost = message;
      }
      if (message is int) {
        switch (message) {
          case MESSAGE_STATUS_KEY_BEGIN:
            _setSyncStatus(SyncStatus.BEGIN);
            break;
          case MESSAGE_STATUS_KEY_PROGRESSING:
            _setSyncStatus(SyncStatus.PROGRESSING);
            break;
          case MESSAGE_STATUS_KEY_SUCCESSFUL:
            _setSyncStatus(SyncStatus.SUCCESSFUL);
            break;
          case MESSAGE_STATUS_KEY_ERROR:
            _setSyncStatus(SyncStatus.ERROR);
            break;
        }
      }
    });
  }

  void start() {
    Log.debug("start()");
    _childSendPost.send(MESSAGE_START_SYNC);
  }

  void addListener(SyncProgressListener listener) {
    Log.debug("addListener()");
    _statusListeners.add(listener);
    if (_syncStatus != null) listener.call(_syncStatus);
  }

  void clear() {
    Log.debug("clear()");
    _setSyncStatus(SyncStatus.CANCELED);
    syncIsolate?.kill();
  }

  void _setSyncStatus(SyncStatus syncStatus) {
    Log.debug("_setSyncStatus($syncStatus) ");
    for (var statusListener in _statusListeners) {
      statusListener?.call(syncStatus);
    }
    this._syncStatus = syncStatus;
  }
}

enum SyncStatus { BEGIN, PROGRESSING, ERROR, SUCCESSFUL, CANCELED }

void mySyncWorker(SendPort sendPort) async {
  Log.debug("mySyncWorker(${sendPort.runtimeType})");
  ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  receivePort.listen((message) {
    if (message is String && message == SyncJob.MESSAGE_START_SYNC) {
      startSync(sendPort);
    }
  });
}

void startSync(SendPort sendPort) async {
  Log.debug("startSync(SendPort sendPort)");
  sendPort.send(SyncJob.MESSAGE_STATUS_KEY_BEGIN);
  try {
    sendPort.send(SyncJob.MESSAGE_STATUS_KEY_PROGRESSING);
    await startSyncWorker();
    sendPort.send(SyncJob.MESSAGE_STATUS_KEY_SUCCESSFUL);
  } catch (error, st) {
    sendPort.send(SyncJob.MESSAGE_STATUS_KEY_ERROR);
    Log.error(error, st);
  }
}

Future<bool> startSyncWorker() async {
  Log.debug("startSyncWorker()");

  return true;
}
