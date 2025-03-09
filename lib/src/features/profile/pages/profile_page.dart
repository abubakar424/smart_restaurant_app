// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_app/src/common/constants/app_colors.dart';
import 'package:restaurant_app/src/common/constants/app_images.dart';
import 'package:restaurant_app/src/common/utils/custom_dialog.dart';
import 'package:restaurant_app/src/features/profile/widgets/custom_tab.dart';
import 'package:restaurant_app/src/model/profile/user_profile_model.dart';
import 'package:restaurant_app/src/router/routes.dart';

class ProfilePage extends StatelessWidget {
  final UserProfile userProfile;
  const ProfilePage({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(children: [
            Stack(children: [
              Image.asset(
                AppImages.bgImage,
                color: Colors.black,
                height: 123,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            // CustomBackButton(),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Text(
                              "Profile",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            Container(
              height: 228,
              width: width,
              decoration: BoxDecoration(
                  color: AppColors.orangeBg,
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width:
                        88, // Diameter of the CircleAvatar + Border width (2 * 4)
                    height: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.blue, // Border color
                        width: 2.0, // Border width
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(userProfile.imageUrl),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userProfile.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700, color: AppColors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ID: ${userProfile.id}',
                    style: TextStyle(color: AppColors.white),
                 
                  ),
                  Text(
                    userProfile.email,
                    style: TextStyle(color: AppColors.white),
                  
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  UserReviewItem(
                avatarImageUrl:AppIcons.profileIcon, // Example image URL
                title: 'Personal Info',
                onTap: () {
                  context.pushNamed(
                    AppRoute.personalInfoPage,
                    extra: userProfile,
                    );
                  // Define what happens when this item is tapped
                  print('Navigate to personal info');
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              UserReviewItem(
                avatarImageUrl:
                    AppIcons.settingIcon,
                  
                     // Example image URL
                title: 'Settings',
                onTap: () {
                  context.pushNamed(AppRoute.settingPage);


                  // Define what happens when this item is tapped
                  print('Navigate settings');
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              UserReviewItem(
                avatarImageUrl:
                  AppIcons.faqIcon, // Example image URL
                title: 'User Reviews',
                onTap: () {
                    context.pushNamed(AppRoute.reviewsPage);
                  print('Navigate to User Reviews');
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              UserReviewItem(
                avatarImageUrl:
                  AppIcons.payment, // Example image URL
                title: 'Orders History',
                onTap: () {
                    context.pushNamed(AppRoute.orderHistoryPage);
                  print('Navigate to Oders History');
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              UserReviewItem(
                avatarImageUrl:
                   AppIcons.logoutIcon, // Example image URL
                title: 'Log Out',
                onTap: () {

                  // Show the first dialog
            CustomDialog.showLogoutDialog(
              context: context,
              onLogout: () {
                // After user confirms, show the second dialog
                CustomDialog.showConfirmationDialog(
                  context: context,
                  message: "You’ve successfully Logged Out.",
                  onConfirm: () {
                    print("User has logged out.");
                  },
                );
              },
            );
                  



                  print('Navigate dialog');
                },
              ),
              
                ],
              ),
            ),
            
          ])),
    );
  }
}
