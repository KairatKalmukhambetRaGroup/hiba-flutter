import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hiba/pages/login_page.dart';
import 'package:hiba/pages/splash_page.dart';

class Fireauth extends StatelessWidget {
  const Fireauth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const SplashPage();
            } else {
              return const LoginPage();
            }
          }),
    );
  }
}
