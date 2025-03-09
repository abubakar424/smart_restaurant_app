import 'package:flutter/material.dart';
import 'package:restaurant_app/src/common/constants/app_colors.dart';
import 'package:restaurant_app/src/common/constants/app_images.dart';
import 'package:restaurant_app/src/common/widgets/custom_back_button.dart';

class TermsConditionsPage extends StatefulWidget {
  const TermsConditionsPage({super.key});

  @override
  _TermsConditionsPageState createState() => _TermsConditionsPageState();
}

class _TermsConditionsPageState extends State<TermsConditionsPage> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Correct the width

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
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                "Terms & Conditions",
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
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(children: [
                  Container(
                    width: width, // Set container width to screen width
                    decoration: BoxDecoration(
                      color: AppColors.white, // Background color
                      borderRadius:
                          BorderRadius.circular(16), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blackColor
                              .withOpacity(0.1), // Shadow color
                          spreadRadius: 3, // Spread radius
                          blurRadius: 5, // Blur radius
                          offset: const Offset(0, 1), // Shadow position
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text(
                            'Our human-friendly Terms of Services for the platform prevails over the detailed one, which specifies all rights and obligations for both you and in more complex legaliese.',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  letterSpacing: 0,
                                ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'In the event of a contradiction between the two documents, the “human-friendly” Terms of Services shall prevall. That means no nasty surprises if you read only the human-friendly version.',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  letterSpacing: 0,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Last updated: June 27, 2024',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  letterSpacing: 0,
                                  color: AppColors.lightText)),
                    ],
                  )
                ]),
              )
          ],
        ),
      ),
    );
  }
}
