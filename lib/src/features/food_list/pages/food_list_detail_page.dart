import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/utils/custom_snackbar.dart';
import '../../../common/utils/image_picker_helper.dart';
import '../../product/model/product_model.dart';
import '../../product/provider/product_provider.dart';
import 'product_add_page.dart';

class FoodListDetailPage extends StatefulWidget {
  final int productId; // Pass the product ID for tracking

  const FoodListDetailPage({super.key, required this.productId});

  @override
  State<FoodListDetailPage> createState() => _FoodListDetailPageState();
}

class _FoodListDetailPageState extends State<FoodListDetailPage> {
  String? selectImage;

  @override
  Widget build(BuildContext context) {
    // Get the product from the provider using the ID
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    final ProductModel product;
    try {
      product = productProvider.getProductById(widget.productId);
    } catch (e) {
      // Handle case where product is not found
      return Scaffold(
        body: Center(
          child: Text(
            "Product not found",
            style: textTheme(context).titleLarge,
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  AppImages.bgImage,
                  color: Colors.black,
                  fit: BoxFit.cover,
                  height: 200, // Adjusted for better layout
                ),
                Positioned(
                  top: 60,
                  left: 20,
                  child: InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.42,
                    width: double.infinity,
                    child: selectImage != null
                        ? Image.file(
                      File(selectImage!),
                      fit: BoxFit.cover,
                    )
                        : (product.productImage.isNotEmpty &&
                        product.productImage.startsWith('http')
                        ? CachedNetworkImage(
                      imageUrl: product.productImage,
                      fit: BoxFit.cover,
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
                        : Image.asset(
                      product.productImage,
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
                Positioned(
                  top: 117,
                  right: 10,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: colorScheme(context).primaryContainer,
                    child: InkWell(
                      onTap: () async {
                        ImagePickerHelper.showImageSourceSelection(
                          context,
                          onTapCamera: () async {
                            final XFile? image =
                            await ImagePickerHelper.pickImageFromCamera();
                            if (image != null) {
                              try {
                                setState(() {
                                  selectImage = image.path;
                                });
                                // Update image in Firebase
                                await productProvider.updateProductImage(
                                    widget.productId, File(image.path));
                                showSnackbar(
                                  message: "Image updated successfully",
                                  isError: false,
                                );
                              } catch (e) {
                                showSnackbar(
                                  message: "Failed to update image: $e",
                                  isError: true,
                                );
                                setState(() {
                                  selectImage = null; // Reset on error
                                });
                              }
                            }
                          },
                          onTapGallery: () async {
                            final XFile? image =
                            await ImagePickerHelper.pickImageFromGallery();
                            if (image != null) {
                              try {
                                setState(() {
                                  selectImage = image.path;
                                });
                                // Update image in Firebase
                                await productProvider.updateProductImage(
                                    widget.productId, File(image.path));
                                showSnackbar(
                                  message: "Image updated successfully",
                                  isError: false,
                                );
                              } catch (e) {
                                showSnackbar(
                                  message: "Failed to update image: $e",
                                  isError: true,
                                );
                                setState(() {
                                  selectImage = null; // Reset on error
                                });
                              }
                            }
                          },
                        );
                      },
                      child: Icon(
                        Icons.border_color_outlined,
                        color: colorScheme(context).primary,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.48),
                  decoration: BoxDecoration(
                    color: colorScheme(context).onPrimary,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 120),
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: colorScheme(context).secondaryContainer,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                product.productCategory,
                                style: textTheme(context).labelLarge!.copyWith(
                                  color: colorScheme(context)
                                      .secondary
                                      .withOpacity(0.4),
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor:
                            colorScheme(context).primary.withOpacity(0.1),
                            child: InkWell(
                              onTap: () {
                                // Navigate to ProductAddPage for editing
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductAddPage(
                                      productId: product.productId,
                                      isEditMode: true, // Indicate edit mode
                                      existingProduct: product, // Pass existing product
                                    ),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.border_color_outlined,
                                color: colorScheme(context).primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () async {
                              try {
                                await productProvider.removeProduct(widget.productId);
                                showSnackbar(
                                  message: "Product deleted successfully",
                                  isError: false,
                                );
                                context.pop(); // Close the detail page after deletion
                              } catch (e) {
                                showSnackbar(
                                  message: "Failed to delete product: $e",
                                  isError: true,
                                );
                              }
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.yellowGry.withOpacity(0.2),
                              child: Icon(
                                CupertinoIcons.delete,
                                color: AppColors.yellowTxt,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              product.productName,
                              style: textTheme(context).headlineLarge!.copyWith(
                                letterSpacing: 0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "Rs ${product.productPrice}",
                            style: textTheme(context).titleLarge!.copyWith(
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold,
                              color: colorScheme(context).primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(product.productDescr),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}