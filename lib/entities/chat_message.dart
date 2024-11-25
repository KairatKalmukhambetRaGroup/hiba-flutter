/// lib/entities/entities_library.dart
part of 'entities_library.dart';

enum ChatMessageType {
  received,
  sent,
}

/// A `ChatMessage` object represents a message from [HibaChat].
class ChatMessage {
  /// Time of this message as String.
  String? timestamp;

  /// Content of this message.
  String content;

  /// Represents who send this message.
  String senderType;

  /// Status of this message.
  String? messageStatus;

  /// Chat this message belongs to.
  String chat;

  /// Create new `ChatMessage` instance.
  ChatMessage(
      {required this.chat,
      required this.content,
      required this.senderType,
      this.messageStatus,
      this.timestamp});

  /// Create new `ChatMessage` instance from JSON object.
  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        chat: json['chat'].toString(),
        content: json['content'],
        senderType: json['senderType'],
        messageStatus: json['messageStatus'],
        timestamp: json['timestamp'].toString(),
      );

  @override
  String toString() {
    return '{"senderType":"CLIENT", "content": "$content", "chat": "$chat"}';
  }
}
