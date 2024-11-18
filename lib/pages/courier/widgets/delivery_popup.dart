part of '../courier_library.dart';

/// A popup dialog for updating the status of a delivery.
///
/// The [DeliveryPopup] provides a confirmation dialog for couriers to update the
/// status of a delivery. It includes status-specific titles, content descriptions,
/// and actions.
///
/// ### Example Usage
/// ```dart
/// showDialog(
///   context: context,
///   builder: (context) => DeliveryPopup(
///     id: 123,
///     status: "PREPARING_FOR_DELIVERY",
///     onUpdated: () {
///       // Refresh delivery list or update UI.
///     },
///   ),
/// );
/// ```
class DeliveryPopup extends StatelessWidget {
  /// The current status of the delivery.
  final String status;

  /// The ID of the delivery order.
  final int id;

  /// Callback function to execute when the status is successfully updated.
  final Function onUpdated;

  /// Creates a [DeliveryPopup].
  ///
  /// - [id]: The ID of the delivery order.
  /// - [status]: The current status of the delivery.
  /// - [onUpdated]: A callback triggered after a successful status update.
  DeliveryPopup(
      {super.key,
      required this.id,
      required this.status,
      required this.onUpdated});

  /// Title text corresponding to each status.
  final Map<String, String> titleTexts = Map.from(<String, String>{
    "PREPARING_FOR_DELIVERY":
        "Вы уверены что хотите принять заявку на доставку?",
    "RECEIVED": "Вы получили заказ у скотобойни?",
    "ON_THE_WAY": "Вы доставили заказ клиенту?",
  });

  /// Content description corresponding to each status.
  final Map<String, String> contentTexts = Map.from(<String, String>{
    "PREPARING_FOR_DELIVERY":
        "Ознакомитесь с деталями заявки перед нажатием кнопки “Принять”",
    "RECEIVED":
        "Ознакомитесь с деталями заявки перед нажатием кнопки “Подтверждаю” ",
    "ON_THE_WAY":
        "После нажатия кнопки “Доставлено” клиенту будет отправлен код для получения заказа",
  });

  /// Button text corresponding to each status.
  final Map<String, String> buttonTexts = Map.from(<String, String>{
    "PREPARING_FOR_DELIVERY": "Принять",
    "RECEIVED": "Подтверждаю",
    "ON_THE_WAY": "Доставлено",
  });

  /// Updates the delivery status and returns the result status code.
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
