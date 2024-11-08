import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/custom_app_bar.dart';
import 'package:hiba/entities/hiba_chat.dart';
import 'package:hiba/pages/support_chat_page.dart';
import 'package:hiba/utils/api/api_library.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

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
                    itemBuilder: (context, index) => ListTile(
                      tileColor: AppColors.white,
                      title: Text(_chats[index].chatStatus),
                      subtitle: Text(
                          '${_chats[index].support == null ? 'Hiba' : _chats[index].support!.name} - ${_chats[index].createdAt ?? ''}'),
                      trailing: SvgPicture.asset(
                        'assets/svg/chevron-right-grey.svg',
                        width: 24,
                      ),
                      onTap: () {
                        pushWithoutNavBar(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SupportChatPage(
                                      chatId: _chats[index].id.toString(),
                                    )));
                      },
                    ),
                    itemCount: _chats.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: AppColors.grey),
                  ),
      ),
    );
  }
}
