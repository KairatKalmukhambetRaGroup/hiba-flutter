import 'package:flutter/material.dart';
import 'package:hiba/entities/user.dart';
import 'package:hiba/utils/api/auth.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

class UserInfoPage extends StatefulWidget {
  static const routeName = '/user-info';
  const UserInfoPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  String initialCountry = 'KZ';
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'KZ');

  void initControllers() {
    nameController = TextEditingController()..addListener(controllerListener);
    phoneController = TextEditingController()..addListener(controllerListener);
  }

  void disposeControllers() {
    phoneController.dispose();
    nameController.dispose();
  }

  void controllerListener() {
    final phoneNumber = phoneController.text;
    final name = nameController.text;

    if (phoneNumber.isEmpty && name.isEmpty) return;

    // if (AppRegex.phoneNumberRegex.hasMatch(phoneNumber)) {
    //   fieldValidNotifier.value = true;
    // } else {
    //   fieldValidNotifier.value = false;
    // }
  }

  @override
  void initState() {
    initControllers();
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
    User? user = authState.user;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'Мои данные',
          style: AppTheme.headingBlack600_16,
        ),
        shape:
            const Border(bottom: BorderSide(width: 1, color: AppColors.grey)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.grey, // Border color
                      width: 1.0, // Border width
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.white,
                    child: Image.asset(
                      'assets/images/avatar.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Введите Имя и Фамилию',
                  style: AppTheme.bodyBlack500_14,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: AppColors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    fillColor: AppColors.bgLight,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  style: AppTheme.headingBlack500_16,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  controller: nameController,
                  onChanged: (_) => _formKey.currentState?.validate(),
                  // validator: (value) {
                  //   return value!.isEmpty ? AppStrings.pleaseEnterName : null;
                  // },
                ),
                const SizedBox(height: 8),
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
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
                  selectorTextStyle: AppTheme.bodyBlack400_14,
                  textStyle: AppTheme.bodyBlack400_14,
                  initialValue: phoneNumber,
                  textFieldController: phoneController,
                  formatInput: true,
                  keyboardType: TextInputType.phone,
                  inputBorder: InputBorder.none,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: TextButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor:
                const MaterialStatePropertyAll<Color>(AppColors.mainBlue),
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            minimumSize: const MaterialStatePropertyAll(Size.fromHeight(48)),
          ),
          child: const Text(
            'Сохранить',
            style: AppTheme.headingWhite500_16,
          ),
        ),
      ),
    );
  }
}
