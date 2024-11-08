part of '../butchery_library.dart';

class ButcheryCard extends StatelessWidget {
  const ButcheryCard({super.key, required this.butchery});
  final Butchery butchery;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: GestureDetector(
          onTap: () => {
            pushWithNavBar(
              context,
              MaterialPageRoute(
                fullscreenDialog: false,
                builder: (context) =>
                    ButcheryPage(id: butchery.id.toString(), charity: true),
              ),
            )
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  'https://picsum.photos/250?image=9',
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      butchery.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
