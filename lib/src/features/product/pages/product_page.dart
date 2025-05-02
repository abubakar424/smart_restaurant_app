import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_restaurant_app/src/common/utils/custom_snackbar.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../router/routes.dart';
import '../../food_list/pages/food_list_detail_page.dart';
import '../model/product_model.dart';
import '../provider/product_provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Fetch products when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: true);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme(context).primary,
        child: Icon(Icons.add, color: colorScheme(context).onPrimary),
        onPressed: () {
          context.pushNamed(AppRoute.addProductPage);
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  AppImages.bgImage,
                  color: Colors.black,
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 20,
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
                              SizedBox(width: size.width * 0.02),
                              Text(
                                "Food Lists",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TabBar(
                            dividerColor: Colors.transparent,
                            labelColor: colorScheme(context).primary,
                            unselectedLabelColor: colorScheme(context).onSurface,
                            controller: _tabController,
                            tabs: const [
                              Tab(text: 'Food'),
                              Tab(text: 'Drinks'),
                              Tab(text: 'Stock'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  buildProductList(
                    productProvider.products
                        .where((product) => product.productCategory == 'Foods')
                        .toList(),
                  ),
                  buildProductList(
                    productProvider.products
                        .where((product) => product.productCategory == 'Drinks')
                        .toList(),
                  ),
                  buildProductList(
                    productProvider.products
                        .where((product) => product.productCategory == 'Stock')
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductList(List<ProductModel> products) {
    if (products.isEmpty) {
      return const Center(child: Text("No products available"));
    }
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return foodListWidget(
          productId: product.productId,
          productName: product.productName,
          productImage: product.productImage,
          productPrice: product.productPrice,
          productCategory: product.productCategory,
          productDescr: product.productDescr,
        );
      },
    );
  }

  Widget foodListWidget({
    required int productId,
    required String productName,
    required String productImage,
    required String productPrice,
    required String productDescr,
    required String productCategory,
  }) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
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
              child: productImage.startsWith('http')
                  ? CachedNetworkImage(
                imageUrl: productImage,
                fit: BoxFit.cover,
                height: 100,
                width: 100,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: colorScheme(context).primary,
                  ),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(
                    Icons.error,
                    color: colorScheme(context).onError,
                  ),
                ),
              )
                  : Image.file(
                File(productImage),
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productName,
                        style: textTheme(context).titleSmall!.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0,
                          color: colorScheme(context).onSurface,
                        ),
                      ),
                      PopupMenuButton<int>(
                        onSelected: (value) async {
                          try {
                            if (value == 1) {
                              if (_tabController.index == 2) {
                                await productProvider
                                    .restoreProductCategory(productId);
                              } else {
                                await productProvider.moveToStack(productId);
                              }
                            } else if (value == 2) {
                              await productProvider.removeProduct(productId);
                            }
                          } catch (e) {
                            showSnackbar(
                              message: "Operation failed: $e",
                              isError: true,
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem<int>(
                            value: 1,
                            child: Row(
                              children: [
                                const Icon(Icons.edit, color: Colors.blue),
                                const SizedBox(width: 10),
                                Text(
                                  _tabController.index == 2 ? "Restock" : "OutStock",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const PopupMenuItem<int>(
                            value: 2,
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red),
                                SizedBox(width: 10),
                                Text("Delete",
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                        ],
                        child: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    r"$" + productPrice,
                    style: textTheme(context).titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                      color: AppColors.blackColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    productDescr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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