part of 'auth_library.dart';

/// A page for registering a new user account.
///
/// The [RegisterPage] allows users to create a new account by providing their
/// username, phone number, and password. It includes form validation and
/// feedback for user input.
///
/// ### Example Usage
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => const RegisterPage(),
///   ),
/// );
/// ```
class RegisterPage extends StatefulWidget {
  /// Creates a [RegisterPage].
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

/// The state class for [RegisterPage].
///
/// Manages user input validation, visibility toggles for password fields, and
/// interaction with the authentication flow.
class _RegisterPageState extends State<RegisterPage> {
  /// A key for the form widget to manage its state.
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  /// Controllers for managing form input fields.
  late final TextEditingController usernameController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  /// Initializes controllers for form input fields.
  void initializeControllers() {
    usernameController = TextEditingController()
      ..addListener(controllerListener);
    phoneNumberController = TextEditingController()
      ..addListener(controllerListener);
    passwordController = TextEditingController()
      ..addListener(controllerListener);
    confirmPasswordController = TextEditingController()
      ..addListener(controllerListener);
  }

  /// Disposes controllers to release resources.
  void disposeControllers() {
    usernameController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  /// Listens for changes in form fields and validates them.
  void controllerListener() {
    final username = usernameController.text;
    final phoneNumber = phoneNumberController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (username.isEmpty &&
        phoneNumber.isEmpty &&
        password.isEmpty &&
        confirmPassword.isEmpty) return;

    if (AppRegex.phoneNumberRegex.hasMatch(phoneNumber) &&
        AppRegex.passwordRegex.hasMatch(password) &&
        AppRegex.passwordRegex.hasMatch(confirmPassword)) {
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

  /// Handles form submission by registering the user.
  ///
  /// - [authState]: The [AuthState] instance for managing authentication.
  Future<void> handleSubmit(AuthState authState) async {
    int status = await authState.registerUser(
      usernameController.text,
      phoneNumberController.text,
      passwordController.text,
    );

    if (status == 200) {
      SnackbarHelper.showSnackBar(AppStrings.registrationComplete);
      usernameController.clear();
      phoneNumberController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of<AuthState>(context);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const GradientBackground(
            children: [
              Text(
                AppStrings.signInToYourNAccount,
                style: AppTheme.white700_34,
              ),
              SizedBox(height: 6),
              Text(AppStrings.signInToYourAccount, style: AppTheme.grey400_14),
            ],
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppTextFormField(
                    autofocus: true,
                    controller: usernameController,
                    labelText: AppStrings.username,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty
                          ? AppStrings.pleaseEnterUsername
                          : value.length < 4
                              ? AppStrings.invalidUsername
                              : null;
                    },
                  ),
                  AppTextFormField(
                    controller: phoneNumberController,
                    labelText: AppStrings.phoneNumber,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty
                          ? AppStrings.pleaseEnterPhoneNumber
                          : null;
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: passwordNotifier,
                    builder: (_, passwordObscure, __) {
                      return AppTextFormField(
                        obscureText: passwordObscure,
                        controller: passwordController,
                        labelText: AppStrings.password,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterPassword
                              : AppRegex.passwordRegex.hasMatch(value)
                                  ? null
                                  : AppStrings.invalidPassword;
                        },
                        suffixIcon: Focus(
                          descendantsAreFocusable: false,
                          child: IconButton(
                            onPressed: () =>
                                passwordNotifier.value = !passwordObscure,
                            style: IconButton.styleFrom(
                              minimumSize: const Size.square(48),
                            ),
                            icon: Icon(
                              passwordObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: confirmPasswordNotifier,
                    builder: (_, confirmPasswordObscure, __) {
                      return AppTextFormField(
                        obscureText: confirmPasswordObscure,
                        controller: confirmPasswordController,
                        labelText: AppStrings.confirmPassword,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterPassword
                              : AppRegex.passwordRegex.hasMatch(value)
                                  ? passwordController.text ==
                                          confirmPasswordController.text
                                      ? null
                                      : AppStrings.passwordNotMatched
                                  : AppStrings.invalidPassword;
                        },
                        suffixIcon: Focus(
                          descendantsAreFocusable: false,
                          child: IconButton(
                            onPressed: () => confirmPasswordNotifier.value =
                                !confirmPasswordObscure,
                            style: IconButton.styleFrom(
                              minimumSize: const Size.square(48),
                            ),
                            icon: Icon(
                              confirmPasswordObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(AppStrings.forgotPassword),
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder(
                    valueListenable: fieldValidNotifier,
                    builder: (_, isValid, __) {
                      return FilledButton(
                        onPressed: isValid
                            ? () {
                                handleSubmit(authState);
                              }
                            : null,
                        child: const Text(AppStrings.register),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.iHaveAnAccount,
                style: AppTheme.grey400_14.copyWith(color: Colors.black),
              ),
              const SizedBox(width: 4),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/login'),
                child: const Text(AppStrings.login),
              ),
            ],
          )
        ],
      ),
    );
  }
}
