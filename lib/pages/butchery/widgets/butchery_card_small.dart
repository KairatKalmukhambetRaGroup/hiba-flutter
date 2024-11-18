part of '../butchery_library.dart';

/// A small card widget representing a butchery.
///
/// The [ButcheryCardSmall] displays an image and a title, designed for compact layouts
/// where a simple representation of a butchery is needed.
class ButcheryCardSmall extends StatelessWidget {
  /// The title to display on the card.
  final String title;

  /// Creates a [ButcheryCardSmall].
  ///
  /// - [title]: The title to display at the bottom of the card.
  const ButcheryCardSmall({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 250,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              'https://picsum.photos/250?image=9',
              width: 250,
              height: 150,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
