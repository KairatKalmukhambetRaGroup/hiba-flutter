import 'dart:convert';

import 'package:hiba/entities/chat_message.dart';
import 'package:hiba/utils/api/auth.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class WebSocketService{
  StompClient? stompClient;
  String? chatId;

  final Function(ChatMessage) onMessageReceived;

  WebSocketService({required this.onMessageReceived});

  Future<void> connect(String? chatId) async {
    this.chatId = chatId;

    final String? authToken = await AuthState.getAuthToken();

    stompClient = StompClient(
      config: StompConfig.sockJS(
        stompConnectHeaders: {
          'Authorization': 'Bearer $authToken'
        },
        url: 'http://localhost:8080/ws',
        onConnect: onConnect,
        // ignore: avoid_print
        onWebSocketError: (dynamic error) => print(error.toString()),
      ),
    );

    stompClient?.activate();
  }

  void onConnect(StompFrame frame) {
    stompClient?.subscribe(
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
    stompClient?.send(
      destination: '/app/chat',
      body: message,
    );
  }

  void disconnect() {
    stompClient?.deactivate();
  }

}