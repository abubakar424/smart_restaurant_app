import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/widgets/custom_back_button.dart';
import '../../../model/profile/user_profile_model.dart';
import '../../../router/routes.dart';
import '../widgets/profile_info_card.dart';


class PersonalInfoPage extends StatefulWidget {
  final UserProfile userProfile;

  const PersonalInfoPage({super.key, required this.userProfile});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  late UserProfile userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = widget.userProfile; // Initialize with passed userProfile
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width; // Corrected

    return Scaffold(
      body: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),

        child: Column(
          children: [
            Stack(
              children: [
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
                              CustomBackButton(),
                              SizedBox(width: width * 0.02),
                              Text(
                                "Personal Profile",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () async {
                                  final updatedProfile = await context.pushNamed(
                                    AppRoute.editProfilePage,
                                    extra: userProfile,
                                  );
                                  if (updatedProfile != null &&
                                      updatedProfile is UserProfile) {
                                    // Update the userProfile with edited data
                                    setState(() {
                                      userProfile = updatedProfile;
                                    });
                                  }
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      'Edit',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: AppColors.blue,
                                          ),
                                    ),
                                    Container(
                                      height: 1,
                                      width: 24,
                                      color: AppColors.blue,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.blue, // Border color
                            width: 3.0, // Border width
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 50, // Adjust size
                          backgroundImage: NetworkImage(userProfile.imageUrl),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      SizedBox(width: width * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userProfile.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            userProfile.bio != null &&
                                    userProfile.bio!.isNotEmpty
                                ? userProfile.bio!
                                : "No bio available",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(height: height * 0.02),
                  UserInfoCard(
                    fullName: userProfile.name,
                    email: userProfile.email,
                    phoneNumber: userProfile.phone,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
