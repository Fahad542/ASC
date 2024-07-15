import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService with ChangeNotifier {
  bool _isConnected = true;
  final Connectivity _connectivity = Connectivity();

  bool get isConnected => _isConnected;

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _checkConnectivity(result);
    });
  }

  Future<void> _checkConnectivity(ConnectivityResult result) async {
    bool previousStatus = _isConnected;
    if (result == ConnectivityResult.none) {
      _isConnected = false;
    } else {
      _isConnected = true;
    }

    if (previousStatus != _isConnected) {
      notifyListeners();
    }
  }
}
