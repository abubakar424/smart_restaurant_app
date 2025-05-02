import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_restaurant_app/src/features/auth/pages/signup_bottom_sheet.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/utils/validations.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../router/routes.dart';

class LoginBottomSheet {
  static ValueNotifier<bool> isVisible = ValueNotifier(false);
  static ValueNotifier<bool> isLoading = ValueNotifier(false);
  static final _formKey = GlobalKey<FormState>();
  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _passwordController = TextEditingController();

  static void showLoginBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.all(20.0),
          child: Form(
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
                        color: colorScheme(context).outline,
                      ),
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
                        color: colorScheme(context).primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email Field
                  Text(
                    'Email address',
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  CustomTextFormField(
                    controller: _emailController,
                    validator: Validation.emailValidation,
                    hint: 'Eg namaemail@emailkamu.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ValueListenableBuilder(
                    valueListenable: isVisible,
                    builder: (context, value, child) => CustomTextFormField(
                      controller: _passwordController,
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
                        context.pushNamed(AppRoute.forgetPasswordPage);
                      },
                      child: Text(
                        'Forget Password?',
                        style: textTheme(context).titleSmall?.copyWith(
                          color: colorScheme(context).secondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Button
                  ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, loading, child) {
                      return Center(
                        child: CustomButton(
                          onTap: loading ? null : () => _loginUser(context),
                          text: loading ? 'Logging in...' : 'Login',
                          isDisabled: loading,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  // Sign Up Button
                  Center(
                    child: CustomButton(
                      onTap: () {
                        Navigator.pop(context); // Close login sheet
                        SignUpBottomSheet.showSignupBottomSheet(context);
                      },
                      text: 'Sign Up',
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Google Login Button
                  Center(
                    child: CustomButton(
                      onTap: () => _signInWithGoogle(context),
                      isIconRight: true,
                      isDisabled: isLoading.value,
                      iconWidget: SvgPicture.asset(AppIcons.googleIcon),
                      text: 'Login with Google',
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> _loginUser(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        // Successfully logged in
        if (context.mounted) {
          context.goNamed(AppRoute.customNavBar);
        }
      }
      _emailController.clear();
      _passwordController.clear();
      isLoading.value = false;
      isVisible.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;

      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is invalid.';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      isLoading.value = false;
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred: $e')),
        );
      }
    }
  }

  static Future<void> _signInWithGoogle(BuildContext context) async {
    isLoading.value = true;

    try {
      // This requires you to set up Google Sign-In in Firebase
      // and add the google_sign_in package to your pubspec.yaml
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithPopup(googleProvider);

      if (userCredential.user != null && context.mounted) {
        context.goNamed(AppRoute.customNavBar);
      }
    } catch (e) {
      isLoading.value = false;
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign in with Google: $e')),
        );
      }
    }
  }
}