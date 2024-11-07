import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/pages/code_verification_page.dart';
import 'package:hiba/pages/courier_login.dart';
import 'package:hiba/pages/register_profile.dart';
import 'package:hiba/providers/google_sign_in_provider.dart';
import 'package:hiba/utils/api/auth.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_regex.dart';
import 'package:hiba/values/app_strings.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignInProvider googleSignInProvider = GoogleSignInProvider();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  late final TextEditingController phoneNumberController;
  late final TextEditingController passwordController;
  String initialCountry = 'KZ';
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'KZ');

  Future<void> initializeControllers() async {
    phoneNumberController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    phoneNumberController.dispose();
  }

  void controllerListener() {
    final phoneNumber = phoneNumberController.text;

    if (phoneNumber.isEmpty) return;

    if (AppRegex.phoneNumberRegex.hasMatch(phoneNumber)) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of<AuthState>(context);

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      key: _scaffoldKey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                textAlign: TextAlign.center,
                AppStrings.authWelcome,
                style: AppTheme.black600_28,
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Введите номер телефона',
                      style: AppTheme.black400_14,
                    ),
                    const SizedBox(height: 8),
                    InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        // print('${phoneNumber} - $number');
                        if (phoneNumber.phoneNumber != number.phoneNumber) {
                          setState(() {
                            phoneNumber = number;
                          });
                        }
                        _formKey.currentState?.validate();
                      },
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.DROPDOWN,
                        setSelectorButtonAsPrefixIcon: true,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: AppTheme.black400_14,
                      textStyle: AppTheme.black400_14,
                      initialValue: phoneNumber,
                      textFieldController: phoneNumberController,
                      formatInput: true,
                      keyboardType: TextInputType.phone,
                      inputBorder: InputBorder.none,

                      // validator: (value) {
                      //   print(phoneNumber.phoneNumber);
                      //   print(value);
                      //   return value!.isEmpty
                      //       ? AppStrings.pleaseEnterPhoneNumber
                      //       // : AppConstants.passwordRegex.hasMatch(value)
                      //       // ? null
                      //       // : AppStrings.invalidPhoneNumber;
                      //       : null;
                      // },
                    ),
                    // AppTextFormField(
                    //   controller: phoneNumberController,
                    //   labelText: AppStrings.phoneNumber,
                    //   keyboardType: TextInputType.phone,
                    //   textInputAction: TextInputAction.next,
                    //   onChanged: (_) => _formKey.currentState?.validate(),
                    //   validator: (value) {
                    //     return value!.isEmpty
                    //         ? AppStrings.pleaseEnterPhoneNumber
                    //         // : AppConstants.passwordRegex.hasMatch(value)
                    //         // ? null
                    //         // : AppStrings.invalidPhoneNumber;
                    //         : null;
                    //   },
                    // ),
                    const SizedBox(height: 16),
                    ValueListenableBuilder(
                      valueListenable: fieldValidNotifier,
                      builder: (_, isValid, __) {
                        return TextButton(
                          onPressed: () async {
                            // String phoneNum = '';
                            // if (phoneNumber.phoneNumber != null) {
                            //   phoneNum = phoneNumber.phoneNumber!;
                            // }
                            // int status = await loginUser(phoneNum);
                            // if (status == 200) {
                            // SnackbarHelper.showSnackBar(
                            //   AppStrings.loggedIn,
                            // );
                            // phoneNumberController.clear();
                            // passwordController.clear();
                            pushWithoutNavBar(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CodeVerificationPage(
                                        phone: phoneNumber.phoneNumber)));
                            // }
                          },
                          style: ButtonStyle(
                            shape:
                                WidgetStatePropertyAll<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                            minimumSize: const WidgetStatePropertyAll(
                                Size.fromHeight(48)),
                          ),
                          child: Ink(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.mainBlue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(
                                  minWidth: 328, minHeight: 48),
                              alignment: Alignment.center,
                              child: const Text(
                                AppStrings.authContinue,
                                style: AppTheme.white500_16,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // or with
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(height: 0.5, color: AppColors.black)),
                  const SizedBox(width: 8),
                  const Text(
                    AppStrings.orLoginWith,
                    style: AppTheme.black500_14,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Container(height: 0.5, color: AppColors.black)),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google Button
                  TextButton.icon(
                    onPressed: () async {
                      String? idTokenString =
                          await googleSignInProvider.signInWithGoogle();
                      if (idTokenString != null) {
                        // print("User signed in: $idTokenString");

                        int status =
                            await authState.loginWithGoogle(idTokenString);

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
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => RegisterProfile(
                          //               phone: phone,
                          //             )));
                        }
                      } else {
                        print("Sign-in failed");
                      }
                    },
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                                color: AppColors.grey,
                                width: 1,
                                style: BorderStyle.solid,
                                strokeAlign: BorderSide.strokeAlignInside),
                          ),
                        ),
                        padding:
                            const WidgetStatePropertyAll(EdgeInsets.all(8)),
                        minimumSize:
                            const WidgetStatePropertyAll(Size.fromHeight(48)),
                        backgroundColor:
                            const WidgetStatePropertyAll(AppColors.white)),
                    icon: SvgPicture.asset(
                      'assets/svg/google.svg',
                      width: 24,
                      height: 24,
                    ),
                    label: const Text(
                      AppStrings.google,
                      style: AppTheme.black500_16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Apple Button
                  TextButton.icon(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                              color: AppColors.grey,
                              width: 1,
                              style: BorderStyle.solid,
                              strokeAlign: BorderSide.strokeAlignInside),
                        ),
                      ),
                      padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
                      minimumSize:
                          const WidgetStatePropertyAll(Size.fromHeight(48)),
                      backgroundColor:
                          const WidgetStatePropertyAll(AppColors.white),
                    ),
                    icon: SvgPicture.asset(
                      'assets/svg/apple.svg',
                      width: 24,
                      height: 24,
                    ),
                    label: const Text(
                      AppStrings.apple,
                      style: AppTheme.black500_16,
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
