import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/custom_app_bar.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:hiba/utils/api/auth.dart';

class CodeVerificationPage extends StatefulWidget {
  static const routeName = '/code-verification';
  const CodeVerificationPage({super.key, this.phone});
  final String? phone;

  @override
  State<StatefulWidget> createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> codeNotifier = ValueNotifier(true);

  late final TextEditingController codeController;

  bool _codeSend = false;
  bool _sendCodeAgain = false;

  int _countdown = 60;
  String _phone = '';

  void controllerListener() {
    final code = codeController.text;

    if (code.isEmpty) return;

    if (code.length == 4) {
      codeNotifier.value = true;
    } else {
      codeNotifier.value = false;
    }
  }

  void disposeControllers() {
    codeController.dispose();
  }

  @override
  void initState() {
    codeController = TextEditingController()..addListener(controllerListener);
    super.initState();
    initPhone();
  }

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

  void _startCountdown() {
    const oneSecond = Duration(seconds: 1);
    Timer.periodic(oneSecond, (timer) {
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
  }

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
                        style: AppTheme.headingBlack400_16,
                      ),
                      const SizedBox(height: 40),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Pinput(
                          controller: codeController,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsUserConsentApi,
                          listenForMultipleSmsOnAndroid: true,
                          defaultPinTheme: defaultPinTheme,
                          separatorBuilder: (i) => const SizedBox(width: 12),
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          validator: (value) {
                            // int status =
                            //     await AuthAPI.confirmCode(_phone, value!);

                            // error
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
                            //             style: AppTheme.bodyWhite500_14,
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
                            print(_phone);

                            String phone = _phone.split('+')[1];
                            int status =
                                await authState.confirmCode(phone, pin);
                            print(status);
                            if (status == 201) {
                              Navigator.of(context).pushNamed('/');
                            } else if (status == 200) {
                              Navigator.of(context)
                                  .pushNamed('/register-profile/${phone}');
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
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                '/register-profile/${_phone.split('+')[1]}');
                          },
                          child: const Text(
                            'Отправить повторно',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.mainBlue,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          )),
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
                      style: AppTheme.headingBlack400_16,
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
                            style: AppTheme.headingWhite500_16,
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
