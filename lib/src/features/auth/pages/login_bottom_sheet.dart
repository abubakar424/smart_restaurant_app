import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_restaurant_app/src/features/auth/pages/signup_bottom_sheet.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/utils/validations.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../router/routes.dart';

class LoginBottomSheet {
  static ValueNotifier<bool> isVisible = ValueNotifier(false);
  static ValueNotifier<bool> isLoading = ValueNotifier(false);
  static final _formKey = GlobalKey<FormState>();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static String _getFirebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found for this email. Would you like to create one?';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'Login failed: ${e.message}';
    }
  }

  static void showLoginBottomSheet(BuildContext context) {
    final bottomSheet = showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return ScaffoldMessenger(
          key: scaffoldMessengerKey,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 6,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
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
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Email address',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        CustomTextFormField(
                          controller: emailController,
                          validator: Validation.emailValidation,
                          hint: 'Eg namaemail@emailkamu.com',
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ValueListenableBuilder(
                          valueListenable: isVisible,
                          builder: (context, value, child) => CustomTextFormField(
                            controller: passwordController,
                            obscureText: value,
                            validator: Validation.passwordValidation,
                            hint: 'Password',
                            suffixIcon: InkWell(
                              onTap: () => isVisible.value = !isVisible.value,
                              child: Icon(
                                value ? Icons.visibility_off : Icons.visibility,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => context.pushNamed(AppRoute.forgetPasswordPage),
                            child: Text(
                              'Forget Password?',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: ValueListenableBuilder(
                            valueListenable: isLoading,
                            builder: (context, value, child) => CustomButton(
                              isDisabled: value,
                              isLoading: value,
                              onTap: () async {
                                debugPrint('LoginBottomSheet: Login button tapped');

                                if (_formKey.currentState!.validate()) {
                                  debugPrint('LoginBottomSheet: Form validated, attempting login');
                                  isLoading.value = true;
                                  try {
                                    final userCredential = await AuthServices().signInUser(
                                      context: context,
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                    debugPrint('LoginBottomSheet: Login successful, user: ${userCredential.user?.email}');
                                    isLoading.value = false;
                                    scaffoldMessengerKey.currentState?.showSnackBar(
                                      const SnackBar(content: Text('Login successful!')),
                                    );
                                    if (context.mounted) {
                                      context.pushReplacementNamed(AppRoute.customNavBar); // Use pushReplacementNamed to avoid stacking
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    isLoading.value = false;
                                    debugPrint('LoginBottomSheet: FirebaseAuthException: ${e.code} - ${e.message}');
                                    String errorMessage = _getFirebaseAuthErrorMessage(e);

                                    if (e.code == 'user-not-found') {
                                      debugPrint('LoginBottomSheet: Showing user-not-found dialog');
                                      if (context.mounted) {
                                        await showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (dialogContext) => AlertDialog(
                                            title: const Text('Account Not Found'),
                                            content: const Text(
                                              'No account exists for this email. Would you like to create an account?',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.of(dialogContext).pop(),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(dialogContext).pop();
                                                  Navigator.of(context).pop(); // Close login bottom sheet
                                                  SignUpBottomSheet.showSignupBottomSheet(context);
                                                },
                                                child: const Text('Create Account'),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    } else {
                                      scaffoldMessengerKey.currentState?.showSnackBar(
                                        SnackBar(content: Text(errorMessage)),
                                      );
                                    }
                                  } catch (e) {
                                    isLoading.value = false;
                                    debugPrint('LoginBottomSheet: Unexpected error: $e');
                                    scaffoldMessengerKey.currentState?.showSnackBar(
                                      SnackBar(content: Text('Login failed: ${e.toString()}')),
                                    );
                                  }
                                } else {
                                  debugPrint('LoginBottomSheet: Form validation failed');
                                  isLoading.value = false;
                                  scaffoldMessengerKey.currentState?.showSnackBar(
                                    const SnackBar(content: Text('Please fill in valid email and password.')),
                                  );
                                }
                              },
                              text: 'Login',
                            ),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Center(
                          child: ValueListenableBuilder(
                            valueListenable: isLoading,
                            builder: (context, value, child) => CustomButton(
                              isDisabled: value,
                              onTap: () => SignUpBottomSheet.showSignupBottomSheet(context),
                              text: 'Sign Up',
                            ),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Center(
                          child: CustomButton(
                            onTap: () {},
                            isIconRight: true,
                            isDisabled: true,
                            iconWidget: SvgPicture.asset(AppIcons.googleIcon),
                            text: 'Login with Google',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );

    bottomSheet.whenComplete(() {
      emailController.clear();
      passwordController.clear();
    });
  }
}

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('AuthServices: Attempting to sign in with email: $email');
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('AuthServices: Sign-in successful, user: ${userCredential.user?.email}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint('AuthServices: FirebaseAuthException: ${e.code} - ${e.message}');
      throw e; // Use throw instead of rethrow to ensure error is passed
    } catch (e) {
      debugPrint('AuthServices: Unexpected error: $e');
      throw Exception('Unexpected error during sign-in: $e');
    }
  }
}