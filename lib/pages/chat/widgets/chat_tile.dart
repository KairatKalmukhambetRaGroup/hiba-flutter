part of '../chat_library.dart';

/// Widget representing a tile with [HibaChat]'s data.
///
/// Displays the chat's last message, sender information, and the time since the last message.
/// Supports optional border styling and handles navigation to the chat page on tap.
class ChatTile extends StatelessWidget {
  /// The [HibaChat] instance containing chat data.
  final HibaChat chat;

  /// Whether to display a border around the tile.
  final bool showBorder;

  /// The last message in the chat.
  ChatMessage? lastMessage;

  /// The sender of the last message.
  User? sender;

  /// Indicates whether the sender of the last message is the client.
  bool senderIsClient = false;

  /// Constructor for [ChatTile].
  ///
  /// - [chat]: The chat data to display.
  /// - [showBorder]: Optional. Defaults to `false`.
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
