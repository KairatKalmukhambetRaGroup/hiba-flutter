import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/entities/chat_message.dart';
import 'package:hiba/providers/chat_provider.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:provider/provider.dart';

class SupportChatPage extends StatefulWidget {
  static const routeName = '/support-chat';
  const SupportChatPage({super.key});

  @override
  State<StatefulWidget> createState() => _SupportChatPageState();
}

class _SupportChatPageState extends State<SupportChatPage> {
  late final TextEditingController messageController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController()
      ..addListener(controllerListener);
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void controllerListener() {
    final phoneNumber = messageController.text;

    if (phoneNumber.isEmpty) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        shape:
            const Border(bottom: BorderSide(color: AppColors.grey, width: 1)),
        title: const Text(
          'Hiba чат',
          style: AppTheme.headingBlack600_16,
        ),
        centerTitle: true,
      ),
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.separated(
                    reverse: true,
                    itemCount: chatProvider.messages.length,
                    itemBuilder: (context, index) {
                      var message = chatProvider.messages[index];
                      return ChatMessageBubble(message: message);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                decoration: const BoxDecoration(
                  border: BorderDirectional(
                    top: BorderSide(
                        color: Color.fromARGB(255, 14, 11, 11), width: 1),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: messageController,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (text) {
                            chatProvider.sendMessage(messageController.text);
                            messageController.clear();
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            fillColor: AppColors.bgLight,
                            hintText: 'Сообщение',
                            hintStyle: AppTheme.bodyDarkGrrey500_14,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          style: AppTheme.bodyBlack500_14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      IconButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            chatProvider.sendMessage(messageController.text);
                            messageController.clear();
                          }
                        },
                        icon: SvgPicture.asset(
                          'assets/svg/send.svg',
                          width: 32,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isSentMessage = message.type == ChatMessageType.sent;

    return Row(
      mainAxisAlignment:
          isSentMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(
                isSentMessage ? 64 : 0, 0, isSentMessage ? 0 : 64, 0),
            decoration: BoxDecoration(
              color: isSentMessage ? AppColors.bgLight : AppColors.mainBlue,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(8),
                topRight: const Radius.circular(8),
                bottomLeft:
                    isSentMessage ? const Radius.circular(8) : Radius.zero,
                bottomRight:
                    isSentMessage ? Radius.zero : const Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.content,
                  style: isSentMessage
                      ? AppTheme.bodyBlack500_14
                      : AppTheme.bodyWhite500_14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      message.timestamp,
                      style: AppTheme.bodyDarkgrey500_11,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
