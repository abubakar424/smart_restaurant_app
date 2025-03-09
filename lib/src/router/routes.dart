import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_restaurant_app/src/router/route_transitions.dart';
import '../dummy_data/user_profile_list.dart';
import '../features/auth/pages/back_email_page.dart';
import '../features/auth/pages/change_password_page.dart';
import '../features/auth/pages/change_password_successfully.dart';
import '../features/auth/pages/forget_password_page.dart';
import '../features/custom_navigation.dart';
import '../features/food_list/pages/food_list_page.dart';
import '../features/history/pages/order_history_page.dart';
import '../features/location_page/location_page.dart';
import '../features/new_order/pages/new_order_page.dart';
import '../features/new_order/pages/order_detail_page.dart';
import '../features/notifications/pages/notifications_page.dart';
import '../features/on_boarding/pages/on_boarding_page.dart';
import '../features/profile/pages/about_app_page.dart';
import '../features/profile/pages/edit_profile_page.dart';
import '../features/profile/pages/faq_page.dart';
import '../features/profile/pages/personal_profile_page.dart';
import '../features/profile/pages/policy_page.dart';
import '../features/profile/pages/profile_page.dart';
import '../features/profile/pages/reviews_page.dart';
import '../features/profile/pages/setting_page.dart';
import '../features/profile/pages/term_condition_page.dart';
import '../features/promotions/pages/promotion_page.dart';
import '../features/splash.dart';
import '../features/update_screen/update_screen_home.dart';
import '../features/welcome/welcome_screen.dart';
import '../features/wellcome/pages/wellcome_page.dart';
import 'error_route.dart';

