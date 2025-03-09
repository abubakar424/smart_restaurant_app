import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_restaurant_app/src/features/food_list/pages/provider/food_list_provider.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../model/food_list/food_list_model.dart';
import 'food_list_detail_page.dart';

class FoodListPage extends StatefulWidget {
  const FoodListPage({super.key});

  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Adding initial product data to provider

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foodListProvider = Provider.of<FoodListProvider>(context, listen: true);

    return Scaffold(
      body: Column(
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
                top: 60,
                left: 10,
                right: 0,
                child: Text(
                  'Food List',
                  style: textTheme(context).headlineMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                    color: colorScheme(context).onSurface,
                  ),
                ),
              ),
            ],
          ),
          TabBar(
            labelColor: colorScheme(context).primary,
            unselectedLabelColor: colorScheme(context).onSurface,
            controller: _tabController,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Breakfast'),
              Tab(text: 'Lunch'),
              Tab(text: 'Dinner'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildProductList(foodListProvider.products),
                buildProductList(
                  foodListProvider.products
                      .where((product) => product!.foodList == 'Breakfast')
                      .toList(),
                ),
                buildProductList(
                  foodListProvider.products
                      .where((product) => product.foodList == 'Lunch')
                      .toList(),
                ),
                buildProductList(
                  foodListProvider.products
                      .where((product) => product.foodList == 'Dinner')
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductList(List<FoodListModel> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return foodListWidget(
          productId: product.id,
          name: product.name,
          image: product.image,
          price: product.price,
          review: product.review,
          foodList: product.foodList,
          rating: product.rating,
          descr: product.descr,
        );
      },
    );
  }

  Widget foodListWidget({
    required int productId,
    required String name,
    required String image,
    required String price,
    required String review,
    required String rating,
    required String descr,
    required String foodList,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodListDetailPage(productId: productId),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colorScheme(context).onPrimary,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 0.1,
              spreadRadius: 0.1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: image.startsWith('http')
                  ? CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                height: 100,
                width: 100,
                placeholder: (context, url) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: colorScheme(context).primary,
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Center(
                    child: Icon(
                      Icons.error,
                      color: colorScheme(context).onError,
                    ),
                  );
                },
              )
                  : Image.file(
                File(image),
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: textTheme(context).titleSmall!.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0,
                          color: colorScheme(context).onSurface,
                        ),
                      ),
                      const Icon(Icons.more_horiz_sharp),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.yellowGry.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            foodList,
                            style: textTheme(context).labelLarge!.copyWith(
                              color: AppColors.yellowTxt,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        price,
                        style: textTheme(context).titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rate_rounded,
                        color: colorScheme(context).primary,
                        size: 20,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        rating,
                        style: textTheme(context).labelMedium!.copyWith(
                          letterSpacing: 0,
                          fontWeight: FontWeight.w700,
                          color: colorScheme(context).primary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        review,
                        style: textTheme(context).labelMedium!.copyWith(
                          letterSpacing: 0,
                          color: colorScheme(context).outline,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Pick UP',
                        style: textTheme(context).labelMedium!.copyWith(
                          letterSpacing: 0,
                          color: colorScheme(context).outline,
                        ),
                      ),
                    ],
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
