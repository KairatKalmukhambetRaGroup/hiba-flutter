part of 'butchery_library.dart';

/// A detailed view of a butchery.
///
/// The [ButcheryDetails] widget displays detailed information about a butchery,
/// including its name, contact details, address, working hours, certifications, and delivery information.
///
/// ### Example
/// ```dart
/// ButcheryDetails(
///   butchery: Butchery(
///     id: 1,
///     name: 'Halal Butchery',
///     address: '123 Butchery Lane',
///     workingHours: [
///       WorkingHour(dayOfWeek: 'Monday', openTime: '09:00', closeTime: '17:00', isClosed: false),
///       WorkingHour(dayOfWeek: 'Sunday', openTime: '', closeTime: '', isClosed: true),
///     ],
///   ),
/// );
/// ```
class ButcheryDetails extends StatefulWidget {
  /// The [Butchery] instance containing details to display.
  final Butchery butchery;

  /// Creates a [ButcheryDetails] widget.
  const ButcheryDetails({super.key, required this.butchery});

  @override
  State<StatefulWidget> createState() => _ButcheryDetailsState();
}

class _ButcheryDetailsState extends State<ButcheryDetails> {
  /// The current day of the week.
  final weekday = DateFormat('EEEE').format(DateTime.now());

  /// The working hours for the current day.
  String todayTime = '';

  @override
  void initState() {
    super.initState();

    List<WorkingHour> whs = widget.butchery.workingHours ?? [];

    for (var wh in whs) {
      if (wh.dayOfWeek.toUpperCase() == weekday.toUpperCase()) {
        setState(() {
          todayTime =
              wh.isClosed ? 'выходной' : '${wh.openTime} - ${wh.closeTime}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        backgroundColor: AppColors.bgLight,
        appBar: CustomAppBar(
          titleText: 'Скотобойня',
          context: context,
        ),
        body: ListView(
          children: [
            const SizedBox(height: 16),
            ListTile(
              tileColor: AppColors.white,

              // ignore: prefer_const_constructors
              title: Text(
                widget.butchery.name,
                style: AppTheme.blue600_16,
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(
              height: 1,
              color: AppColors.grey,
            ),
            ListTile(
              tileColor: AppColors.white,
              // ignore: prefer_const_constructors
              title: Text(
                '+7 (777) 123 4567',
                style: AppTheme.black500_14,
              ),
              leading: SvgPicture.asset(
                'assets/svg/phone.svg',
                width: 24,
              ),
            ),
            const Divider(
              height: 1,
              color: AppColors.grey,
            ),
            ListTile(
              tileColor: AppColors.white,
              title: Text(
                widget.butchery.address,
                style: AppTheme.black500_14,
              ),
              leading: SvgPicture.asset(
                'assets/svg/location.svg',
                width: 24,
              ),
            ),
            const Divider(
              height: 1,
              color: AppColors.grey,
            ),
            ExpansionTile(
              backgroundColor: AppColors.white,
              collapsedBackgroundColor: AppColors.white,
              leading: SvgPicture.asset(
                'assets/svg/food-halal.svg',
                width: 24,
              ),
              title: const Text(
                'Сертификат соответствия',
                style: AppTheme.black500_14,
              ),
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/halal-certificate-mock.png',
                        width: 120,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/images/halal-certificate-mock.png',
                        width: 120,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Divider(
              height: 1,
              color: AppColors.grey,
            ),
            ListTile(
              tileColor: AppColors.white,
              // ignore: prefer_const_constructors
              title: Text(
                'Доставка в течении 3 дней',
                style: AppTheme.black500_14,
              ),
              leading: SvgPicture.asset(
                'assets/svg/moped-outline.svg',
                width: 24,
              ),
            ),
            const Divider(
              height: 1,
              color: AppColors.grey,
            ),
            ExpansionTile(
                backgroundColor: AppColors.white,
                collapsedBackgroundColor: AppColors.white,
                leading: SvgPicture.asset(
                  'assets/svg/clock-outline.svg',
                  width: 24,
                ),
                title: Text(
                  todayTime,
                  // '09:00 - 22:00',
                  style: AppTheme.black500_14,
                ),
                children: widget.butchery.workingHours!
                    .map((workingHour) => Column(
                          children: [
                            const Divider(
                              height: 1,
                              color: AppColors.grey,
                            ),
                            ListTile(
                              title: Text(
                                workingHour.dayOfWeek,
                                style: AppTheme.black500_14,
                              ),
                              trailing: Text(
                                workingHour.isClosed
                                    ? 'выходной'
                                    : '${workingHour.openTime} - ${workingHour.closeTime}',
                                style: AppTheme.black500_14,
                              ),
                            ),
                          ],
                        ))
                    .toList()),
          ],
        ));
  }
}
