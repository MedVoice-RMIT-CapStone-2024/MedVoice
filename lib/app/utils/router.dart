// Setting up specific cases for when you navigate to pages

import 'package:flutter/cupertino.dart';
import 'package:med_voice/app/pages/onboarding/login/sign_in_view.dart';
import 'package:med_voice/app/utils/pages.dart';

import '../pages/onboarding/confirm/confirm_view.dart';
import '../pages/onboarding/reset/reset_view.dart';
import '../pages/onboarding/signup/sign_up_view.dart';

class AppRouter {
  final RouteObserver<PageRoute> routeObserver;

  AppRouter() : routeObserver = RouteObserver<PageRoute>();

  CupertinoPageRoute? getRoute(RouteSettings settings) {
    switch (settings.name) {

      // case Pages.startup:
      //   return _buildRoute(settings, StartupView());

      // case Pages.foodDetails:
      //   Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
      //   return _buildRoute(settings, FoodDetailsView(
      //     foodItem: arguments[foodItemParam] as String,
      //   ));

      case Pages.signUp:
        return _buildRoute(settings, SignUpView());

      case Pages.signIn:
        return _buildRoute(settings, const SignInView());

      case Pages.reset:
        return _buildRoute(settings, ResetView());

      case Pages.confirm:
        return _buildRoute(settings, ConfirmView());

      default:
        return null;
    }
  }

  CupertinoPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return CupertinoPageRoute(
        settings: settings, builder: (context) => builder);
  }
}
