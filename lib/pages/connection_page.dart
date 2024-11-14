import 'package:flutter/material.dart';
import 'package:hiba/providers/providers_library.dart';

import 'package:hiba/core_library.dart' show AppColors, AppTheme;

class ConnectionPage extends StatefulWidget {
  final ConnectionStatus connectionStatus;
  const ConnectionPage({super.key, required this.connectionStatus});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: widget.connectionStatus == ConnectionStatus.loading
            ? const CircularProgressIndicator(
                color: AppColors.mainBlue,
              )
            : const Text(
                "Нет подключения к интернету",
                style: AppTheme.blue500_16,
              ),
      )),
    );
  }
}
