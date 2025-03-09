import 'package:flutter/material.dart';


import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/widgets/custom_back_button.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

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
                              Row(
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
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.logo,
                            height: 50,
                            // width: width,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text("Version",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  letterSpacing: 0)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('1.5.4',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  color: AppColors.lightText)),
                      const SizedBox(
                        height: 30,
                      ),
                      Text("Update",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  letterSpacing: 0)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('to update app',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  color: AppColors.lightText)),
                    ]),
              )
            ])));
  }
}
