// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:restaurant_app/src/common/constants/global_variables.dart';
// import 'package:restaurant_app/src/dummy_data/order_status_list.dart';
// import 'package:restaurant_app/src/features/food_list/pages/provider/food_list_provider.dart';
// import 'package:restaurant_app/src/router/routes.dart';
// import 'package:restaurant_app/src/theme/theme.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<FoodListProvider>(
//           create: (context) {
//             final provider = FoodListProvider();
//             // Yahan hum products ko initialize kar rahe hain
//             provider.setProducts(products);
//             return provider;
//           },
//         ),
//       ],
//       child: MaterialApp.router(
//         title: 'Restaurant App',
//         debugShowCheckedModeBanner: false,
//         scaffoldMessengerKey: scaffoldMessengerKey,
//         theme: AppTheme.instance.lightTheme,
//         routerDelegate: MyAppRouter.router.routerDelegate,
//         routeInformationParser: MyAppRouter.router.routeInformationParser,
//         routeInformationProvider: MyAppRouter.router.routeInformationProvider,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/common/constants/global_variables.dart';
import 'package:restaurant_app/src/dummy_data/order_status_list.dart';
import 'package:restaurant_app/src/features/food_list/pages/provider/food_list_provider.dart';
import 'package:restaurant_app/src/features/product/provider/product_provider.dart';
import 'package:restaurant_app/src/router/routes.dart';
import 'package:restaurant_app/src/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FoodListProvider>(
          create: (context) {
            final provider = FoodListProvider();
            // Yahan hum products ko initialize kar rahe hain
            provider.setProducts(products);
            return provider;
          },
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) {
            final provider = ProductProvider();
            provider.setProducts(productData);
            return provider;
          },
        ),
      ],
      child: MaterialApp.router(
        title: 'Restaurant App',
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldMessengerKey,
        theme: AppTheme.instance.lightTheme,
        routerDelegate: MyAppRouter.router.routerDelegate,
        routeInformationParser: MyAppRouter.router.routeInformationParser,
        routeInformationProvider: MyAppRouter.router.routeInformationProvider,
      ),
    );
  }
}
