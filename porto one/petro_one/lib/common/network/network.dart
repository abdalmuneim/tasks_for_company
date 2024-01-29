import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoIm implements INetworkInfo {
  final InternetConnection connectionChecker;

  NetworkInfoIm(this.connectionChecker);
  @override
  Future<bool> get isConnected => connectionChecker.hasInternetAccess;
}
