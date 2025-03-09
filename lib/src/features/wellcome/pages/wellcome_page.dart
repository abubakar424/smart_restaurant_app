import 'package:flutter/material.dart';
import 'package:restaurant_app/src/features/auth/pages/login_bottom_sheet.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/widgets/custom_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top Image
            Image.asset(
              AppImages.wellcomePic, // Replace with your actual image path
            ),
            const SizedBox(height: 30),

            // Title Text
            Text(
              'Welcome',
              style: textTheme(context).headlineMedium?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorScheme(context).onSurface),
            ),
            const SizedBox(height: 10),

            // Description Text
            Text(
              'Before Enjoying Foodmedia Services\nPlease Register First',
              textAlign: TextAlign.center,
              style: textTheme(context)
                  .titleSmall
                  ?.copyWith(color: colorScheme(context).outline),
            ),
            SizedBox(height: height * 0.1),

            // Get Started Button
            CustomButton(
                onTap: () {
                  LoginBottomSheet.showLoginBottomSheet(context);
                },
                text: 'Get Started'),

            const SizedBox(height: 20),

            // Terms and Conditions Text
            Text.rich(
              TextSpan(
                text: 'By Logging In Or Registering, You Have Agreed To ',
                style: textTheme(context).bodyMedium?.copyWith(
                      color: colorScheme(context).outline,
                    ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'The Terms And Conditions',
                    style: textTheme(context).bodyMedium?.copyWith(
                          color: colorScheme(context).secondary,
                        ),
                  ),
                  TextSpan(
                    text: ' And ',
                    style: textTheme(context).bodyMedium?.copyWith(
                          color: colorScheme(context).outline,
                        ),
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: textTheme(context).bodyMedium?.copyWith(
                          color: colorScheme(context).secondary,
                        ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
