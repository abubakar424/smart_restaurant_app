import 'package:flutter/material.dart';
import 'package:smart_restaurant_app/scr/common/widgets/custom_elevated_button.dart';
import 'package:smart_restaurant_app/scr/common/widgets/custom_textformfield.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(onPressed: () {}, text: "Login"),
            SizedBox(
              height: 30,
            ),
            CustomTextFormField()
          ],
        ),
      ),
    );
  }
}
