import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hiba/core_library.dart';
import 'package:hiba/pages/chat/chat_library.dart';
import 'package:hiba/providers/providers_library.dart';
import 'package:hiba/utils/api/api_library.dart';
import 'package:hiba/utils/utils_library.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set Portrait Up orientation for all platforms.
  if (Platform.isAndroid) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  } else {
    // TODO: Set orientation in Info.plist for iOS (manual step).
  }

  // Initiaalize Firebase.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Firebase Notifications.
  await FirebaseApi().initNotifications();

  // Load environmental variables.
  await dotenv.load(fileName: '.env');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthState()),
      ChangeNotifierProvider(create: (_) => UserConnectionState()),
      ChangeNotifierProvider(create: (_) => ShoppingBasket()),
      ChangeNotifierProvider(create: (_) => ChatProvider()),
      ChangeNotifierProvider(create: (_) => AddressState()),
    ],
    child: const MyApp(),
  ));
}

/// Main class of application.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => MyAppState();
}

/// Main State class, responsible for initialization of Firebase Notification functions and more.
class MyAppState extends State<MyApp> {
  /// Responsible for handling messages/notifications from firebase.
  late final FirebaseMessaging firebaseMessaging;

  /// Init [firebaseMessaging] and it's functions for handling messages.
  @override
  void initState() {
    super.initState();

    // Get instance of [FirebaseMessaging] when app is opened.
    firebaseMessaging = FirebaseMessaging.instance;

    // Request permission for notifications.
    firebaseMessaging.requestPermission();

    // Get the initial message if the app is opened from a terminated state.
    firebaseMessaging.getInitialMessage().then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        handleFirebaseMessage(remoteMessage);
      }
    });
    // Listen for foreground messages.
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      // print('Received a message while in the foreground!');
      handleFirebaseMessage(remoteMessage);
    });
    // Listen for when the app is in the background.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      // print('Message clicked!');
      handleFirebaseMessage(remoteMessage);
    });
  }

  /// Handle messages from [FirebaseMessaging], accepts [RemoteMessage] as parameter.
  /// Renavigates to respected page based on 'type' and 'id' inside of 'data' received from [remoteMessage].
  void handleFirebaseMessage(RemoteMessage remoteMessage) {
    // Access data payload
    if (remoteMessage.data.isNotEmpty) {
      // Get type and id from data
      String? type = remoteMessage.data['type'];
      String? id = remoteMessage.data['id'];

      // Renavigates to respected page based on [type] of message, and passes [id] to determine exact content of page.
      if (type != null && type == 'USER_MESSAGES' && id != null) {
        if (NavigationHelper.key.currentContext != null) {
          pushWithoutNavBar(
            NavigationHelper.key.currentContext!,
            MaterialPageRoute(
                builder: (context) => SupportChatPage(chatId: id)),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // AuthState authState = Provider.of<AuthState>(context);
    // UserConnectionState userConnectionState =
    //     Provider.of<UserConnectionState>(context);
    // userConnectionState.checkConnection();

    return MaterialApp(
      // Turn off banner of debug mode.
      debugShowCheckedModeBanner: false,
      title: AppStrings.loginAndRegister,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      //TODO: Add multilanguage support: kazakh and russian.
      supportedLocales: const [
        Locale('ru'),
        Locale('kk'),
      ],
      theme: AppTheme.themeData,
      initialRoute: '/',
      home: const SplashPage(),
      scaffoldMessengerKey: SnackbarHelper.key,
      navigatorKey: NavigationHelper.key,
    );
  }
}
