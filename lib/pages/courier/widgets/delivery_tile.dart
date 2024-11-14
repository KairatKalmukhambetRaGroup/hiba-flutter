part of '../courier_library.dart';

// ignore: must_be_immutable
class DeliveryTile extends StatelessWidget {
  final Order order;
  bool? fromButchery = false;
  final bool isActive;
  bool? isDone = false;
  DeliveryTile({
    super.key,
    required this.order,
    this.fromButchery,
    required this.isActive,
    this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: AppColors.grey),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Заказ №${order.id}",
                style: AppTheme.black600_14,
              ),
              TextButton(
                onPressed: () {
                  pushWithoutNavBar(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Delivery(order: order),
                    ),
                  );
                },
                child: const Text(
                  "Подробнее",
                  style: AppTheme.blue600_14,
                ),
              )
            ],
          ),
          Text(
            order.deliveryDate.toString(),
            style: AppTheme.darkGrey600_11,
          ),
          const SizedBox(height: 16),
          if (fromButchery == null || fromButchery == false) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/svg/dotA.svg', width: 24, height: 24),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.butchery.name,
                      style: AppTheme.darkGrey500_11,
                    ),
                    Text(
                        "г. ${order.butchery.city?.name}, ${order.butchery.address}")
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/svg/dotB.svg', width: 24, height: 24),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${order.user?.name}",
                    style: AppTheme.darkGrey500_11,
                  ),
                  Text(
                      "г. ${order.address?.city.name}, ${order.address?.street}, дом ${order.address?.building}, кв ${order.address?.apartment}")
                ],
              )
            ],
          ),
          if (isDone == null || isDone == false)
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DeliveryPopup(
                      id: order.id,
                      status: order.orderStatus,
                      onUpdated: () {
                        switch (order.orderStatus) {
                          case 'ON_THE_WAY':
                            pushWithoutNavBar(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DeliveryConfirm(orderId: order.id),
                              ),
                            );
                            break;
                          case 'PREPARING_FOR_DELIVERY':
                          case 'RECEIVED':
                          default:
                            Navigator.of(context).pop();
                        }
                      },
                    );
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: order.orderStatus == "ON_THE_WAY"
                      ? AppColors.red
                      : AppColors.mainBlue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  textAlign: TextAlign.center,
                  order.orderStatus == 'PREPARING_FOR_DELIVERY'
                      ? "Принять"
                      : order.orderStatus == 'RECIEVED'
                          ? "Подтвердить получение"
                          : "Завершить доставку",
                  style: AppTheme.white600_16,
                ),
              ),
            ),
        ],
      ),
    );
  }

  static Widget skeleton() {
    return Skeletonizer(
      enabled: true,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: AppColors.grey),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Заказ №000001",
                  style: AppTheme.black600_14,
                ),
                Text(
                  "Подробнее",
                  style: AppTheme.blue600_14,
                )
              ],
            ),
            const Text(
              "от 28.07.2024",
              style: AppTheme.darkGrey600_11,
            ),
            const SizedBox(height: 16),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  size: 24,
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name Surname",
                      style: AppTheme.darkGrey500_11,
                    ),
                    Text("г. City, Address, дом 1, кв 1")
                  ],
                )
              ],
            ),
            Skeleton.leaf(
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColors.mainBlue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  textAlign: TextAlign.center,
                  "Принять",
                  style: AppTheme.white600_16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}