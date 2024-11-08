part of '../order_library.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        tileColor: AppColors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                order.orderStatus,
                style: AppTheme.blue600_14,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // child: SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/meat.png',
                    width: 96,
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                  Image.asset(
                    'assets/images/meat.png',
                    width: 96,
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                  Image.asset(
                    'assets/images/meat.png',
                    width: 96,
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                ],
                // ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Заказ №${order.id}',
                    style: AppTheme.black500_11,
                  ),
                  // ignore: prefer_const_constructors
                  Text(
                    '${order.totalPrice} ₸',
                    style: AppTheme.blue700_14,
                  ),
                ],
              ),
            ),
            if (order.address != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  order.address!.info,
                  style: AppTheme.black500_11,
                ),
              ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: AppColors.grey),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 44,
                width: double.infinity,
                child: InkResponse(
                  onTap: () {
                    pushWithNavBar(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: false,
                          builder: (context) => OrderPage(order: order)),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Детали заказа',
                        style: AppTheme.blue500_14,
                      ),
                      SvgPicture.asset(
                        'assets/svg/chevron-right-grey.svg',
                        width: 24,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}