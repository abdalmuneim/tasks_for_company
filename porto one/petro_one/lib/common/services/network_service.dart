import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  void initializeNetworkStream();
  StreamSubscription<bool> get listenToNetworkStream;

  Future<void> dispose();
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection internetConnectionChecker;

  NetworkInfoImpl({required this.internetConnectionChecker});

  final StreamController<bool> _streamController = StreamController<bool>();
  late final StreamSubscription<bool> _streamSubscription =
      _streamController.stream.asBroadcastStream().listen((event) => event);
  late StreamSubscription<InternetStatus> _internetConnectionStream;
  @override
  void initializeNetworkStream() {
    _internetConnectionStream =
        internetConnectionChecker.onStatusChange.listen((status) {
      switch (status) {
        case InternetStatus.connected:
          _streamController.sink.add(true);
          break;
        case InternetStatus.disconnected:
          _streamController.sink.add(false);
          break;
      }
    });
  }

  @override
  StreamSubscription<bool> get listenToNetworkStream {
    if (_streamSubscription.isPaused) {
      _streamSubscription.resume();
    }

    return _streamSubscription;
  }

  @override
  Future<void> dispose() async {
    await _streamController.close();
    await _internetConnectionStream.cancel();
  }
}
