import 'package:flutter/material.dart';
import 'package:hiba/entities/chat_message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatProvider extends ChangeNotifier {
  final String serverUrl = 'http://localhost:8080/ws';
  late io.Socket socket;

  late WebSocketChannel _channel;
  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages.reversed.toList();

  ChatProvider() {
    _initWebSocket();
  }

  void _initWebSocket() {
    _channel = WebSocketChannel.connect(Uri.parse('wss://localhost:8080/ws'));
    _channel.stream.listen((message) {
      _handleMessage(message);
    });
  }

  void sendMessage(String message) {
    // _channel.sink.add(message);
    // _messages.add(ChatMessage(
    //     idFrom: 1,
    //     idTo: 2,
    //     timestamp: 'today',
    //     content: message,
    //     type: ChatMessageType.sent));
    notifyListeners();
  }

  void _handleMessage(dynamic message) {
    _messages.add(ChatMessage.fromJson(message));
    notifyListeners();
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
  // upload image - need to rewrite, as now its for firebase
  // UploadTask uploadImageFile(File image, String filename) {
  //    Reference reference = firebaseStorage.ref().child(filename);
  //    UploadTask uploadTask = reference.putFile(image);
  //  return uploadTask;
  // }
}
