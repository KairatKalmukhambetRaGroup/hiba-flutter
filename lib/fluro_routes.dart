import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hiba/pages/butchery_page.dart';
import 'package:hiba/pages/code_verification_page.dart';
import 'package:hiba/pages/home_page.dart';
import 'package:hiba/pages/login_page.dart';
import 'package:hiba/pages/profile_page.dart';
import 'package:hiba/pages/register_profile.dart';
import 'package:hiba/pages/search_page.dart';

class FluroRoutes {
  static FluroRouter router = FluroRouter();

  static final Handler _loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const LoginPage();
    },
  );
  static final Handler _codeVerificationHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const CodeVerificationPage();
    },
  );
  static final Handler _registerProfileHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const RegisterProfile();
    },
  );

  static final Handler _homeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const HomePage();
    },
  );

  static final Handler _searchPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const SearchPage();
    },
  );

  static final Handler _profilePageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const ProfilePage();
    },
  );

  static final Handler _butcheryPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      if (params.containsKey('id')) {
        return ButcheryPage(id: params['id'][0]);
      }
      return const ButcheryPage();
    },
  );

  static void setupRouter() {
    router.define(
      HomePage.routeName,
      handler: _homeHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      LoginPage.routeName,
      handler: _loginHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      CodeVerificationPage.routeName,
      handler: _codeVerificationHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      RegisterProfile.routeName,
      handler: _registerProfileHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      SearchPage.routeName,
      handler: _searchPageHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      ProfilePage.routeName,
      handler: _profilePageHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      ButcheryPage.routeName,
      handler: _butcheryPageHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      '${ButcheryPage.routeName}/:id',
      handler: _butcheryPageHandler,
      transitionType: TransitionType.cupertino,
    );
  }
}
