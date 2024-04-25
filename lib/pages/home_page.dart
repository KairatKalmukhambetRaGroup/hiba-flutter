import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/utils/api/location.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // AuthState authState = Provider.of<AuthState>(context);
    // User? user = authState.user;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              tileColor: AppColors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/svg/location.svg',
                    width: 24,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Алматы',
                    style: AppTheme.bodyBlack500_14,
                  ),
                ],
              ),
              trailing: SvgPicture.asset(
                'assets/svg/chevron-right-grey.svg',
                width: 24,
              ),
              onTap: () async {
                await getCities();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(height: 200.0),
                    items: [1, 2, 3, 4, 5].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration:
                                  const BoxDecoration(color: Colors.amber),
                              child: Text(
                                'Slide $i',
                                style: const TextStyle(fontSize: 16.0),
                              ));
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(16),
              tileColor: AppColors.white,
              title: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'С HIBA легко заказать домой свежее постное мясо и делать благие дела',
                      style: AppTheme.headingBlack600_14,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pushNamed('/search/charity');
                    },
                    style: const ButtonStyle(
                      alignment: Alignment.center,
                      minimumSize:
                          MaterialStatePropertyAll(Size.fromHeight(48)),
                      backgroundColor: MaterialStatePropertyAll(AppColors.red),
                    ),
                    child: const Text(
                      'На благотворительность',
                      style: AppTheme.bodyWhite500_14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/search');
                    },
                    style: const ButtonStyle(
                      alignment: Alignment.center,
                      minimumSize:
                          MaterialStatePropertyAll(Size.fromHeight(48)),
                      backgroundColor:
                          MaterialStatePropertyAll(AppColors.mainBlue),
                    ),
                    child: const Text(
                      'Для себя или близких',
                      style: AppTheme.bodyWhite500_14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


// ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             SizedBox(
//               height: 200,
//               child: ListView(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 scrollDirection: Axis.horizontal,
//                 children: const [
//                   ButcheryCardSmall(title: 'Card 1'),
//                   ButcheryCardSmall(title: 'Card 2'),
//                   ButcheryCardSmall(title: 'Card 3'),
//                   ButcheryCardSmall(title: 'Card 4'),
//                 ],
//               ),
//             ),
//             TextButton(
//                 onPressed: () async {
//                   await getUser();
//                 },
//                 child: const Text('Print user')),
//             TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pushNamed('/login');
//                 },
//                 child: const Text('login'))
//           ],
//         ),