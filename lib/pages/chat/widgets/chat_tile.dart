part of '../chat_library.dart';

/// Widget representing Tile with [HibaChat]'s data.
///
class ChatTile extends StatelessWidget {
  final HibaChat chat;
  final bool showBorder;
  ChatMessage? lastMessage;
  User? sender;
  bool senderIsClient = false;
  ChatTile({
    super.key,
    required this.chat,
    this.showBorder = false,
  }) {
    lastMessage = chat.lastMessage;
    if (lastMessage != null) {
      if (lastMessage!.senderType == 'SUPPORT') {
        sender = chat.support;
      } else {
        senderIsClient = true;
      }
    } else {
      sender = chat.support;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: showBorder
          ? RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: AppColors.grey),
              borderRadius: BorderRadius.circular(8.0),
            )
          : null,
      tileColor: AppColors.white,
      title: lastMessage == null
          ? Text(chat.chatStatus)
          : Text(lastMessage!.content),
      subtitle: lastMessage == null
          ? Text(
              '${sender == null ? 'Hiba' : chat.support!.name} - ${howLongAgo(chat.createdAtDate)}')
          : Text(
              '${senderIsClient ? 'Вы' : (sender == null ? 'Hiba' : sender!.name)} - ${howLongAgoString(lastMessage!.timestamp)}'),
      trailing: SvgPicture.asset(
        'assets/svg/chevron-right-grey.svg',
        width: 24,
      ),
      onTap: () {
        pushWithoutNavBar(
          context,
          MaterialPageRoute(
            builder: (context) => SupportChatPage(
              chatId: chat.id.toString(),
            ),
          ),
        );
      },
    );
  }
}
