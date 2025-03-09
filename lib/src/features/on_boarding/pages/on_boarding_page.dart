import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_app/src/common/constants/app_images.dart';
import 'package:restaurant_app/src/common/constants/global_variables.dart';
import 'package:restaurant_app/src/router/routes.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  // List of data for the screens
  final List<Map<String, String>> _onboardingData = [
    {
      "image": AppImages.boardingFirst, // Image for screen 1
      "title": 'Nearby restaurants',
      "description":
          "You don't have to go far to find a good restaurant, we have provided all the restaurants that are near you."
    },
    {
      "image": AppImages.boardingSecond, // Image for screen 2
      "title": 'Select the Favorites Menu',
      "description":
          "Now eat well, don't leave the house, You can choose your favorite food only with one click."
    },
    {
      "image": AppImages.boardingThird, // Image for screen 3
      "title": 'Good food at a cheap price',
      "description":
          "You can eat at expensive restaurants with affordable prices."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) => OnboardingContent(
                image: _onboardingData[index]['image']!,
                title: _onboardingData[index]['title']!,
                description: _onboardingData[index]['description']!,
              ),
            ),
          ),
          // Page Indicator and Next Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Add functionality for skip button
                    _pageController.jumpToPage(2); // Jump to the last page
                  },
                  child: Text("Skip",
                      style: textTheme(context)
                          .titleSmall
                          ?.copyWith(color: colorScheme(context).outline)),
                ),
                Row(
                  children: List.generate(
                    _onboardingData.length,
                    (index) => buildDot(index: index),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: colorScheme(context).primary,
                  ),
                  onPressed: () {
                    print('Current page: $_currentPage');
                    if (_currentPage < _onboardingData.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    } else {
                      context.pushReplacementNamed(AppRoute.welcomePage);
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // Dots Indicator
  Widget buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 10,
      width: _currentPage == index ? 10 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? colorScheme(context).secondary
            : colorScheme(context).outline.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

// Onboarding Content Widget for Reusability
class OnboardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image, // Asset image path
            height: 300,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme(context).headlineMedium?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colorScheme(context)
                    .onSurface) /*TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )*/
            ,
          ),
          const SizedBox(height: 15),
          Text(description,
              textAlign: TextAlign.center,
              style: textTheme(context)
                  .titleSmall
                  ?.copyWith(color: colorScheme(context).outline)),
        ],
      ),
    );
  }
}
