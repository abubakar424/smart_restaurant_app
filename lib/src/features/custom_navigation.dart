import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_restaurant_app/src/features/product/pages/product_page.dart';
import 'package:smart_restaurant_app/src/features/profile/pages/profile_page.dart';
import 'package:smart_restaurant_app/src/features/promotions/pages/promotion_page.dart';
import 'package:smart_restaurant_app/src/features/update_screen/update_screen_home.dart';

import '../common/constants/app_images.dart';
import '../dummy_data/user_profile_list.dart';
import 'new_order/pages/new_order_page.dart';


class CustomNavigation extends StatefulWidget {
  const CustomNavigation({super.key});

  @override
  State<CustomNavigation> createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {
  int _currentIndex = 0;
  onChangeValue(value){
    _currentIndex = value;
  }
  List<Widget> screens = [
    const HomeUpdateScreen(),
    const NewOrderPage(),
    const ProductPage(),
    const NewPromotionPage(),
    ProfilePage(userProfile: dummyProfiles[0],),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(color:Colors.blueAccent,fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: (value){
          setState(() {
            onChangeValue(value);
          });
          },
          items: [
            _buildBottomNavItem(iconPath: AppIcons.home,
                label: 'Home',
                index: 0
            ),
            _buildBottomNavItem(
                iconPath: AppIcons.order,
                label: 'Orders',
                index: 1
            ),
            _buildBottomNavItem(
                iconPath: AppIcons.food_list,
              label: 'Food List',
              index: 2
            ),
            _buildBottomNavItem(
                iconPath: AppIcons.promotions,
                label: 'Promotions',
                index: 3
            ),
            _buildBottomNavItem(
                iconPath: AppIcons.profile,
                label: 'Profile',
                index: 4
            ),
          ]
      ),
      body: screens[_currentIndex],
    );
  }
  BottomNavigationBarItem _buildBottomNavItem({required String iconPath, required String label, required int index}){
    return BottomNavigationBarItem(icon: SvgPicture.asset(iconPath,colorFilter: ColorFilter.mode(_currentIndex == index ? Colors.blueAccent : Colors.grey, BlendMode.srcIn),),label: label);
  }
}
