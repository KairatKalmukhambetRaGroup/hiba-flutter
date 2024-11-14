part of 'courier_library.dart';

class Delivery extends StatelessWidget {
  final Order order;
  const Delivery({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        context: context,
        titleText: "Заказ №${order.id}",
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            const Text(
              "Отправитель",
              style: AppTheme.darkGrey500_11,
            ),
            const SizedBox(height: 8),
            Text(
              order.butchery.name,
              style: AppTheme.black600_14,
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg/location.svg',
                    width: 24, height: 24),
                const SizedBox(width: 8),
                Text(
                  "г. ${order.butchery.city?.name}, ${order.butchery.address}",
                  style: AppTheme.black500_14,
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg/phone.svg', width: 24, height: 24),
                const SizedBox(width: 8),
                Text(
                  "${order.butchery.phone}",
                  style: AppTheme.black500_14,
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg/clock-outline.svg',
                    width: 24, height: 24),
                const SizedBox(width: 8),
                const Text(
                  "Заказ можно забрать с 06:00 до 08:00",
                  style: AppTheme.black500_14,
                )
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: AppColors.grey, thickness: 1),
            const SizedBox(height: 16),
            const Text(
              "Получатель",
              style: AppTheme.darkGrey500_11,
            ),
            const SizedBox(height: 8),
            Text(
              "${order.user?.name}",
              style: AppTheme.black600_14,
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg/location.svg',
                    width: 24, height: 24),
                const SizedBox(width: 8),
                Text(
                  "г. ${order.address?.city.name}, ${order.address?.street}, дом ${order.address?.building}, кв ${order.address?.apartment}",
                  style: AppTheme.black500_14,
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg/phone.svg', width: 24, height: 24),
                const SizedBox(width: 8),
                Text(
                  "${order.user?.phone}",
                  style: AppTheme.black500_14,
                )
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: AppColors.grey, thickness: 1),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Общий вес заказа",
                  style: AppTheme.black500_14,
                ),
                Text(
                  "${order.calculateWeight()} кг",
                  style: AppTheme.black600_14,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Количество позиций",
                  style: AppTheme.black500_14,
                ),
                Text(
                  order.items.length.toString(),
                  style: AppTheme.black600_14,
                ),
              ],
            ),
            const SizedBox(height: 8),
            for (int i = 0; i < order.items.length; i++) ...[
              DeliveryItem(menuItem: order.items[i])
            ],
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
        child: TextButton(
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
                EdgeInsets.all(14)),
            backgroundColor: WidgetStatePropertyAll<Color>(
                order.orderStatus == "ON_THE_WAY"
                    ? AppColors.red
                    : AppColors.mainBlue),
          ),
          onPressed: () {},
          child: Text(
            order.orderStatus == 'PREPARING_FOR_DELIVERY'
                ? "Принять"
                : order.orderStatus == 'RECIEVED'
                    ? "Подтвердить получение"
                    : "Завершить доставку",
            style: AppTheme.white600_16,
          ),
        ),
      ),
    );
  }
}

class DeliveryItem extends StatelessWidget {
  final MenuItem menuItem;
  const DeliveryItem({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: AppColors.grey)),
      ),
      child: Row(
        children: [
          if (menuItem.image != null) ...[
            Image(
              image: MemoryImage(base64Decode(menuItem.image!)),
              height: 56,
              width: 80,
              fit: BoxFit.contain,
            ),
          ] else ...[
            Image.asset(
              'assets/images/meat.png',
              width: 80,
              height: 56,
              fit: BoxFit.contain,
            ),
          ],
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      menuItem.name,
                      style: AppTheme.black500_14,
                    ),
                    Text(
                      '${menuItem.price} ₸/${menuItem.isWholeAnimal ? 'гл' : 'кг'}',
                      style: AppTheme.blue700_14,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Реберная часть',
                  style: AppTheme.darkGrey500_11,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
