
import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionUtil {
  static ConnectionUtil? _instance;
  ConnectionUtil._internal();

  factory ConnectionUtil() {
    _instance ??= ConnectionUtil._internal();
    return _instance!;
  }

  static void resetInstance() {
    _instance = null; // Reset the singleton instance
  }

  final Connectivity _connectivity = Connectivity();
  final StreamController<String> _connectionStatusController =
  StreamController<String>.broadcast();
  bool isConnected = false;

  Stream<String> get connectionStatusStream =>
      _connectionStatusController.stream;

  Future<void> initialize() async {
    // Check initial connection
    final List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    await _updateConnectionStatus(result[result.length - 1]);
    // Listen to connectivity changes
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) async {
      await _updateConnectionStatus(result[result.length - 1]);
    });
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    String status;
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        final valConnection = await checkConnection();
        if(valConnection) {
          status = result == ConnectivityResult.mobile
              ? "Terkoneksi dengan paket data, mohon menggunakan Wifi kantor"
              : "Terkoneksi dengan WIFI";
          isConnected = true;
        } else {
          status = result == ConnectivityResult.mobile
              ? "Terkoneksi dengan paket data, tetapi Tidak ada internet"
              : "Terkoneksi dengan WIFI tetapi tidak ada internet";
          isConnected = false;
        }
        break;
      case ConnectivityResult.none:
        status = "Tidak ada koneksi";
        isConnected = false;
        break;
      default:
        status = "Unknown Connection Status";
        isConnected = false;
    }

    if (!_connectionStatusController.isClosed) {
      _connectionStatusController.add(status);
    }
  }

  bool functionConnection() {
    return isConnected;
  }

  void dispose() {
    if (!_connectionStatusController.isClosed) {
      _connectionStatusController.close();
    }
  }

  static Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.co.id');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

}