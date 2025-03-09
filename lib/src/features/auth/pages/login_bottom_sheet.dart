import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/utils/validations.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../router/routes.dart';

class LoginBottomSheet {
  static ValueNotifier<bool> isVisible = ValueNotifier(false);
  static ValueNotifier<bool> isColor = ValueNotifier(true);
  static final _formKey = GlobalKey<FormState>();
  static void showLoginBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows custom height control
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height *
              0.7, // Set height to 70% of screen
          padding: const EdgeInsets.all(20.0),
          child: StatefulBuilder(
            // Use StatefulBuilder to manage button state
            builder: (BuildContext context, setState) {
              // State variable to track button press
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 6,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colorScheme(context).outline),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: colorScheme(context).primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Container(
                          height: 4,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colorScheme(context).primary),
                        ),
                      ),
                      const SizedBox(height: 20),
                  
                      // Email Field
                      Text(
                        'Email address',
                        style: TextStyle(
                            fontSize: 14,
                            color: colorScheme(context).onSurface,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      const CustomTextFormField(
                        validator: Validation.emailValidation,
                        hint: 'Eg namaemail@emailkamu.com',
                      ),
                      const SizedBox(height: 20),
                      // Password Field
                      Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 14,
                            color: colorScheme(context).onSurface,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      ValueListenableBuilder(
                        valueListenable: isVisible,
                        builder: (context, value, child) => CustomTextFormField(
                          obscureText: value,
                          validator: Validation.passwordValidation,
                          hint: 'Password',
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
                  
                      // Forget Password Link
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                              context.pushNamed(AppRoute.forgetPasswordPage);
                            // }
                          },
                          child: Text('Forget Password?',
                              style: textTheme(context).titleSmall?.copyWith(
                                  color: colorScheme(context).secondary)),
                        ),
                      ),
                      const SizedBox(height: 20),
                  
                      // Login Button
                      Center(
                        child: ValueListenableBuilder(
                          valueListenable: isColor,
                          builder: (context, value, child) => GestureDetector(
                            onTap: () {
                              isColor.value = !isColor.value;
                              if (_formKey.currentState!.validate()) {
                                context.pushNamed(AppRoute.customNavBar);
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
                                  // Toggle the button's state only when not disabled
                                  isColor.value = !isColor.value;
                                },
                                text: 'Login',
                              ),
                            ),
                          ),
                        ),
                      ),
                  
                      const SizedBox(height: 15),
                      Center(
                        child: CustomButton(
                            onTap: () {},
                            isIconRight: true,
                            isDisabled: true,
                            iconWidget: SvgPicture.asset(AppIcons.googleIcon),
                            text: 'Login with Google'),
                      ),
                  
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
