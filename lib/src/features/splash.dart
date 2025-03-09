import 'package:flutter/material.dart';
import 'package:restaurant_app/src/common/constants/global_variables.dart';
import 'package:restaurant_app/src/common/widgets/custom_button.dart';
import 'package:restaurant_app/src/common/widgets/custom_text_field.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: colorScheme(context).primary,
                ),
                padding: EdgeInsets.all(16),
                child: Text(
                  "Rstaurant App",
                  style: textTheme(context)
                      .displaySmall
                      ?.copyWith(color: colorScheme(context).onPrimary),
                )),
            Text(
              "Restaurant",
              style: textTheme(context)
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            CustomTextFormField(),
            CustomButton(
              onTap: () {},
              text: "Get Started",
            ),
          ],
        ),
      ),
    );
  }
}
