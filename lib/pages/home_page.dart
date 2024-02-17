import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hiba/components/butchery_card_small.dart';
import 'package:hiba/entities/user.dart';
import 'package:hiba/utils/api/auth.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';
  const HomePage({super.key});

  Future<void> getUser() async {
    // ignore: unused_local_variable
    User? user = await getUserData();

    // print(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recomendations'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 200,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              scrollDirection: Axis.horizontal,
              children: const [
                ButcheryCardSmall(title: 'Card 1'),
                ButcheryCardSmall(title: 'Card 2'),
                ButcheryCardSmall(title: 'Card 3'),
                ButcheryCardSmall(title: 'Card 4'),
              ],
            ),
          ),
          TextButton(
              onPressed: () async {
                await getUser();
              },
              child: const Text('Print user')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: const Text('login'))
        ],
      ),
    );
  }
}
