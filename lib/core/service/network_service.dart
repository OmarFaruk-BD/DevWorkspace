import 'dart:io';
import 'package:workspace/core/api/api_client.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  final Connectivity _connectivity = Connectivity();

  Future<bool> hasConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }

  Future<bool> hasInternetAccess([String host = 'google.com']) async {
    try {
      final result = await InternetAddress.lookup(host);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<String?> message() async {
    if (!await hasConnection()) {
      return 'Device is not connected to any network.';
    }
    if (!await hasInternetAccess()) {
      return 'Connected to a network, but no internet access.';
    }
    if (!await hasInternetAccess(Endpoints.baseURL)) {
      return 'We could not connect to the server.';
    }
    return null;
  }
}