class MyAppRouter {
  static final router = GoRouter(
    initialLocation: '/${AppRoute.onboardingPageView}',
    // initialLocation: '/${AppRoute.customNavBar}',
    routes: [
      GoRoute(
        name: AppRoute.splash,
        path: '/${AppRoute.splash}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const SplashPage(),
        ),
      ),
    GoRoute(
        name: "WelcomeScreen",
        path: "/WelcomeScreen",
        builder: (context, state) => WelcomeScreen(),
      ),
      GoRoute(
        name: "HomeUpdateScreen",
        path: "/HomeUpdateScreen",
        builder: (context, state) => HomeUpdateScreen(),
      ),
      GoRoute(
        name: AppRoute.onboardingPageView,
        path: '/${AppRoute.onboardingPageView}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const OnboardingPageView(),
        ),
      ),
      GoRoute(
        name: AppRoute.welcomePage,
        path: '/${AppRoute.welcomePage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const WelcomePage(),
        ),
      ),
      GoRoute(
        name: AppRoute.forgetPasswordPage,
        path: '/${AppRoute.forgetPasswordPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const ForgetPasswordPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.backEmailPage,
        path: '/${AppRoute.backEmailPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const BackEmailPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.changePasswordPage,
        path: '/${AppRoute.changePasswordPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const ChangePasswordPage(),
        ),
      ),
      GoRoute(
          name: AppRoute.changePasswordSuccessfully,
          path: '/${AppRoute.changePasswordSuccessfully}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const ChangePasswordSuccessfully(),
              )),
      GoRoute(
        name: AppRoute.customNavBar,
        path: '/${AppRoute.customNavBar}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const CustomNavigation(),
        ),
      ),
      GoRoute(
        name: AppRoute.profilePage,
        path: '/${AppRoute.profilePage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: ProfilePage(
            userProfile: dummyProfiles[0],
          ), // Pass the UserProfile to ProfileScreen
        ),
      ),
      GoRoute(
        name: AppRoute.personalInfoPage,
        path: '/${AppRoute.personalInfoPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: PersonalInfoPage(
            userProfile: dummyProfiles[0],
          ),
        ),
      ),
      GoRoute(
        name: AppRoute.editProfilePage,
        path: '/${AppRoute.editProfilePage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: EditProfilePage(userProfile: dummyProfiles[0]),
        ),
      ),
      GoRoute(
        name: AppRoute.settingPage,
        path: '/${AppRoute.settingPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const SettingPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.reviewsPage,
        path: '/${AppRoute.reviewsPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const ReviewsPage(),
        ),
      ),
 
      GoRoute(
        name: AppRoute.productAddPage,
        path: '/${AppRoute.productAddPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: Container(),
        ),
      ),
   
      GoRoute(
        name: AppRoute.foodListPage,
        path: '/${AppRoute.foodListPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const FoodListPage(),
        ),
      ),

      GoRoute(
        name: AppRoute.notificationsPage,
        path: '/${AppRoute.notificationsPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const NotificationsPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.aboutAppPage,
        path: '/${AppRoute.aboutAppPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const AboutAppPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.privacyPolicyPage,
        path: '/${AppRoute.privacyPolicyPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const PrivacyPolicyPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.termsConditionsPage,
        path: '/${AppRoute.termsConditionsPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const TermsConditionsPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.fAQPage,
        path: '/${AppRoute.fAQPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const FAQPage(),
        ),
      ),

      GoRoute(
          name: AppRoute.location,
          path: '/${AppRoute.location}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const LocationPage(),
              )),
      GoRoute(
        name: AppRoute.orderHistoryPage,
        path: '/${AppRoute.orderHistoryPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const OrderHistoryPage(),
        ),
      ),

      // GoRoute(
      //   name: AppRoute.addProductPage,
      //   path: '/${AppRoute.addProductPage}',
      //   pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
      //     context: context,
      //     state: state,
      //     child: const AddProductPage(),
      //   ),
      // ),
      GoRoute(
        name: AppRoute.newPromotionPage,
        path: '/${AppRoute.newPromotionPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const NewPromotionPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.newOrderPage,
        path: '/${AppRoute.newOrderPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const NewOrderPage(),
        ),
      ),

      GoRoute(
        name: AppRoute.orderDetailPage,
        path: '/${AppRoute.orderDetailPage}',
        pageBuilder: (context, state) {
          final data =
              state.extra as Map<String, dynamic>; // Safely get the order
          return buildPageWithFadeTransition<void>(
            context: context,
            state: state,
            child: OrderDetailPage(
              onAction: data['onAction'], // Define your action
              order: data['order'], // Pass the order to the OrderDetailPage
            ),
          );
        },
      ),

      // GoRoute(
      //   name: AppRoute.orderDetailPage,
      //   path: '/${AppRoute.orderDetailPage}',
      //   pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
      //     context: context,
      //     state: state,
      //     child: OrderDetailPage(
      //       onAction: () {}, order: order,
      //     ),
      //   ),
      // ),
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
  static const String errorPage = 'error-page';
  static const String splash = 'splash';

  /// Orders
  static const String ordersPage = 'orders-page';

  /// Promotions
  static const String promotionsPage = 'promotions-page';
  static const String promotionsItemsPage = 'promotions-items-page';

  /// on-boarding
  static const String onboardingPageView = 'onboarding_page_view';
  static const String welcomePage = 'welcome_page';

  /// auth
  static const String forgetPasswordPage = 'forget_password_page';
  static const String backEmailPage = 'back_email_page';
  static const String changePasswordPage = 'change_password_page';
  static const String changePasswordSuccessfully =
      'change_password_successfully';

  /// nav bar
  static const String customNavBar = 'custom-nav-bar';
  static const String foodListDetail = 'food-list-detail-page';

  ///  profile
  static const String profileScreen = 'profile-screen';
  static const String personalInfoPage = 'personal-info-page';
  static const String productAddPage = 'product-add-page';
  static const String foodListPage = 'food_list_page';

  // static const String personalInfoPage = 'personal-info-page';
  /// notifications
  static const String notificationsPage = 'notifications-page';
  static const String profilePage = 'profile-page';
  static const String editProfilePage = 'edit-profile-page';
  static const String settingPage = 'setting-page';
  static const String reviewsPage = 'reviews-page';
  static const String aboutAppPage = 'about-app-page';
  static const String privacyPolicyPage = 'privacy-policy-page';
  static const String termsConditionsPage = 'terms-conditions-page';
  static const String fAQPage = 'faq-page';
  static const String location = 'location-page';
  //

  // Order History
  static const String orderHistoryPage = 'order-history-page';

  // New Promotion Pages

  static const String newPromotionPage = 'new-promotion-page';

  static const String addProductPage = 'add-product-page';

  // New Order Pages

  static const String newOrderPage = 'new-order-page';
  static const String orderDetailPage = 'order-detail-page';
}
