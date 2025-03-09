import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_app/src/common/constants/app_images.dart';

import '../../../common/constants/global_variables.dart';
import '../../../common/widgets/custom_button.dart';

class ChangePasswordSuccessfully extends StatelessWidget {
  const ChangePasswordSuccessfully({super.key});

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
            SvgPicture.asset(AppIcons.successIcon),

            // Title Text
            Text(
              'Success',
              style: textTheme(context).headlineMedium?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorScheme(context).onSurface),
            ),
            const SizedBox(height: 10),

            // Description Text
            Text(
              'Congratulations your password has been changed,',
              textAlign: TextAlign.center,
              style: textTheme(context)
                  .titleSmall
                  ?.copyWith(color: colorScheme(context).outline),
            ),
            SizedBox(
              height: height * 0.05,
            ),

            SizedBox(height: height * 0.2),

            // Get Started Button
            CustomButton(onTap: () {}, text: 'Sign In'),

            const SizedBox(height: 20),

            // Terms and Conditions Text
          ],
        ),
      ),
    );
  }
}
