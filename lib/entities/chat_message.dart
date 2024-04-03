enum ChatMessageType {
  received,
  sent,
}

class ChatMessage {
  int idFrom;
  int idTo;
  String timestamp;
  String content;
  ChatMessageType type;

  ChatMessage({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.type,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        idFrom: json['idFrom'],
        idTo: json['idTo'],
        timestamp: json['timestamp'],
        content: json['content'],
        type: json['type'],
      );
}
