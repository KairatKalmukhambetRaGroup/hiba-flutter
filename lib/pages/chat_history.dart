import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hiba/components/custom_app_bar.dart';
import 'package:hiba/entities/entities_library.dart';
import 'package:hiba/pages/chat/chat_library.dart';
import 'package:hiba/utils/api/api_library.dart';
import 'package:hiba/core_library.dart' show AppColors;

class ChatHistory extends StatefulWidget {
  static const routeName = '/chat-history';
  const ChatHistory({super.key});

  @override
  State<StatefulWidget> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  List<HibaChat> _chats = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    setState(() {
      isLoading = true;
    });
    final data = await getChatHistory();
    setState(() {
      if (data != null) {
        _chats = data;
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'История',
        context: context,
      ),
      body: Container(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : _chats.isEmpty
                ? const Center(child: Text(''))
                : ListView.separated(
                    itemBuilder: (context, index) =>
                        ChatTile(chat: _chats[index]),
                    itemCount: _chats.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: AppColors.grey),
                  ),
      ),
    );
  }
}
