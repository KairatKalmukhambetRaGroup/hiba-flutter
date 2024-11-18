// ignore_for_file: use_build_context_synchronously
part of 'profile_library.dart';

/// A page allowing users to view and edit their personal information.
///
/// The [UserInfoPage] enables users to:
/// - Update their name.
/// - Update their phone number.
/// - Change their profile picture by taking a new photo or selecting one from the gallery.
///
/// ### Example Usage
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => const UserInfoPage(),
///   ),
/// );
/// ```
class UserInfoPage extends StatefulWidget {
  /// Creates a [UserInfoPage].
  const UserInfoPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserInfoPageState();
}

/// The state class for [UserInfoPage].
///
/// Manages user input, image selection, permission handling, and updating user data.
class _UserInfoPageState extends State<UserInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController phoneController;

  /// The initial country code for the phone number input.
  String initialCountry = 'KZ';

  /// The phone number object representing the user's phone number.
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'KZ');

  /// Permission status for accessing the camera.
  // ignore: unused_field
  late PermissionStatus _cameraPermissionStatus;

  /// Permission status for accessing the photo gallery.
  // ignore: unused_field
  late PermissionStatus _galleryPermissionStatus;

  /// The selected image file for the user's profile picture.
  File? _imageFile;

  /// The image picker instance used to select images.
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
    // ignore: unused_local_variable
    final phoneNumber = phoneController.text;
    // ignore: unused_local_variable
    final name = nameController.text;

    // if (phoneNumber.isEmpty && name.isEmpty) return;

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
                    style: AppTheme.black500_16,
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
                        ? AppTheme.red500_16
                        : AppTheme.grey500_16,
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
                    style: AppTheme.blue500_16,
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

  void handleSubmit(AuthState authState) async {
    String apiUrl = '${dotenv.get('API_URL')}/user/updateUser';

    try {
      String name = nameController.text;
      String phone = phoneNumber.phoneNumber ?? "";
      File? photo = _imageFile;
      final String? authToken = await AuthState.getAuthToken();

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.headers['Content-Type'] = 'multipart/form-data; charset=UTF-8;';
      if (photo != null) {
        request.files
            .add(await http.MultipartFile.fromPath('avatar', photo.path));
      }
      request.fields['name'] = name;
      request.fields['phone'] = phone;

      request.headers['Authorization'] = 'Bearer $authToken';

      final streamResponse = await request.send();

      final response = await http.Response.fromStream(streamResponse);
      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        final responseData =
            Map<String, dynamic>.from(json.decode(decodedBody));
        authState.updateUserData(responseData['token'], responseData['user']);
        Navigator.pop(context);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of<AuthState>(context, listen: false);
    User? user = authState.user;
    nameController.setText(user!.name);
    phoneController.setText(user.phone.split(phoneNumber.isoCode ?? '')[0]);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        titleText: 'Мои данные',
        context: context,
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
                              WidgetStatePropertyAll(AppColors.white),
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
                      style: AppTheme.black500_14,
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
                  style: AppTheme.black500_16,
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
                    // if (phoneNumber.phoneNumber != number.phoneNumber) {
                    // setState(() {
                    //   phoneNumber = number;
                    // });
                    // }
                    // _formKey.currentState?.validate();
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
          onPressed: () {
            handleSubmit(authState);
          },
          style: ButtonStyle(
            backgroundColor:
                const WidgetStatePropertyAll<Color>(AppColors.mainBlue),
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            minimumSize: const WidgetStatePropertyAll(Size.fromHeight(48)),
          ),
          child: const Text(
            'Сохранить',
            style: AppTheme.white500_16,
          ),
        ),
      ),
    );
  }
}
