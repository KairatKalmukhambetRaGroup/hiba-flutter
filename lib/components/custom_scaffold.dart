part of '../core_library.dart';

/// A custom scaffold widget that handles user authentication and displays a loading indicator.
///
/// The [CustomScaffold] extends [StatefulWidget] and wraps the standard [Scaffold] widget.
/// It provides additional functionality to check if a user is logged in and displays a
/// loading indicator while fetching user data.
///
/// ### Example Usage
/// ```dart
/// CustomScaffold(
///   appBar: AppBar(title: Text('Home')),
///   body: HomePage(),
/// );
/// ```
// ignore: must_be_immutable
class CustomScaffold extends StatefulWidget {
  /// The main content of the scaffold.
  final Widget body;

  /// The background color of the scaffold.
  Color? backgroundColor;

  /// The app bar to display at the top of the scaffold.
  PreferredSizeWidget? appBar;

  /// The bottom navigation bar to display at the bottom of the scaffold.
  Widget? bottomNavigationBar;

  /// Creates a [CustomScaffold] widget.
  ///
  /// - [body]: The primary content of the scaffold.
  /// - [backgroundColor]: The background color of the scaffold.
  /// - [appBar]: An optional app bar widget.
  /// - [bottomNavigationBar]: An optional bottom navigation bar widget.
  CustomScaffold({
    super.key,
    required this.body,
    this.backgroundColor,
    this.appBar,
    this.bottomNavigationBar,
  });

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

/// The state class for [CustomScaffold].
///
/// Manages the loading state and user authentication check.
class _CustomScaffoldState extends State<CustomScaffold> {
  /// Indicates whether the widget is in a loading state.
  bool loading = true;

  /// Indicates whether the user is logged in.
  bool isUserLoggedIn = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Retrieves the user data and updates the loading state.
  void getUser() async {
    if (!mounted) return;
    setState(() {
      loading = true;
    });
    AuthState authState = Provider.of<AuthState>(context, listen: true);
    await authState.getUserData();
    if (!mounted) return;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      getUser();
    }

    return Scaffold(
      bottomNavigationBar: widget.bottomNavigationBar,
      backgroundColor: widget.backgroundColor,
      appBar: widget.appBar,
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : widget.body,
    );
  }
}
