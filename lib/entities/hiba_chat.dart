/// lib/entities/entities_library.dart
part of 'entities_library.dart';

/// a `HibaChat` object represents a chat with details.
class HibaChat {
  /// Unique identifier of this chat.
  late int id;

  /// Id of support user of this chat.
  int? supportId;

  /// Status of this chat.
  final String chatStatus;

  /// Creation date of this chat as String.
  String? createdAt;

  /// Support user of this chat.
  User? support;

  /// Creates new `HibaChat` instance.
  HibaChat({required this.chatStatus});

  /// Creates new `HibaChat` instance from JSON object.
  factory HibaChat.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('chat')) {
      final c = json['chat'];
      HibaChat chat = HibaChat(chatStatus: c["chatStatus"]);
      if (c.containsKey('supportId') && c['supportId'] != null) {
        chat.supportId = c["supportId"];
      }
      if (c.containsKey('createdAt') && c['createdAt'] != null) {
        chat.createdAt = c["createdAt"];
      }
      if (c.containsKey('id') && c['id'] != null) {
        chat.id = c["id"];
      }

      if (json.containsKey('support') && json['support'] != null) {
        chat.support = User.fromJson(json['support']);
      }

      return chat;
    } else {
      final c = json;
      HibaChat chat = HibaChat(chatStatus: c["chatStatus"]);
      if (c.containsKey('supportId') && c['supportId'] != null) {
        chat.supportId = c["supportId"];
      }
      if (c.containsKey('createdAt') && c['createdAt'] != null) {
        chat.createdAt = c["createdAt"];
      }
      if (c.containsKey('id') && c['id'] != null) {
        chat.id = c["id"];
      }
      return chat;
    }
  }
}
