import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/custom_app_bar.dart';
import 'package:hiba/entities/entities_library.dart';
import 'package:hiba/pages/chat/chat_library.dart';
import 'package:hiba/pages/chat_history.dart';
import 'package:hiba/core_library.dart' show AppColors, AppTheme;
import 'package:hiba/utils/api/api_library.dart';

import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ContactUsPage extends StatefulWidget {
  static const routeName = '/contact-us';
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  List<HibaChat> _chats = [];

  @override
  void initState() {
    super.initState();
    fetchActiveChats();
  }

  Future<void> fetchActiveChats() async {
    try {
      final data = await getActiveChats();
      setState(() {
        if (data != null) {
          _chats = data;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Связаться с нами',
        context: context,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 64),
              _chats.isEmpty
                  ? Center(
                      child: SvgPicture.asset(
                        'assets/svg/contact-us-bg.svg',
                        width: 120,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Недавние сообщения',
                          textAlign: TextAlign.left,
                          style: AppTheme.black600_16,
                        ),
                        const SizedBox(height: 16),
                        ChatTile(
                          chat: _chats[0],
                          showBorder: true,
                        ),
                        if (_chats.length > 1)
                          Column(
                            children: [
                              const SizedBox(height: 8),
                              ChatTile(
                                chat: _chats[1],
                                showBorder: true,
                              ),
                            ],
                          ),
                      ],
                    ),
              const SizedBox(height: 25),
              const Text(
                'Связаться с поддержкой',
                style: AppTheme.black600_16,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  pushWithoutNavBar(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SupportChatPage()));
                },
                style: const ButtonStyle(
                  alignment: Alignment.center,
                  minimumSize: WidgetStatePropertyAll(Size.fromHeight(48)),
                  backgroundColor: WidgetStatePropertyAll(AppColors.red),
                ),
                child: const Text(
                  'Написать в чат',
                  style: AppTheme.white500_14,
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  pushWithNavBar(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatHistory()));
                },
                style: const ButtonStyle(
                  alignment: Alignment.center,
                  minimumSize: WidgetStatePropertyAll(Size.fromHeight(48)),
                  backgroundColor: WidgetStatePropertyAll(AppColors.mainBlue),
                ),
                child: const Text(
                  'История',
                  style: AppTheme.white500_14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
