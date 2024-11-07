// lib/providers/providers_library.dart
/// @category Provider
part of 'providers_library.dart';

/// A provider class for managing chat messages and WebSocket connections.
///
/// `ChatProvider` connects to a WebSocket server, listens for incoming chat messages,
/// and allows sending messages. This class maintains a list of chat messages and notifies listeners
/// of updates for UI purposes.
///
/// Example usage:
/// ```dart
/// ChatProvider chatProvider = ChatProvider();
/// chatProvider.sendMessage('Hello, world!');
/// ```
///
/// Ensure to dispose of the provider to close the WebSocket connection when it's no longer needed.

class ChatProvider extends ChangeNotifier {
  /// The WebSocket server URL.
  final String serverUrl = '${dotenv.get('API_URL')}/ws';

  /// The socket for handling WebSocket events (currently not in use).
  late io.Socket socket;

  /// The WebSocket channel for real-time communication with the server.
  late WebSocketChannel _channel;

  /// Internal list of chat messages.
  final List<ChatMessage> _messages = [];

  /// Returns a reversed list of chat messages to display most recent messages first.
  List<ChatMessage> get messages => _messages.reversed.toList();

  /// Initializes the WebSocket connection and begins listening for messages.
  ChatProvider() {
    _initWebSocket();
  }

  /// Initializes the WebSocket channel and listens for incoming messages.
  ///
  /// The `_initWebSocket` method connects to the WebSocket server at the specified URL,
  /// listening for messages and handling them with `_handleMessage`.
  void _initWebSocket() {
    _channel = WebSocketChannel.connect(Uri.parse('wss://localhost:8080/ws'));
    _channel.stream.listen((message) {
      _handleMessage(message);
    });
  }

  /// Sends a message through the WebSocket connection.
  ///
  /// This method currently only notifies listeners and does not add a message
  /// to `_messages`. To send a message, uncomment the `_channel.sink.add(message);` line
  /// and modify `_messages` to include the new message as needed.
  ///
  /// - [message] The text message to send.
  void sendMessage(String message) {
    // _channel.sink.add(message);
    // _messages.add(ChatMessage(
    //     idFrom: 1,
    //     idTo: 2,
    //     timestamp: 'today',
    //     content: message,
    //     type: ChatMessageType.sent));
    notifyListeners();
  }

  /// Handles incoming messages by decoding and adding them to the chat list.
  ///
  /// This method is called whenever a new message is received from the WebSocket server.
  /// It decodes the message using [ChatMessage.fromJson] and adds it to `_messages`.
  ///
  /// - [message] The message data received from the WebSocket server.
  void _handleMessage(dynamic message) {
    _messages.add(ChatMessage.fromJson(message));
    notifyListeners();
  }

  /// Closes the WebSocket connection.
  ///
  /// Ensures the WebSocket connection is closed when `ChatProvider` is disposed.
  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  // Uploads an image file (implementation for Firebase, currently commented out).
  // The `uploadImageFile` method is intended for uploading images,
  // but it currently needs modification to be compatible with the chat server.
  //
  // UploadTask uploadImageFile(File image, String filename) {
  //    Reference reference = firebaseStorage.ref().child(filename);
  //    UploadTask uploadTask = reference.putFile(image);
  //  return uploadTask;
  // }
}
