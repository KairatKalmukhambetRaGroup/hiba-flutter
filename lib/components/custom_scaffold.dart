import 'package:flutter/material.dart';
import 'package:hiba/pages/login_page.dart';
import 'package:hiba/utils/api/auth.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomScaffold extends StatefulWidget {
  final Widget body;
  Color? backgroundColor;
  PreferredSizeWidget? appBar;
  Widget? bottomNavigationBar;

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

class _CustomScaffoldState extends State<CustomScaffold> {
  bool loading = true;
  bool isUserLoggedIn = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
    AuthState authState = Provider.of<AuthState>(context, listen: true);
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
          : authState.isLoggedIn
              ? widget.body
              : const LoginPage(),
    );
  }
}
