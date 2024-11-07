// lib/providers/providers_library.dart
/// @category Provider
part of 'providers_library.dart';

/// Enum representing the connection status of the user.
enum ConnectionStatus { loading, connected, disconnected }

/// A provider class for monitoring and managing the user's internet connection status.
///
/// `UserConnectionState` monitors the user's internet connection, checking if they are
/// connected to the internet or not, and updating the UI accordingly. It listens for
/// connection status changes and notifies listeners of any updates.
///
/// Example usage:
/// ```dart
/// UserConnectionState connectionState = UserConnectionState();
/// connectionState.checkConnection();
/// ```
///
/// This class checks for an internet connection by connecting to a specific server
/// (configured through `.env` file). It uses the `internet_connection_checker`
/// package for connectivity status updates.
class UserConnectionState extends ChangeNotifier {
  /// The current connection status of the user.
  ConnectionStatus connectionStatus = ConnectionStatus.loading;

  /// The subscription used to listen for internet connection status changes.
  StreamSubscription<InternetConnectionStatus>? listener;

  /// An instance of `InternetConnectionChecker` configured with custom settings.
  InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker.createInstance(
    checkTimeout: const Duration(seconds: 10), // Custom check timeout
    checkInterval: const Duration(seconds: 10), // Custom check interval
    addresses: [
      AddressCheckOptions(
          address:
              InternetAddress(dotenv.get('IP'), type: InternetAddressType.IPv4),
          port: int.tryParse(dotenv.get('PORT')) ?? 8000),
    ],
  );

  /// Starts monitoring the internet connection by listening to status changes.
  ///
  /// It listens for connection status changes and updates the `connectionStatus` accordingly.
  /// If the connection is established or lost, it triggers a UI update by calling `notifyListeners()`.
  void checkConnection() async {
    listener ??= internetConnectionChecker.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          if (connectionStatus != ConnectionStatus.connected) {
            connectionStatus = ConnectionStatus.connected;
            notifyListeners();
          }
          break;
        case InternetConnectionStatus.disconnected:
          if (connectionStatus != ConnectionStatus.disconnected) {
            connectionStatus = ConnectionStatus.disconnected;
            notifyListeners();
          }
          break;
      }
    });
  }

  /// Disposes of the stream listener when the object is no longer needed.
  @override
  void dispose() {
    super.dispose();
    if (listener != null) {
      listener?.cancel();
    }
  }
}
