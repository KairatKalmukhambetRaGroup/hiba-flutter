import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hiba/components/custom_app_bar.dart';
import 'package:hiba/components/custom_scaffold.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:pinput/pinput.dart';

class DeliveryConfirm extends StatefulWidget {
  const DeliveryConfirm({super.key});

  @override
  State<DeliveryConfirm> createState() => _DeliveryConfirmState();
}

class _DeliveryConfirmState extends State<DeliveryConfirm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> codeNotifier = ValueNotifier(true);
  late final TextEditingController codeController;

  bool _sendCodeAgain = false;
  int _countdown = 60;

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
    _startCountdown();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
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

    return CustomScaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        context: context,
        titleText: "Подтверждение",
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Form(
          child: Column(
            children: [
              const Text(
                'Сообщение с кодом подтверждения отправлен клиенту',
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
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  validator: (value) {
                    return null;
                  },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) async {},
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: const Border(
                        bottom: BorderSide(color: AppColors.grey, width: 2),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              _sendCodeAgain
                  ? TextButton(
                      onPressed: _sendCodeAgain
                          ? () {
                              setState(() {
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
        ),
      ),
    );
  }
}
