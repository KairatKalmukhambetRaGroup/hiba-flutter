part of 'chat_library.dart';

/// A page allowing users to contact support or view recent chat history.
///
/// The [ContactUsPage] displays active chats, recent messages, and options to
/// start a new support chat or view chat history.
class ContactUsPage extends StatefulWidget {
  /// Constructor for [ContactUsPage].
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  /// List of active chats fetched from the server.
  List<HibaChat> _chats = [];

  @override
  void initState() {
    super.initState();
    fetchActiveChats();
  }

  /// Fetches the active chats from the server.
  ///
  /// Updates the `_chats` list with the data retrieved.
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

              /// Displays recent active chats or a placeholder image if none exist.
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

              /// Section to contact support.
              const Text(
                'Связаться с поддержкой',
                style: AppTheme.black600_16,
              ),
              const SizedBox(height: 16),

              /// Button to start a new chat with support.
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

              /// Button to view chat history.
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
