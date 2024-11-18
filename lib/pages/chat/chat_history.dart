part of 'chat_library.dart';

/// A page that displays the chat history.
///
/// The [ChatHistory] widget fetches and displays a list of previous chats.
/// If no chats are available, it shows an empty message. While the data is loading,
/// a loading indicator is displayed.
class ChatHistory extends StatefulWidget {
  /// Constructor for [ChatHistory].
  const ChatHistory({super.key});

  @override
  State<StatefulWidget> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  /// List of chats fetched from the server.
  List<HibaChat> _chats = [];

  /// Tracks whether the chat history is currently being loaded.
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  /// Fetches the chat history from the server.
  ///
  /// While fetching, the `isLoading` state is set to `true`.
  /// Once the data is retrieved, it updates the `_chats` list and sets `isLoading` to `false`.
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
                ? const Center(
                    child: Text('')) // Displays nothing if no chats are found.
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
