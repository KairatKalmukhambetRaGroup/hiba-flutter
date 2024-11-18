part of '../core_library.dart';

/// A widget that displays a carousel slider with promotional items.
///
/// The [PromotionCarousel] widget fetches promotional data asynchronously and displays them in a [CarouselSlider].
/// Users can tap on a promotion to view more details about it.
///
/// {@category Core}
/// ## Example Usage
/// ```dart
/// PromotionCarousel();
/// ```
class PromotionCarousel extends StatefulWidget {
  const PromotionCarousel({super.key});

  @override
  State<StatefulWidget> createState() => _PromotionCarouselState();
}

/// State class for [PromotionCarousel].
///
/// This class manages the fetching of promotions and maintains the loading state of the widget.
class _PromotionCarouselState extends State<PromotionCarousel> {
  /// List of promotions to display in the carousel.
  List<Promotion> _promotions = [];

  /// Indicates if promotions are currently being loaded.
  bool _loading = true;

  /// The current index of the promotion being displayed.
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

  /// Loads promotional data asynchronously and updates the state accordingly.
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
