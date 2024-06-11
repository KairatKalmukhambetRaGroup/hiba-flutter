import 'dart:convert';

import 'package:hiba/entities/chat_message.dart';
import 'package:hiba/entities/hiba_chat.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hiba/entities/order.dart';
import 'package:hiba/utils/api/auth.dart';
import 'package:http/http.dart' as http;

Future<HibaChat?> createChat() async {
  String apiUrl = '${dotenv.get('API_URL')}/chats/create';

  try {
    final String? authToken = await AuthState.getAuthToken();
    if (authToken == null) {
      // Token is not available, handle accordingly
      return null;
    }

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    if (response.statusCode == 201) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final responseData =
          Map<String, dynamic>.from(json.decode(decodedBody));
      HibaChat chat = HibaChat.fromJson(responseData);
      return chat;
    }
    return null;
  } catch (e) {
    return null;
  }

}

Future<List<HibaChat>?> getChatHistory() async {
  String apiUrl = '${dotenv.get('API_URL')}/chats/history';

  try {
    final String? authToken = await AuthState.getAuthToken();
    if (authToken == null) {
      // Token is not available, handle accordingly
      return null;
    }

    final http.Response response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final responseData =
          List<Map<String, dynamic>>.from(json.decode(decodedBody));
      
      List<HibaChat> list = [];
      for(var el in responseData){
        HibaChat chat = HibaChat.fromJson(el);
        list.add(chat);
      }
      return list;
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<List<Order>?> getOrdersForChat() async {

  String apiUrl = '${dotenv.get('API_URL')}/chats/orders';

  try {
    final String? authToken = await AuthState.getAuthToken();
    if (authToken == null) {
      // Token is not available, handle accordingly
      return null;
    }

    final http.Response response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final responseData =
          List<Map<String, dynamic>>.from(json.decode(decodedBody));
      
      List<Order> list = [];
      for(var el in responseData){
        Order chat = Order.fromJson(el);
        list.add(chat);
      }
      return list;
    }
    return null;
  } catch (e) {
    return null;
  }

}




Future<List<ChatMessage>?> getMessages(String id) async {

  String apiUrl = '${dotenv.get('API_URL')}/chats/byId/$id';

  try {
    final String? authToken = await AuthState.getAuthToken();
    if (authToken == null) {
      // Token is not available, handle accordingly
      return null;
    }

    final http.Response response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final responseData = Map<String, dynamic>.from(json.decode(decodedBody));
      
      List<ChatMessage> list = [];
      for(var el in responseData['messages']){
        ChatMessage message = ChatMessage.fromJson(el);
        list.add(message);
      }
      return list;
    }
    return null;
  } catch (e) {
    return null;
  }

}


