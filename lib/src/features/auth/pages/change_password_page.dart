import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/utils/validations.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../router/routes.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ChangePasswordPage> {
  ValueNotifier<bool> isColor = ValueNotifier(true);
  ValueNotifier<bool> isVisible = ValueNotifier(false);
  ValueNotifier<bool> confirmVisible = ValueNotifier(false);
  final _formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
              horizontal: 20.0), // Adds horizontal padding
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Aligns content to start
              children: [
                const SizedBox(height: 24), // Adjusts top spacing
                Text(
                  'Change New Password',
                  style: textTheme(context).headlineMedium?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).onSurface),
                ),
                const SizedBox(height: 10),

                // Description Text
                Text(
                  'Enter a different password with the previous',
                  style: textTheme(context)
                      .titleSmall
                      ?.copyWith(color: colorScheme(context).outline),
                ),
                SizedBox(
                    height:
                        height * 0.06), // Adjust spacing between text and input

                // Email Label
                Text(
                  'New Password',
                  style: TextStyle(
                      fontSize: 14,
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),

                // Email Input Field
                ValueListenableBuilder(
                  valueListenable: isVisible,
                  builder: (context, value, child) => CustomTextFormField(
                    obscureText: value,
                    hint: 'New Password',
                    controller: newPasswordController,
                    validator: Validation.passwordValidation,
                    suffixIcon: InkWell(
                      onTap: () {
                        isVisible.value = !isVisible.value;
                      },
                      child: Icon(
                        value ? Icons.visibility_off : Icons.visibility,
                        color: colorScheme(context).outline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Confirm Password',
                  style: TextStyle(
                      fontSize: 14,
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),

                // Email Input Field
                ValueListenableBuilder(
                  valueListenable: confirmVisible,
                  builder: (context, value, child) => CustomTextFormField(
                    obscureText: value,
                    validator: (value) => Validation.confirmPassword(
                        value, newPasswordController.text),
                    hint: 'Confirm Password',
                    suffixIcon: InkWell(
                      onTap: () {
                        confirmVisible.value = !confirmVisible.value;
                      },
                      child: Icon(
                        value ? Icons.visibility_off : Icons.visibility,
                        color: colorScheme(context).outline,
                      ),
                    ),
                  ),
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
                          context
                              .pushNamed(AppRoute.changePasswordSuccessfully);
                        }
                      },
                      child: AbsorbPointer(
                        // Prevent interaction with the button when disabled, but still detect taps
                        absorbing:
                            value, // absorb pointer when button is disabled
                        child: CustomButton(
                          isDisabled: value,
                          // The button will be disabled based on this value
                          onTap: () {
                            // Toggle the button's state only when not disabled
                            isColor.value = !isColor.value;
                          },
                          text: 'Reset Password',
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
