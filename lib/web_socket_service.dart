import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hiba/entities/entities_library.dart';

import 'package:hiba/utils/api/api_library.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class WebSocketService {
  late StompClient stompClient;
  String? chatId;

  final Function(ChatMessage) onMessageReceived;

  WebSocketService({required this.onMessageReceived});

  Future<void> connect(String? chatId) async {
    try {
      if (chatId != null) {
        this.chatId = chatId;

        final String? authToken = await AuthState.getAuthToken();

        stompClient = StompClient(
          config: StompConfig.sockJS(
            stompConnectHeaders: {'Authorization': 'Bearer $authToken'},
            url: '${dotenv.get('API_URL')}/ws',
            onConnect: onConnect,
            // ignore: avoid_print
            onWebSocketError: (dynamic error) => print(error.toString()),
          ),
        );

        stompClient.activate();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void activate() {
    stompClient.activate();
  }

  void onConnect(StompFrame frame) {
    stompClient.subscribe(
      destination: '/queue/chat/$chatId',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          final message = ChatMessage.fromJson(jsonDecode(frame.body!));
          onMessageReceived(message);
        }
      },
    );
  }

  void sendMessage(String message) {
    stompClient.activate();
    stompClient.send(
      destination: '/app/chat',
      body: message,
    );
  }

  void disconnect() {
    if (stompClient.isActive) {
      stompClient.deactivate();
    }
  }
}
