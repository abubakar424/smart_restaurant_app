import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_app/src/common/utils/validations.dart';
import 'package:restaurant_app/src/common/widgets/custom_button.dart';
import 'package:restaurant_app/src/router/routes.dart';

import '../../../common/constants/global_variables.dart';
import '../../../common/widgets/custom_text_field.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  ValueNotifier<bool> isColor = ValueNotifier(true);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 24.0), // Adds horizontal padding
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Aligns content to start
              children: [
                const SizedBox(height: 24), // Adjusts top spacing
                Text(
                  'Forget Password',
                  style: textTheme(context).headlineMedium?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).onSurface),
                ),
                const SizedBox(height: 10),

                // Description Text
                Text(
                  'Enter your registered email below',
                  style: textTheme(context)
                      .titleSmall
                      ?.copyWith(color: colorScheme(context).outline),
                ),
                SizedBox(
                    height:
                        height * 0.06), // Adjust spacing between text and input

                // Email Label
                Text(
                  'Email address',
                  style: TextStyle(
                      fontSize: 14,
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),

                // Email Input Field
                CustomTextFormField(
                  validator: (value) =>
                      Validation.fieldValidation(value, 'Name'),
                  hint: 'Eg namaemail@emailkamu.com',
                ),
                const SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    text: 'Remember the password?',
                    style: textTheme(context).bodyMedium?.copyWith(
                          color: colorScheme(context).outline,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Sign in',
                        style: textTheme(context).bodyMedium?.copyWith(
                              color: colorScheme(context).secondary,
                            ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(
                  height: height * 0.4,
                ),
                Center(
                  child: ValueListenableBuilder(
                    valueListenable: isColor,
                    builder: (context, value, child) => GestureDetector(
                      onTap: () {
                        isColor.value = !isColor.value;
                        if (_formKey.currentState!.validate()) {
                          context.pushNamed(AppRoute.backEmailPage);
                        }
                      },
                      child: AbsorbPointer(
                        // Prevent interaction with the button when disabled, but still detect taps
                        absorbing:
                            value, // absorb pointer when button is disabled
                        child: CustomButton(
                          isDisabled:
                              value, // The button will be disabled based on this value
                          onTap: () {
                            isColor.value = !isColor.value;
                            context.pushNamed(AppRoute.backEmailPage);
                          },
                          text: 'Submit',
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20), // Extra space at the bottom

                // Sign in link
              ],
            ),
          ),
        ),
      ),
    );
  }
}
