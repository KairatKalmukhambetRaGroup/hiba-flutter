part of 'chat_library.dart';

class SupportChatPage extends StatefulWidget {
  static const routeName = '/support-chat';
  final String? chatId;
  const SupportChatPage({super.key, this.chatId});

  @override
  State<StatefulWidget> createState() => _SupportChatPageState();
}

class _SupportChatPageState extends State<SupportChatPage> {
  late WebSocketService _webSocketService;
  late final TextEditingController messageController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<ChatMessage> messages = [];

  String? _chatId;

  List<Order> orders = [];

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

  void controllerListener() {
    final phoneNumber = messageController.text;

    if (phoneNumber.isEmpty) return;
  }

  Future<void> fetchMessages(String id) async {
    final data = await getMessages(id);
    if (data != null) {
      setState(() {
        messages = data;
      });
    }
  }

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

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  bool isSentMessage = false;
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