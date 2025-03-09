import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_app/src/common/constants/app_colors.dart';
import 'package:restaurant_app/src/common/constants/app_images.dart';
import 'package:restaurant_app/src/router/routes.dart';

class CustomDialog {
  // Method to show the first dialog (Are you sure to log out?)
  static void showLogoutDialog({
    required BuildContext context,
    required VoidCallback onLogout,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Container(
              constraints: const BoxConstraints(),
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Center horizontally
                  children: [
                    SvgPicture.asset(
                      AppIcons.logout1,
                      height: 50, // Set a size if needed
                      width: 50,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Oh no! You're leaving...\nAre you sure?",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: AppColors.blackColor,
                                  letterSpacing: 0),
                          textAlign: TextAlign.left, // Center text horizontally
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _CustomButton(
                      text: "Nah, Just Kidding",
                      fillColor: AppColors.blue,
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    const SizedBox(height: 8),
                    _CustomButton(
                      text: "Yes, Log Me Out",
                      fillColor: AppColors.white,
                      onPressed: () {
                        context.pop();
                        onLogout(); // Trigger the logout action (show second dialog)
                      },
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }

  // Method to show the confirmation dialog (Successfully logged out)
  static void showConfirmationDialog({
    required BuildContext context,
    required String message,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center horizontally
              children: [
                SvgPicture.asset(
                  AppIcons.thubmsUp,
                  height: 50, // Set a size if needed
                  width: 50,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You've Successfully",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: AppColors.blackColor,
                                  letterSpacing: 0),
                          textAlign:
                              TextAlign.center, // Center text horizontally
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Logged Out. ",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: AppColors.blackColor,
                                  letterSpacing: 0),
                          textAlign:
                              TextAlign.center, // Center text horizontally
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _CustomButton(
                  text: "Back to Login",
                  fillColor: AppColors.blue,
                  onPressed: () {
                    context.pushNamed(AppRoute.welcomePage); // Close the dialog
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// _CustomButton is a private widget with a blue border and dynamic fill/text color
class _CustomButton extends StatelessWidget {
  final String text;
  final Color fillColor;
  final VoidCallback onPressed;

  const _CustomButton({
    Key? key,
    required this.text,
    required this.fillColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: AppColors.blue),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0, // No shadow
          backgroundColor: fillColor, // Background color
          side: BorderSide(color: AppColors.blue), // Blue border
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
        ),
        child: Text(text,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: fillColor == AppColors.white
                      ? AppColors.blue
                      : AppColors.white, // Dynamic text color
                  letterSpacing: 0,
                )),
      ),
    );
  }
}
