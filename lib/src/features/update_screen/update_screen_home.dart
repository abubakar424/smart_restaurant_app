import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_images.dart';
class HomeUpdateScreen extends StatelessWidget {
  const HomeUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      AppImages.bgImage,
                      color: Colors.black,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 71),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Exclusive Offer \n Just for you!',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.offerColor,
                          ),
                        ),
                        Image.asset(
                          AppImages.sheff,
                          height: 130,
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 180,
                    right: 15,
                    child: Image.asset(
                      AppImages.sandwitch,
                      height: 23,
                      width: 35,
                    ),
                  ),
                  Positioned(
                    top: 150,
                    right: 110,
                    child: Image.asset(
                      AppImages.zinger,
                      height: 28,
                      width: 40,
                    ),
                  ),
                ],
              ),
            ),
            RectImages(image: Image.asset(AppImages.rectangle1)),
            const SizedBox(height: 15),
            RectImages(image: Image.asset(AppImages.rectangle2)),
            const SizedBox(height: 15),
            RectImages(image: Image.asset(AppImages.rectangle3)),
          ],
        ),
      ),
    );
  }
}

class RectImages extends StatelessWidget {
  final Widget image;
  final double height;
  final double width;
  const RectImages({
    super.key,
    required this.image,
    this.height = 170,
    this.width = 370,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showConfirmationDialogue(context);
      },
      child: ClipRect(
        child: SizedBox(
          height: height,
          width: width,
          child: image,
        ),
      ),
    );
  }
}

void showConfirmationDialogue(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  final ColorScheme colorScheme = theme.colorScheme;
  final TextTheme textTheme = theme.textTheme;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(
            'Are you sure?',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
        content: Text(
          'Do you want to delete this item permanently?',
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 17,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  minimumSize: const Size(78,30)
                  // Use primary color from the color scheme
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  'Cancel',
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.surface
                  ),
                ),
              ),
              const SizedBox(width: 16), // Add spacing between buttons
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.surface,
                    minimumSize: const Size(78,30)
                  // Use error color for the delete button
                ),
                onPressed: () {
                  // Perform delete operation here
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  'Delete',
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.primary
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}