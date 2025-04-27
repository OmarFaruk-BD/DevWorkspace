import 'dart:io';
import 'package:workspace/core/api/endpoints.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  Future<bool> isNetworkConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }

  Future<bool> hasInternetAccess([String host = 'google.com']) async {
    try {
      final result = await InternetAddress.lookup(host);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  Future<String> internetAccess() async {
    if (!await isNetworkConnected()) {
      return 'Device is not connected to any network.';
    }
    if (!await hasInternetAccess()) {
      return 'Connected to a network, but no internet access.';
    }
    if (!await hasInternetAccess(Endpoints.baseURL)) {
      return 'We could not connect to the server.';
    }
    return 'We have encountered internet issues.';
  }
}
