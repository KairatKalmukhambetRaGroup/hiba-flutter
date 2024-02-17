import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterProfile extends StatefulWidget {
  static const routeName = '/register-profile';
  const RegisterProfile({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterProfileState();
}

class _RegisterProfileState extends State<StatefulWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // ignore: unused_field
  late PermissionStatus _cameraPermissionStatus;
  // ignore: unused_field
  late PermissionStatus _galleryPermissionStatus;

  final TextEditingController _usernameController = TextEditingController();

  File? _imageFile;
  final picker = ImagePicker();

  @override
  void initState() {
    _checkPermissions();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                      icon: const Icon(Icons.camera),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ListTile(
                    tileColor: AppColors.grey,
                    title: const Text(
                      'Убрать фото',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _imageFile = null;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ListTile(
                    tileColor: AppColors.grey,
                    title: const Text(
                      'Отменить',
                      textAlign: TextAlign.center,
                      style: AppTheme.headingBlack500_16,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Профиль',
          style: AppTheme.headingBlack500_16,
        ),
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
                            MaterialStatePropertyAll(AppColors.white),
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
                style: AppTheme.bodyBlack400_14,
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
    );
  }
}
