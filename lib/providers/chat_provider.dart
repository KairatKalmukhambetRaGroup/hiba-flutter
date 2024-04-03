import 'package:flutter/material.dart';
import 'package:hiba/entities/chat_message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class ChatProvider extends ChangeNotifier {
  late WebSocketChannel _channel;
  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages.reversed.toList();

  ChatProvider() {
    _initWebSocket();
    _messages.add(ChatMessage(
        idFrom: 1,
        idTo: 2,
        timestamp: '11:45',
        content: 'Здравствуйте',
        type: ChatMessageType.sent));
    _messages.add(ChatMessage(
        idFrom: 2,
        idTo: 1,
        timestamp: '11:45',
        content: 'Здравствуйте, чем мы вам можем помочь?',
        type: ChatMessageType.received));
    _messages.add(ChatMessage(
        idFrom: 1,
        idTo: 2,
        timestamp: '11:47',
        content: 'Хочу перенести дату доставки на завтра',
        type: ChatMessageType.sent));
  }

  void _initWebSocket() {
    _channel = IOWebSocketChannel.connect('ws://localhost:8000/chat');
    _channel.stream.listen((message) {
      _handleMessage(message);
    });
  }

  void sendMessage(String message) {
    // _channel.sink.add(message);
    _messages.add(ChatMessage(
        idFrom: 1,
        idTo: 2,
        timestamp: 'today',
        content: message,
        type: ChatMessageType.sent));
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
