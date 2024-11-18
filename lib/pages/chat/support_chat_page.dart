part of 'chat_library.dart';

/// A page for the support chat interface.
///
/// The [SupportChatPage] manages WebSocket communication for real-time chat functionality,
/// displays a list of chat messages, and provides an input field for sending messages.
class SupportChatPage extends StatefulWidget {
  /// The ID of the chat to connect to.
  final String? chatId;

  /// Constructor for [SupportChatPage].
  ///
  /// - [chatId]: Optional. If provided, connects to the specified chat.
  const SupportChatPage({super.key, this.chatId});

  @override
  State<StatefulWidget> createState() => _SupportChatPageState();
}

class _SupportChatPageState extends State<SupportChatPage> {
  /// Instance of [WebSocketService] for handling WebSocket communication.
  late WebSocketService _webSocketService;

  /// Text controller for managing the input field.
  late final TextEditingController messageController;

  /// Global key for validating the message input form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// List of messages in the chat.
  List<ChatMessage> messages = [];

  /// The ID of the current chat session.
  String? _chatId;

  /// List of associated orders (optional).
  List<Order> orders = [];

  /// Callback invoked when a new message is received via WebSocket.
  ///
  /// Updates the `messages` list and refreshes the UI.
  void _onMessageReceived(ChatMessage message) {
    setState(() {
      print("new message");
      messages.insert(0, message);
    });
  }

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController()
      ..addListener(controllerListener);
    _webSocketService = WebSocketService(onMessageReceived: _onMessageReceived);
    if (widget.chatId != null) {
      _webSocketService.connect(widget.chatId);
      fetchMessages(widget.chatId!);
      setState(() {
        _chatId = widget.chatId;
      });
    }
    // if(chatId == null){
    //   fetchOrders();
    // }
  }

  // Future<void> fetchOrders() async {
  //   List<Order>? data = await getOrdersForChat();
  //   if(data != null){
  //     setState(() {
  //       orders = data;
  //     });
  //   }
  // }

  @override
  void dispose() {
    messageController.dispose();
    _webSocketService.disconnect();
    super.dispose();
  }

  /// Listener for the message input controller.
  ///
  /// Currently unused, but can be used for input validation or additional logic.
  void controllerListener() {
    final phoneNumber = messageController.text;

    if (phoneNumber.isEmpty) return;
  }

  /// Fetches messages for the current chat session.
  ///
  /// - [id]: The chat ID.
  Future<void> fetchMessages(String id) async {
    final data = await getMessages(id);
    if (data != null) {
      setState(() {
        messages = data;
      });
    }
  }

  /// Sends a message to the current chat session.
  ///
  /// If no chat session exists, creates a new one.
  ///
  /// - [message]: The message content.
  void sendMessage(String message) async {
    if (message.isNotEmpty) {
      if (_chatId == null) {
        final data = await createChat();
        if (data != null) {
          final id = data.id;
          setState(() {
            _chatId = id.toString();
          });
          await _webSocketService.connect(id.toString());
          _webSocketService.activate();
          ChatMessage cm = ChatMessage(
              content: message, senderType: 'CLIENT', chat: id.toString());
          _webSocketService.sendMessage(cm.toString());
        }
      } else {
        ChatMessage cm =
            ChatMessage(content: message, senderType: 'CLIENT', chat: _chatId!);
        _webSocketService.activate();

        _webSocketService.sendMessage(cm.toString());
      }
    }
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          titleText: 'Hiba чат',
          context: context,
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: ListView.separated(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return ChatMessageBubble(message: messages[index]);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                ),
              ),
            ),

            /// Message input field and send button.
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
                          sendMessage(messageController.text);
                          messageController.clear();
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          fillColor: AppColors.bgLight,
                          hintText: 'Сообщение',
                          hintStyle: AppTheme.darkGrey500_14,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                        style: AppTheme.black500_14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          sendMessage(messageController.text);
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
        ));
  }
}
