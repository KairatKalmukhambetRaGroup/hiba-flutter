// ignore_for_file: use_build_context_synchronously
/// lib/pages/auth/auth_library.dart
part of 'auth_library.dart';

/// A page for verifying a user's phone number via a confirmation code.
///
/// The [CodeVerificationPage] is used during the login or registration process to
/// verify the phone number provided by the user. Users receive a confirmation code via
/// Telegram and enter it on this page for validation.
///
/// ### Example Usage
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => const CodeVerificationPage(phone: "+1234567890"),
///   ),
/// );
/// ```
class CodeVerificationPage extends StatefulWidget {
  /// The phone number for which the confirmation code is being verified.
  final String? phone;

  /// Creates a [CodeVerificationPage].
  ///
  /// - [phone]: The phone number to verify.
  const CodeVerificationPage({super.key, this.phone});

  @override
  State<StatefulWidget> createState() => _CodeVerificationPageState();
}

/// The state class for [CodeVerificationPage].
///
/// Manages code entry, countdown timers, and interaction with the authentication flow.
class _CodeVerificationPageState extends State<CodeVerificationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> codeNotifier = ValueNotifier(true);

  late final TextEditingController codeController;

  /// Tracks whether the confirmation code has been sent.
  bool _codeSend = false;

  /// Tracks whether the user can request the code again.
  bool _sendCodeAgain = false;

  /// Countdown for the resend timer.
  int _countdown = 60;

  /// The phone number being verified.
  String _phone = '';

  /// Timer for the countdown.
  Timer countdownTimer = Timer.periodic(Duration.zero, (timer) {});

  /// Validates the code input and updates the notifier.
  void controllerListener() {
    final code = codeController.text;

    if (code.isEmpty) return;

    if (code.length == 4) {
      codeNotifier.value = true;
    } else {
      codeNotifier.value = false;
    }
  }

  /// Disposes of controllers and other resources.
  void disposeControllers() {
    codeController.dispose();
  }

  @override
  void initState() {
    codeController = TextEditingController()..addListener(controllerListener);
    super.initState();
    initPhone();
  }

  /// Initializes the phone number from the widget's property.
  initPhone() async {
    if (widget.phone != null) {
      setState(() {
        _phone = widget.phone ?? '';
      });
    }
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
    if (countdownTimer.isActive) {
      countdownTimer.cancel();
    }
  }

  // ignore: unused_element
  _launchTelegram() async {
    // const String telegramBotUsername = 'RAGroup_Wave_bot';
    // final String dataToSend = 'Hello';
    String url = 'https://t.me/HiibaBot?start=$_phone';

    try {
      if (!await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalApplication)) {
        // showToast(sSomethingWrong);
        // print('error');
      }
    } catch (ex) {
      // print("Could not launch url $ex");
    }
  }

  /// Starts a countdown timer for requesting the code again.
  void _startCountdown() {
    const oneSecond = Duration(seconds: 1);
    Timer tm = Timer.periodic(oneSecond, (timer) {
      if (_countdown == 0) {
        setState(() {
          _sendCodeAgain = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
    setState(() {
      countdownTimer = tm;
    });
  }

  /// Formats the countdown timer to display as minutes and seconds.
  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    String time = formatTime(_countdown);
    AuthState authState = Provider.of<AuthState>(context);

    const defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.mainBlue,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.red, width: 2),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      key: _scaffoldKey,
      appBar: CustomAppBar(
        context: context,
        titleText: 'Подтверждение',
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: _codeSend
              ? Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'Сообщение с кодом подтверждения отправлен на  $_phone',
                        textAlign: TextAlign.center,
                        style: AppTheme.black400_16,
                      ),
                      const SizedBox(height: 40),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Pinput(
                          controller: codeController,
                          defaultPinTheme: defaultPinTheme,
                          separatorBuilder: (i) => const SizedBox(width: 12),
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          validator: (value) {
                            // int status = await AuthAPI.confirmCode(_phone, value!);
                            // AuthSta

                            // // error
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     backgroundColor: Colors.transparent,
                            //     elevation: 0,
                            //     behavior: SnackBarBehavior.floating,
                            //     content: Container(
                            //       decoration: const BoxDecoration(
                            //         color: AppColors.red,
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(8)),
                            //       ),
                            //       padding: const EdgeInsets.all(12),
                            //       child: Row(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.center,
                            //         children: [
                            //           IconButton(
                            //             padding: EdgeInsets.zero,
                            //             onPressed: () {
                            //               ScaffoldMessenger.of(context)
                            //                   .hideCurrentSnackBar();
                            //             },
                            //             iconSize: 16,
                            //             icon: SvgPicture.asset(
                            //               'assets/svg/error-x.svg',
                            //               width: 16,
                            //               height: 16,
                            //             ),
                            //           ),
                            //           const SizedBox(width: 8),
                            //           const Text(
                            //             'Неверный код. Попробуйте еще раз',
                            //             style: AppTheme.white500_14,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // );

                            // Navigator.of(context)
                            //     .pushNamed(RegisterProfile.routeName);
                            // formKey.currentState!.validate();
                            return null;
                          },
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) async {
                            String phone = _phone.split('+')[1];
                            int status =
                                await authState.confirmCode(phone, pin);
                            if (status == 201) {
                              if (authState.isCourier) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CourierLogin()));
                              } else {
                                Navigator.of(context).pushNamed('/');
                              }
                            } else if (status == 200) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterProfile(
                                            phone: phone,
                                          )));
                            }
                          },
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              border: const Border(
                                bottom:
                                    BorderSide(color: AppColors.grey, width: 2),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      // TextButton(
                      //     onPressed: () {
                      //       Navigator.of(context).pushNamed(
                      //           '/register-profile/${_phone.split('+')[1]}');
                      //     },
                      //     child: const Text(
                      //       'Отправить повторно',
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(
                      //           color: AppColors.mainBlue,
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.w500),
                      //     )),
                      _sendCodeAgain
                          ? TextButton(
                              onPressed: _sendCodeAgain
                                  ? () {
                                      setState(() {
                                        _codeSend = true;
                                        _sendCodeAgain = false;
                                        _countdown = 60;
                                        _startCountdown();
                                      });
                                    }
                                  : null,
                              child: const Text(
                                'Отправить повторно',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.mainBlue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ))
                          : Column(
                              children: [
                                const Text(
                                  'Отправить повторно',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColors.darkGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  time,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: AppColors.darkGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Выберите способ отправки кода на ваш номер телефона $_phone',
                      textAlign: TextAlign.center,
                      style: AppTheme.black400_16,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 48,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color(0xff29ABE2),
                          Color(0xff0078E7),
                        ]),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton.icon(
                        onPressed: () async {
                          setState(() {
                            _codeSend = true;
                            _startCountdown();
                          });
                          _launchTelegram();
                        },
                        label: Ink(
                          child: const Text(
                            'Telegram',
                            style: AppTheme.white500_16,
                          ),
                        ),
                        icon: SvgPicture.asset('assets/svg/telegram.svg'),
                        // style: ButtonStyle(backgroundBuilder: ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
