import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/utils/validations.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../router/routes.dart';

class SignUpBottomSheet {
  static ValueNotifier<bool> isVisible = ValueNotifier(false);
  static ValueNotifier<bool> isLoading = ValueNotifier(false); // Replace isColor with isLoading
  static final _formKey = GlobalKey<FormState>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static void showSignupBottomSheet(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.all(20.0),
          child: StatefulBuilder(
            builder: (BuildContext context, setState) {
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
                            color: colorScheme(context).outline,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Text(
                          'Sign Up', // Update text to 'Sign Up'
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
                      // Name Field
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme(context).onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      CustomTextFormField(
                        controller: nameController,
                        validator: Validation.nameValidation,
                        hint: 'Enter your Name',
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
                        controller: emailController,
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
                      // Sign Up Button
                      Center(
                        child: ValueListenableBuilder(
                          valueListenable: isLoading,
                          builder: (context, value, child) => CustomButton(
                            isDisabled: value,
                            isLoading: value, // Add isLoading to CustomButton
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                FirebaseFirestore _fireStore = FirebaseFirestore.instance;
                                FirebaseAuth _auth = FirebaseAuth.instance;
                                final user = _auth.currentUser;
                                isLoading.value = true;
                                try {
                                  final authController = AuthController();
                                  await authController.signUpWithEmailAndPassword(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                  isLoading.value = false;
                                  await _fireStore.collection("userDetail").doc(user!.uid).set(
                                      {
                                        "name": nameController.text,
                                        "email": emailController.text
                                      });
                                  context.pushNamed(AppRoute.customNavBar);
                                } catch (e) {
                                  isLoading.value = false;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }
                              }
                            },
                            text: 'Sign Up', // Change to 'Sign Up'
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: ValueListenableBuilder(
                          valueListenable: isLoading,
                          builder: (context, value, child) => CustomButton(
                            isDisabled: value,
                            isLoading: value, // Add isLoading to CustomButton
                            onTap: () {
                              context.pop();
                            },
                            text: 'Already have an account', // Change to 'Sign Up'
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Google Sign-In Button
                      Center(
                        child: CustomButton(
                          onTap: () async {
                            isLoading.value = true;
                            try {
                              final authController = AuthController();
                              final user = await authController.signInWithGoogle();
                              isLoading.value = false;
                              if (user != null) {
                                context.pushNamed(AppRoute.customNavBar);
                              }
                            } catch (e) {
                              isLoading.value = false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          },
                          isIconRight: true,
                          iconWidget: SvgPicture.asset(AppIcons.googleIcon),
                          text: 'Sign Up with Google', // Change to 'Sign Up with Google'
                        ),
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
    ).whenComplete(() {
      // Dispose controllers when bottom sheet closes
      nameController.dispose();
      emailController.dispose();
      passwordController.dispose();
    });
  }
}

class AuthController{
  final FirebaseAuth _auth = FirebaseAuth.instance ;
  Future signUpWithEmailAndPassword({
    required String name ,
    required String email,
    required String password,
})
async {
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user?.updateDisplayName(name) ;
    } on FirebaseAuthException catch(e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use' :
          errorMessage = 'The email is already in use';
          break;
        case 'invalid-email':
          errorMessage = 'This email is invalid';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak.';
          break;
        default:
          errorMessage = 'An error occurred: ${e.message}';
      }
      throw Exception(errorMessage);
      }
    catch (e) {
      throw Exception('Sign-up failed: $e');


    }
}
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger Google Sign-In flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Obtain auth details from the request
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      throw Exception('Google Sign-In failed: $e');
    }
    }
}