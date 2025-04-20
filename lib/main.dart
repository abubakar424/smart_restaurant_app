import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:smart_restaurant_app/src/features/food_list/pages/provider/food_list_provider.dart';
import 'package:smart_restaurant_app/src/features/product/provider/product_provider.dart';
import 'package:smart_restaurant_app/src/router/routes.dart';
import 'package:smart_restaurant_app/src/theme/theme.dart';

void main() {
  runApp(const MyApp());
}
//Abdul Razzaq
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FoodListProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: GlobalLoaderOverlay(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.instance.lightTheme,
          routerDelegate: MyAppRouter.router.routerDelegate,
          routeInformationParser: MyAppRouter.router.routeInformationParser,
          routeInformationProvider: MyAppRouter.router.routeInformationProvider,
        ),
      ),
    );
  }
}
