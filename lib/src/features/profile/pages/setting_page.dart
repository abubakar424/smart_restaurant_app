import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/widgets/custom_back_button.dart';
import '../../../router/routes.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int selectedIndex = -1; // This will hold the index of the selected container

  @override
  Widget build(BuildContext context) {
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
                            CustomBackButton(),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Text(
                              "Settings",
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
            Column(
              children: [
                _CustomSelectableContainer(
                  index: 0,
                  title: 'About App',
                  isSelected: selectedIndex == 0,
                  onTap: () {
                    context.pushNamed(AppRoute.aboutAppPage);
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                ),
                // _CustomSelectableContainer(
                //   index: 1,
                //   title: 'Feedback',
                //   isSelected: selectedIndex == 1,
                //   onTap: () {
                //     setState(() {
                //       selectedIndex = 1;
                //     });
                //   },
                // ),
                _CustomSelectableContainer(
                  index: 2,
                  title: 'Terms and Conditions',
                  isSelected: selectedIndex == 2,
                  onTap: () {
                    context.pushNamed(AppRoute.termsConditionsPage);

                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                ),
                _CustomSelectableContainer(
                  index: 3,
                  title: 'Privacy Policy',
                  isSelected: selectedIndex == 3,
                  onTap: () {
                    context.pushNamed(AppRoute.privacyPolicyPage);
                    setState(() {
                      selectedIndex = 3;
                    });
                  },
                ),
                _CustomSelectableContainer(
                  index: 4,
                  title: 'FAQs',
                  isSelected: selectedIndex == 4,
                  onTap: () {
                    context.pushNamed(AppRoute.fAQPage);

                    setState(() {
                      selectedIndex = 4;
                    });
                  },
                ),
              ],
            ),
          ])),
    );
  }
}

class _CustomSelectableContainer extends StatelessWidget {
  final int index;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _CustomSelectableContainer({
    Key? key,
    required this.index,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 43,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white, // Background color
          border: Border.all(
            color: isSelected ? AppColors.blue : AppColors.tabColor,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Shadow color
              spreadRadius: 1,
              // blurRadius: 2,
              offset: const Offset(0, 0.5), // Shadow position (slight offset)
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 50),
        child: Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.5,
                  fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
