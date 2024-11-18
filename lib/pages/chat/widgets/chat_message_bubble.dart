part of '../chat_library.dart';

/// A widget representing a single chat message bubble.
///
/// The bubble aligns either to the left or right depending on whether the
/// message was sent by the client or the other participant. It also adapts
/// its appearance (background color, text alignment, etc.) based on the sender.
///
/// Example usage:
/// ```dart
/// ChatMessageBubble(
///   message: ChatMessage(
///     content: "Hello! How can I assist you?",
///     timestamp: DateTime.now(),
///     senderType: 'CLIENT',
///   ),
/// );
/// ```
class ChatMessageBubble extends StatelessWidget {
  /// The [ChatMessage] instance containing the message data.
  final ChatMessage message;

  /// Determines if the message was sent by the client.
  /// This is derived from the `senderType` field of [ChatMessage].
  bool isSentMessage = false;

  /// Constructor for [ChatMessageBubble].
  /// - Accepts a [ChatMessage] and determines the message alignment based on `senderType`.
  ChatMessageBubble({super.key, required this.message}) {
    isSentMessage = message.senderType == 'CLIENT';
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.fromLTRB(
            isSentMessage ? 64 : 0, 0, isSentMessage ? 0 : 64, 0),
        decoration: BoxDecoration(
          color: isSentMessage ? AppColors.bgLight : AppColors.mainBlue,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(8),
            topRight: const Radius.circular(8),
            bottomLeft: isSentMessage ? const Radius.circular(8) : Radius.zero,
            bottomRight: isSentMessage ? Radius.zero : const Radius.circular(8),
          ),
        ),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.content,
              textAlign: isSentMessage ? TextAlign.end : TextAlign.start,
              style:
                  isSentMessage ? AppTheme.black500_14 : AppTheme.white500_14,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  dateToTimeString(message.timestamp),
                  style: AppTheme.darkGrey500_11,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
