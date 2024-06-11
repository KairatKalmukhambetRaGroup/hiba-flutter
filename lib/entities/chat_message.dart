enum ChatMessageType {
  received,
  sent,
}

class ChatMessage {
  String? timestamp;
  String content;
  String senderType;
  String? messageStatus;
  String chat;

  ChatMessage({
    required this.chat,
    required this.content,
    required this.senderType,
    this.messageStatus
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        chat: json['chat'].toString(),
        content: json['content'],
        senderType: json['senderType'],
        messageStatus: json['messageStatus']
      );


  @override
  String toString() {
    return '{"senderType":"CLIENT", "content": "$content", "chat": "$chat"}';
  }
}
