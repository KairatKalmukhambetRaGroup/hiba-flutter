import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/entities/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hiba/utils/api/auth.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinput/pinput.dart';
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

  // ignore: unused_field
  late PermissionStatus _cameraPermissionStatus;
  // ignore: unused_field
  late PermissionStatus _galleryPermissionStatus;

  File? _imageFile;
  final picker = ImagePicker();

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
    _checkPermissions();
    initControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  Future<void> _checkPermissions() async {
    final cameraPermissionStatus = await Permission.camera.status;
    final galleryPermissionStatus = await Permission.photos.status;

    setState(() {
      _cameraPermissionStatus = cameraPermissionStatus;
      _galleryPermissionStatus = galleryPermissionStatus;
    });
  }

  // ignore: unused_element
  Future<void> _requestPermissions() async {
    final cameraPermissionStatus = await Permission.camera.request();
    final galleryPermissionStatus = await Permission.photos.request();

    setState(() {
      _cameraPermissionStatus = cameraPermissionStatus;
      _galleryPermissionStatus = galleryPermissionStatus;
    });
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _showImagePicker() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                ListTile(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    side: BorderSide.none,
                  ),
                  titleAlignment: ListTileTitleAlignment.center,
                  tileColor: AppColors.bgLight,
                  // contentPadding: const EdgeInsets.all(16),
                  title: const Icon(Icons.camera_alt),
                  onTap: () async {
                    await getImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                ),
                const Divider(height: 1, color: AppColors.grey),
                ListTile(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide.none,
                  ),
                  titleAlignment: ListTileTitleAlignment.center,
                  tileColor: AppColors.bgLight,
                  // contentPadding: const EdgeInsets.all(16),
                  title: const Text(
                    'Открыть галерею',
                    textAlign: TextAlign.center,
                    style: AppTheme.headingBlack500_16,
                  ),
                  onTap: () async {
                    await getImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                ),
                const Divider(height: 1, color: AppColors.grey),
                ListTile(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    side: BorderSide.none,
                  ),
                  titleAlignment: ListTileTitleAlignment.center,
                  tileColor: AppColors.bgLight,
                  // contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    'Убрать фото',
                    textAlign: TextAlign.center,
                    style: _imageFile != null
                        ? AppTheme.bodyRed500_16
                        : AppTheme.bodyGrey500_16,
                  ),
                  onTap: () {
                    setState(() {
                      _imageFile = null;
                    });
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 8),
                ListTile(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    side: BorderSide.none,
                  ),
                  titleAlignment: ListTileTitleAlignment.center,
                  tileColor: AppColors.bgLight,
                  // contentPadding: const EdgeInsets.all(16),
                  title: const Text(
                    'Отменить',
                    textAlign: TextAlign.center,
                    style: AppTheme.bodyBlue500_16,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of<AuthState>(context, listen: false);
    User? user = authState.user;
    nameController.setText(user!.name);
    phoneController.setText(user.phone);

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
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
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
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!)
                            : user.avatar != null
                                ? MemoryImage(base64Decode(user.avatar!))
                                : const AssetImage('assets/images/avatar.png')
                                    as ImageProvider,
                      ),
                    ),
                    Positioned(
                      width: 40,
                      height: 40,
                      right: 0,
                      bottom: 0,
                      child: IconButton(
                        onPressed: () {
                          // _requestPermissions();
                          // if (_cameraPermissionStatus !=
                          //         PermissionStatus.denied &&
                          //     _galleryPermissionStatus !=
                          //         PermissionStatus.denied) {
                          _showImagePicker();
                          // }
                        },
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(AppColors.white),
                        ),
                        icon: SvgPicture.asset(
                          'assets/svg/camera.svg',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Row(
                  children: [
                    Text(
                      'Введите Имя и Фамилию',
                      style: AppTheme.bodyBlack500_14,
                    ),
                  ],
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
