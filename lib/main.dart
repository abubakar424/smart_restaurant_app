import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:smart_restaurant_app/scr/router/routes.dart';
import 'package:smart_restaurant_app/scr/theme/theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.instance.lightTheme,
        routerDelegate: MyAppRouter.router.routerDelegate,
        routeInformationParser: MyAppRouter.router.routeInformationParser,
        routeInformationProvider: MyAppRouter.router.routeInformationProvider,
      ),
    );
  }
}
