import 'package:flutter/material.dart';
import 'package:hiba/components/custom_scaffold.dart';
import 'package:hiba/pages/basket_page.dart';
import 'package:hiba/pages/home_page.dart';
import 'package:hiba/pages/profile/profile_page.dart';
import 'package:hiba/providers/navigation_bar_state.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationBarState>(
      builder: (context, navigationBarState, _) {
        return CustomScaffold(
          body: const <Widget>[
            HomePage(),
            BasketPage(),
            ProfilePage(),
          ][navigationBarState.currentPageIndex],
        );
      },
    );
  }
}
