import 'package:flutter/material.dart';
import 'package:restaurant_app/src/common/constants/app_images.dart';
import 'package:restaurant_app/src/common/widgets/custom_back_button.dart';
import 'package:restaurant_app/src/dummy_data/reviews_list.dart';
import 'package:restaurant_app/src/features/profile/widgets/custom_reviews_card.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({
    super.key,
  });

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(children: [
            Stack(children: [
              Image.asset(
                AppImages.bgImage,
                color: Colors.black,
                height: 123,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            CustomBackButton(),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Text(
                              "Reviews",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 16),
            // Constrain the height of the ListView.builder using Expanded
            // or SizedBox with a fixed height.
            SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return ReviewCard(review: reviews[index]);
                },
              ),
            )
          ])),
    );
  }
}
