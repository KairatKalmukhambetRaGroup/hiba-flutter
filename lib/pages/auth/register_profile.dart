// ignore_for_file: avoid_print, use_build_context_synchronously
/// lib/pages/auth/auth_library.dart
part of 'auth_library.dart';

/// A page for completing user registration by providing a profile picture and username.
///
/// The [RegisterProfile] allows users to set up their profile with a phone number,
/// username, and an optional avatar image during registration.
///
/// ### Example Usage
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => RegisterProfile(phone: '+123456789'),
///   ),
/// );
/// ```
class RegisterProfile extends StatefulWidget {
  /// The phone number used for registration.
  final String phone;

  /// Creates a [RegisterProfile] page.
  ///
  /// - [phone]: The phone number to associate with the new user.
  const RegisterProfile({super.key, required this.phone});

  @override
  State<StatefulWidget> createState() => _RegisterProfileState();
}

/// The state class for [RegisterProfile].
///
/// Manages user input, avatar selection, and interaction with the registration flow.
class _RegisterProfileState extends State<RegisterProfile> {
  /// A key for managing the scaffold state.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // ignore: unused_field
  late PermissionStatus _cameraPermissionStatus;
  // ignore: unused_field
  late PermissionStatus _galleryPermissionStatus;

  /// Controller for the username text field.
  final TextEditingController _usernameController = TextEditingController();

  /// The selected image file for the user's avatar.
  File? _imageFile;

  /// Image picker instance for selecting avatar images.
  final picker = ImagePicker();

  /// The phone number associated with the user.
  String _phone = '';

  void _initPhone() async {
    setState(() {
      _phone = widget.phone;
    });
  }

  @override
  void initState() {
    _checkPermissions();
    super.initState();
    _initPhone();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  /// Checks for camera and gallery permissions.
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

  /// Fetches an image from the specified source (camera or gallery).

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  /// Shows the image picker options (camera or gallery) in a modal bottom sheet.
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

  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of<AuthState>(context);
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      key: _scaffoldKey,
      appBar: CustomAppBar(
        titleText: 'Профиль',
        context: context,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            children: [
              // avatar
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.white,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : const AssetImage('assets/images/avatar.png')
                            as ImageProvider,
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
              const SizedBox(height: 28),
              TextField(
                controller: _usernameController,
                style: AppTheme.black400_14,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: AppColors.bgLight,
                  hintText: 'Имя Фамилия',
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: TextButton(
          onPressed: () async {
            int status = await authState.completeRegistration(
                _phone, _usernameController.text, _imageFile);
            if (status == 200) {
              Navigator.of(context).pushReplacementNamed('/');
            }
          },
          style: ButtonStyle(
            backgroundColor:
                const WidgetStatePropertyAll<Color>(AppColors.mainBlue),
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            minimumSize: const WidgetStatePropertyAll(Size.fromHeight(48)),
          ),
          child: const Text(
            'Продолжить',
            style: AppTheme.white500_16,
          ),
        ),
      ),
    );
  }
}
