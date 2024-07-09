import 'dart:convert';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:hiba/entities/promotion.dart';
import 'package:hiba/pages/promotion_page.dart';
import 'package:hiba/utils/api/promotion.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class PromotionCarousel extends StatefulWidget {
  const PromotionCarousel({super.key});

  @override
  State<StatefulWidget> createState() => _PromotionCarouselState();
}

class _PromotionCarouselState extends State<PromotionCarousel> {
  List<Promotion> _promotions = [];
  bool _loading = true;

  int _current = 0;

  @override
  void initState() {
    super.initState();
    loadPromotions();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> loadPromotions() async {
    if (!mounted) return;
    setState(() {
      _loading = true;
    });
    final data = await getPromotions();
    if (data != null) {
      if (!mounted) return;
      setState(() {
        _promotions = data;
      });
    }
    if (!mounted) return;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: _loading
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(
                  color: AppColors.mainBlue,
                ),
              ),
            )
          : _promotions.isEmpty
              ? null
              : Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        enableInfiniteScroll: _promotions.length > 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      items: _promotions.map(
                        (promo) {
                          return Builder(
                            builder: (BuildContext context) {
                              return InkWell(
                                onTap: () {
                                  pushWithoutNavBar(
                                    context,
                                    MaterialPageRoute(
                                      fullscreenDialog: false,
                                      builder: (context) =>
                                          PromotionPage(promotion: promo),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: MemoryImage(
                                          base64Decode(promo.image)),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ).toList(),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _promotions.asMap().entries.map((entry) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == entry.key
                                ? AppColors.mainBlue
                                : AppColors.grey,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
    );
  }
}
