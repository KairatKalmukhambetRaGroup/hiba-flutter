import 'package:firebase_messaging/firebase_messaging.dart';

// https://youtu.be/k0zGEbiDJcQ?si=xNP2yg35OtMVZX0v
// link to tutorial to flutter notifications

/// Handle Firebase [message] that was received when app was on background.
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

/// Initialize firebase message handling service.
class FirebaseApi {
  /// Instance of [FirebaseMessaging].
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  /// Initialize message handlers.
  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Request permission for iOS
    //   _firebaseMessaging.requestPermission();

    //   // Get the initial message if the app is opened from a terminated state
    //   _firebaseMessaging.getInitialMessage().then((RemoteMessage? remoteMessage) {
    //     if (remoteMessage != null) {
    //       print("remote message");
    //       handleFirebaseMessage(remoteMessage);
    //     }
    //   });
    //   // Listen for foreground messages
    //   // FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
    //   //   print('Received a message while in the foreground!');
    //   //   handleFirebaseMessage(remoteMessage);
    //   // });
    //   // Listen for when the app is in the background
    //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
    //     print('Message clicked!');
    //     handleFirebaseMessage(remoteMessage);
    //   });
  }

  /// Retreive FCM token.
  Future<String?> getToken() async {
    String? fCMToken = await firebaseMessaging.getToken();
    return fCMToken;
  }

  // void handleFirebaseMessage(RemoteMessage remoteMessage) {
  //   // Access data payload
  //   if (remoteMessage.data.isNotEmpty) {
  //     // Handle your custom data as needed
  //     String? type = remoteMessage.data['type'];
  //     String? id = remoteMessage.data['id'];

  //     print("Data: ${remoteMessage.data}");

  //     // if (type != null && type == 'USER_MESSAGES' && id != null) {
  //     // pushWithoutNavBar(
  //     //   context,
  //     //   MaterialPageRoute(builder: (context) => SupportChatPage(chatId: id)),
  //     // );
  //     // }
  //   }
  // }
}
