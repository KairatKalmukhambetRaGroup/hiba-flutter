import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:hiba/pages/splash_page.dart';
import 'package:hiba/pages/support_chat_page.dart';
import 'package:hiba/providers/address_state.dart';
import 'package:hiba/providers/chat_provider.dart';
import 'package:hiba/providers/navigation_bar_state.dart';
import 'package:hiba/providers/shopping_basket.dart';
import 'package:hiba/providers/user_connection_state.dart';
import 'package:hiba/utils/api/firebase_api.dart';
import 'package:hiba/utils/helpers/navigation_helper.dart';
import 'package:hiba/utils/helpers/snackbar_helper.dart';
import 'package:hiba/values/app_strings.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:hiba/utils/api/auth.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  } else {
    // Set orientation in Info.plist for iOS (manual step)
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();

  await dotenv.load(fileName: '.env');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NavigationBarState()),
      ChangeNotifierProvider(create: (_) => AuthState()),
      ChangeNotifierProvider(create: (_) => UserConnectionState()),
      ChangeNotifierProvider(create: (_) => ShoppingBasket()),
      ChangeNotifierProvider(create: (_) => ChatProvider()),
      ChangeNotifierProvider(create: (_) => AddressState()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final FirebaseMessaging _firebaseMessaging;

  @override
  void initState() {
    super.initState();

    // FirebaseMessaging.onBackgroundMessage( (remoteMessage) => handleFirebaseMessage(remoteMessage));
    _firebaseMessaging = FirebaseMessaging.instance;

    // Request permission for iOS
    _firebaseMessaging.requestPermission();

    // Get the initial message if the app is opened from a terminated state
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        handleFirebaseMessage(remoteMessage);
      }
    });
    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      print('Received a message while in the foreground!');
      handleFirebaseMessage(remoteMessage);
    });
    // Listen for when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      print('Message clicked!');
      handleFirebaseMessage(remoteMessage);
    });
  }

  void handleFirebaseMessage(RemoteMessage remoteMessage) {
    // Access data payload
    if (remoteMessage.data.isNotEmpty) {
      // Handle your custom data as needed
      String? type = remoteMessage.data['type'];
      String? id = remoteMessage.data['id'];

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
      debugShowCheckedModeBanner: false,
      title: AppStrings.loginAndRegister,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
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
