import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Ensure GoRouter is being used for navigation

class CustomBackButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.pop(); // Uses GoRouter's pop method to navigate back
      },
      icon: Icon(
        Icons.arrow_back,// Allows customizable color
      ),
    );
  }
}
