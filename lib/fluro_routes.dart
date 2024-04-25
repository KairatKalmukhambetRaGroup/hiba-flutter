import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hiba/pages/butchery/butchery_page.dart';
import 'package:hiba/pages/code_verification_page.dart';
import 'package:hiba/pages/contact_us_page.dart';
import 'package:hiba/pages/home_page.dart';
import 'package:hiba/pages/login_page.dart';
import 'package:hiba/pages/profile/addresses_page.dart';
import 'package:hiba/pages/profile/new_address_page.dart';
import 'package:hiba/pages/profile/notification_page.dart';
import 'package:hiba/pages/profile/orders_page.dart';
import 'package:hiba/pages/profile/profile_page.dart';
import 'package:hiba/pages/profile/user_info_page.dart';
import 'package:hiba/pages/register_profile.dart';
import 'package:hiba/pages/butchery/search_page.dart';
import 'package:hiba/pages/support_chat_page.dart';

class FluroRoutes {
  static FluroRouter router = FluroRouter();

  static final Handler _loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const LoginPage();
    },
  );
  static final Handler _codeVerificationHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      if (params.containsKey('phone')) {
        return CodeVerificationPage(phone: params['phone'][0]);
      }
      return null;
      // return const CodeVerificationPage();
    },
  );
  static final Handler _registerProfileHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      if (params.containsKey('phone')) {
        return RegisterProfile(phone: params['phone'][0]);
      }
      return const RegisterProfile(phone: '');
    },
  );

  static final Handler _homeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const HomePage();
    },
  );

  static final Handler _addressesHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return const AddressesPage();
  });

  static final Handler _newAddresshandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return const NewAddressPage();
  });

  static final Handler _searchPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      if (params.containsKey('charity')) {
        return const SearchPage(charity: true);
      }
      return const SearchPage(charity: false);
    },
  );

  static final Handler _profilePageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const ProfilePage();
    },
  );

  static final Handler _userInfoPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const UserInfoPage();
    },
  );

  static final Handler _ordersPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      // if (params.containsKey('id')) {
      //   return ButcheryPage(id: params['id'][0]);
      // }
      return const OrdersPage();
    },
  );
  static final Handler _notificationsPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const NotificationsPage();
    },
  );

  static final Handler _butcheryPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      if (params.containsKey('id')) {
        print(params['charity']);
        final isCharity = params['charity']?[0]?.toLowerCase() == 'true';
        return ButcheryPage(
          id: params['id'][0],
          charity: isCharity,
        );
      }
    },
  );

  static final Handler _contactUsPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const ContactUsPage();
    },
  );

  static final Handler _supportChatPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const SupportChatPage();
    },
  );

  static void setupRouter() {
    router.define(
      SupportChatPage.routeName,
      handler: _supportChatPageHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      ContactUsPage.routeName,
      handler: _contactUsPageHandler,
      transitionType: TransitionType.cupertino,
    );
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
      '${CodeVerificationPage.routeName}/:phone',
      handler: _codeVerificationHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      '${RegisterProfile.routeName}/:phone',
      handler: _registerProfileHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      '${SearchPage.routeName}/:charity',
      handler: _searchPageHandler,
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
      UserInfoPage.routeName,
      handler: _userInfoPageHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      OrdersPage.routeName,
      handler: _ordersPageHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      AddressesPage.routeName,
      handler: _addressesHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      NewAddressPage.routeName,
      handler: _newAddresshandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      NotificationsPage.routeName,
      handler: _notificationsPageHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      '${ButcheryPage.routeName}/:id',
      handler: _butcheryPageHandler,
      transitionType: TransitionType.cupertino,
    );
  }
}
