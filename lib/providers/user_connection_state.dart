import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum ConnectionStatus { loading, connected, disconnected }

class UserConnectionState extends ChangeNotifier {
  ConnectionStatus connectionStatus = ConnectionStatus.loading;
  StreamSubscription<InternetConnectionStatus>? listener;

  InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker.createInstance(
    checkTimeout: const Duration(seconds: 10), // Custom check timeout
    checkInterval: const Duration(seconds: 10), // Custom check interval
    addresses: [
      AddressCheckOptions(
          address:
              InternetAddress('192.168.68.105', type: InternetAddressType.IPv4),
          port: 8080),
    ],
  );

  void checkConnection() async {
    listener ??= internetConnectionChecker.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          if (connectionStatus != ConnectionStatus.connected) {
            connectionStatus = ConnectionStatus.connected;
            notifyListeners();
          }
          print("CONNECTED");
          break;
        case InternetConnectionStatus.disconnected:
          if (connectionStatus != ConnectionStatus.disconnected) {
            connectionStatus = ConnectionStatus.disconnected;
            notifyListeners();
          }
          print("DISCONNECTED");
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (listener != null) {
      listener?.cancel();
    }
  }
}
