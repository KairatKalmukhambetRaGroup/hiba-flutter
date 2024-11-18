part of '../courier_library.dart';

/// A widget representing a butchery with delivery information.
///
/// The [DeliveryButcheryTile] displays details about a specific butchery,
/// including its name, location, contact details, and the number of orders.
/// It provides a button to navigate to the butchery's delivery requests.
///
/// ### Example Usage
/// ```dart
/// DeliveryButcheryTile(
///   butchery: Butchery(
///     name: 'Halal Butchery',
///     city: City(name: 'Almaty'),
///     address: '123 Main St',
///     phone: '+7 777 123 4567',
///     ordersCount: 5,
///   ),
///   isActive: true,
/// );
/// ```
class DeliveryButcheryTile extends StatelessWidget {
  /// The butchery to display.
  final Butchery butchery;

  /// Indicates whether the butchery has active delivery requests.
  final bool isActive;

  /// Creates a [DeliveryButcheryTile].
  ///
  /// - [butchery]: The butchery details to display.
  /// - [isActive]: Whether the butchery has active delivery requests.
  const DeliveryButcheryTile({
    super.key,
    required this.butchery,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: AppColors.grey),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                butchery.name,
                style: AppTheme.black600_16,
              ),
              Text(
                "${butchery.ordersCount} заказов",
                style: AppTheme.darkGrey500_14,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svg/location.svg',
                  width: 24, height: 24),
              const SizedBox(width: 8),
              Text("г. ${butchery.city?.name}, ${butchery.address}")
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svg/phone.svg', width: 24, height: 24),
              const SizedBox(width: 8),
              Text("${butchery.phone}")
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  pushWithNavBar(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ButcheryDeliveries(
                              butchery: butchery, isActive: isActive)));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Доступные заявки",
                      style: AppTheme.blue600_14,
                    ),
                    SvgPicture.asset('assets/svg/chevron-right-blue.svg')
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// A skeleton placeholder for loading states.
  ///
  /// Displays a basic structure mimicking the tile while data is loading.
  static Widget skeleton() {
    return Skeletonizer(
      enabled: true,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: AppColors.grey),
          ),
        ),
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Butchery",
                  style: AppTheme.black600_16,
                ),
                Text(
                  "5 заказов",
                  style: AppTheme.darkGrey500_14,
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  size: 24,
                ),
                SizedBox(width: 8),
                Text("г. City, Address")
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  size: 24,
                ),
                SizedBox(width: 8),
                Text("8 777 123 4567")
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Доступные заявки",
                  style: AppTheme.blue600_14,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
