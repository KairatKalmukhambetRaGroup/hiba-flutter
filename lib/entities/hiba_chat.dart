import 'package:hiba/entities/user.dart';

class HibaChat {
  late int id;
  int? supportId;
  final String chatStatus;
  String? createdAt;
  User? support;

  HibaChat({
    required this.chatStatus
  });

  factory HibaChat.fromJson(Map<String, dynamic> json) {
    if(json.containsKey('chat')){
      final c = json['chat'];
      HibaChat chat = HibaChat(
        chatStatus: c["chatStatus"]
      );
      if(c.containsKey('supportId') && c['supportId'] != null){
        chat.supportId = c["supportId"];
      }
      if(c.containsKey('createdAt') && c['createdAt'] != null){
        chat.createdAt = c["createdAt"];
      }
      if(c.containsKey('id') && c['id'] != null){
        chat.id = c["id"];
      }

      if(json.containsKey('support') && json['support'] != null){
        chat.support = User.fromJson(json['support']);
      }

      return chat;
    }else{
      final c = json;
      HibaChat chat = HibaChat(
        chatStatus: c["chatStatus"]
      );
      if(c.containsKey('supportId') && c['supportId'] != null){
        chat.supportId = c["supportId"];
      }
      if(c.containsKey('createdAt') && c['createdAt'] != null){
        chat.createdAt = c["createdAt"];
      }
      if(c.containsKey('id') && c['id'] != null){
        chat.id = c["id"];
      }
      return chat;
    }
  }
}