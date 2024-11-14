part of '../courier_library.dart';

class DeliveryPopup extends StatelessWidget {
  final String status;
  final int id;
  final Function onUpdated;
  DeliveryPopup(
      {super.key,
      required this.id,
      required this.status,
      required this.onUpdated});

  final Map<String, String> titleTexts = Map.from(<String, String>{
    "PREPARING_FOR_DELIVERY":
        "Вы уверены что хотите принять заявку на доставку?",
    "RECEIVED": "Вы получили заказ у скотобойни?",
    "ON_THE_WAY": "Вы доставили заказ клиенту?",
  });

  final Map<String, String> contentTexts = Map.from(<String, String>{
    "PREPARING_FOR_DELIVERY":
        "Ознакомитесь с деталями заявки перед нажатием кнопки “Принять”",
    "RECEIVED":
        "Ознакомитесь с деталями заявки перед нажатием кнопки “Подтверждаю” ",
    "ON_THE_WAY":
        "После нажатия кнопки “Доставлено” клиенту будет отправлен код для получения заказа",
  });
  final Map<String, String> buttonTexts = Map.from(<String, String>{
    "PREPARING_FOR_DELIVERY": "Принять",
    "RECEIVED": "Подтверждаю",
    "ON_THE_WAY": "Доставлено",
  });

  Future<int> updateStatus(String newStatus) async {
    int status = await updateOrderStatus(id, newStatus);
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: AppColors.white,
      titlePadding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      actionsPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      actionsAlignment: MainAxisAlignment.center,
      title: Text(
        titleTexts[status]!,
        style: AppTheme.black600_14,
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            contentTexts[status]!,
            style: AppTheme.black500_11,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: TextButton(
                  style: const ButtonStyle(
                    alignment: Alignment.center,
                    padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                        EdgeInsets.all(14)),
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(AppColors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Отмена",
                    textAlign: TextAlign.center,
                    style: AppTheme.blue600_16,
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  style: const ButtonStyle(
                    padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                        EdgeInsets.all(14)),
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(AppColors.mainBlue),
                  ),
                  onPressed: () async {
                    if (status == 'PREPARING_FOR_DELIVERY') {
                      int status = await updateStatus("RECEIVED");
                      if (status == 200) {
                        onUpdated();
                      }
                    } else if (status == 'RECEIVED') {
                      int status = await updateStatus("ON_THE_WAY");
                      if (status == 200) {
                        onUpdated();
                      }
                    }
                    if (status == 'ON_THE_WAY') {
                      int status = await updateStatus("DELIVERED");
                      if (status == 200) {
                        onUpdated();
                      }
                    }
                  },
                  child: Text(
                    buttonTexts[status]!,
                    style: AppTheme.white600_16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
