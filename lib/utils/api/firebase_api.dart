import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

// https://youtu.be/k0zGEbiDJcQ?si=xNP2yg35OtMVZX0v
// link to tutorial to flutter notifications

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

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

  Future<String?> getToken() async {
    String? fCMToken = await _firebaseMessaging.getToken();
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

// f0UD93UXRumWLnf3Ogu77h:APA91bETUa3om_vNdD_mz6prISQPIvRwGteiAX61bhsXoHtgqDCftNgdaYEel58VTgMjfN6U4_lUbXVmieJWvVsqmAg48KIVNw1m0St-jXPCPYLj0bSKZ1rPIrSs_Ix33JLmLi3889bT
