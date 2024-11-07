import 'dart:async';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
              InternetAddress(dotenv.get('IP'), type: InternetAddressType.IPv4),
          port: int.tryParse(dotenv.get('PORT')) ?? 8000),
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
          break;
        case InternetConnectionStatus.disconnected:
          if (connectionStatus != ConnectionStatus.disconnected) {
            connectionStatus = ConnectionStatus.disconnected;
            notifyListeners();
          }
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
