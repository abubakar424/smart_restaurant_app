import 'package:flutter/material.dart';
import 'package:restaurant_app/src/common/constants/app_colors.dart';
import 'package:restaurant_app/src/common/constants/app_images.dart';
import 'package:restaurant_app/src/common/widgets/custom_back_button.dart';
import 'package:restaurant_app/src/dummy_data/faq_list.dart';
import 'package:restaurant_app/src/model/profile/faq_model.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  final List<FAQItem> _faqItems = FAQData.faqItems;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Stack(
              children: [
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomBackButton(),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                "FAQ'S",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find important information and update about any recent changes and fees here.',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: AppColors.lightText,
                          letterSpacing: 0,
                        ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    "General",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.orangeBg,
                          letterSpacing: 0,
                        ),
                  ),
                  ListView.builder(
                    itemCount: _faqItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 1.0,
                        margin: const EdgeInsets.symmetric(
                          vertical: 4.0,
                        ),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.transparent), // No border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              dividerColor: Colors
                                  .transparent), // Removes internal dividers
                          child: ExpansionTile(
                            title: Text(
                              _faqItems[index].question,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: 0,
                                  ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, bottom: 12, right: 16, top: 8),
                                child: Text(
                                  _faqItems[index].answer,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: 0,
                                      ),
                                ),
                              ),
                            ],
                            trailing: Icon(
                              _faqItems[index].isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: AppColors.iconColor,
                            ),
                            onExpansionChanged: (bool expanded) {
                              setState(() {
                                _faqItems[index].isExpanded = expanded;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
