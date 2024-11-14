part of '../courier_library.dart';

class DeliveryButcheryTile extends StatelessWidget {
  final Butchery butchery;
  final bool isActive;

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