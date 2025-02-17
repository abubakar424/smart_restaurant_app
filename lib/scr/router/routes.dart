import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_restaurant_app/scr/features/update_screens/home_page.dart';
import 'package:smart_restaurant_app/scr/features/welcome/welcome_screen.dart';
import 'package:smart_restaurant_app/scr/router/error_route.dart';

class MyAppRouter {
  static final router = GoRouter(
    initialLocation: '/WelcomeScreen',
    routes: [
      GoRoute(
        name: "WelcomeScreen",
        path: "/WelcomeScreen",
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        name: "UpdateScreenHome",
        path: "/UpdateHomeScreen",
        builder: (context, state) => const UpdateScreenHome(),
      ),


    ],
    errorPageBuilder: (context, state) {
      return const MaterialPage(child: ErrorPage());
    },
  );

  static void clearAndNavigate(BuildContext context, String name) {
    while (context.canPop()) {
      context.pop();
    }
    context.pushReplacementNamed(name);
  }
}

class AppRoute {
  static const String updateScreenHome = 'UpdateScreenHome' ;
  static const String errorpage = 'error-page';
  static const String splash = 'splash';
  static const String payementmethods = 'payementmethods';
  static const String payementconfirmation = 'payementconfirmation';
  static const String payementsuccesful = 'payementsuccesful';
  static const String transactionhistory = 'transactionhistory';
  static const String viewtransaction = 'viewtransaction';
}
