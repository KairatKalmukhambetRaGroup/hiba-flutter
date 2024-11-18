part of 'core_library.dart';

/// A service for managing WebSocket connections using the STOMP protocol.
///
/// The [WebSocketService] class provides methods to connect to a WebSocket server,
/// send messages, receive messages, and disconnect. It utilizes the `stomp_dart_client`
/// package to handle STOMP over WebSocket communication, enabling real-time messaging
/// capabilities within the app.
///
/// ### Example Usage
/// ```dart
/// WebSocketService webSocketService = WebSocketService(
///   onMessageReceived: (ChatMessage message) {
///     // Handle the received message.
///   },
/// );
/// await webSocketService.connect(chatId);
/// webSocketService.sendMessage("Hello, world!");
/// ```
///
class WebSocketService {
  /// The STOMP client used for WebSocket communication.
  late StompClient stompClient;

  /// The ID of the chat session.
  String? chatId;

  /// Callback function invoked when a new message is received.
  final Function(ChatMessage) onMessageReceived;

  /// Creates a [WebSocketService] with the specified [onMessageReceived] callback.
  WebSocketService({required this.onMessageReceived});

  /// Connects to the WebSocket server with the given [chatId].
  ///
  /// Retrieves the authentication token, initializes the STOMP client,
  /// and activates the connection. If an error occurs during connection,
  /// it is caught and printed in debug mode.
  Future<void> connect(String? chatId) async {
    try {
      if (chatId != null) {
        this.chatId = chatId;

        final String? authToken = await AuthState.getAuthToken();

        stompClient = StompClient(
          config: StompConfig.sockJS(
            stompConnectHeaders: {'Authorization': 'Bearer $authToken'},
            url: '${dotenv.get('API_URL')}/ws',
            onConnect: onConnect,
            // ignore: avoid_print
            onWebSocketError: (dynamic error) => print(error.toString()),
          ),
        );

        stompClient.activate();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  /// Activates the STOMP client connection.
  void activate() {
    stompClient.activate();
  }

  /// Callback method invoked when the STOMP client connects.
  ///
  /// Subscribes to the chat destination and listens for incoming messages.
  /// When a message is received, it is deserialized and passed to the
  /// [onMessageReceived] callback.
  void onConnect(StompFrame frame) {
    stompClient.subscribe(
      destination: '/queue/chat/$chatId',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          final message = ChatMessage.fromJson(jsonDecode(frame.body!));
          onMessageReceived(message);
        }
      },
    );
  }

  /// Sends a [message] to the WebSocket server.
  ///
  /// Activates the client if it is not already active and sends the message
  /// to the specified destination.
  void sendMessage(String message) {
    stompClient.activate();
    stompClient.send(
      destination: '/app/chat',
      body: message,
    );
  }

  /// Disconnects the STOMP client from the WebSocket server.
  ///
  /// Deactivates the client if it is currently active.
  void disconnect() {
    if (stompClient.isActive) {
      stompClient.deactivate();
    }
  }
}
