import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/common/constants/app_colors.dart';
import 'package:restaurant_app/src/common/constants/app_images.dart';
import 'package:restaurant_app/src/common/constants/global_variables.dart';
import 'package:restaurant_app/src/common/utils/image_picker_helper.dart';
import 'package:restaurant_app/src/features/food_list/pages/product_add_page.dart';
import 'package:restaurant_app/src/features/product/provider/product_provider.dart';

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
    final foodListProvider = Provider.of<ProductProvider>(context, listen: false);
    // final product = foodListProvider.getProductById(widget.productId);
    final product = foodListProvider.getProductById(widget.productId);

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
                ),
                Positioned(
                  top: 60,
                  left: 20,
                  child: InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                ),

                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .42,
                    width: double.infinity,
                    child: selectImage == null
                        ? (product.productImage.startsWith('http') // Agar network URL hai
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
                        : Image.file(
                      File(product.productImage), // Agar local file hai (camera/gallery)
                      fit: BoxFit.cover,
                    ))
                        : Image.file(
                      File(selectImage!), // Camera/gallery se select ki hui image
                      fit: BoxFit.cover,
                    ),
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
                            final XFile? image = await ImagePickerHelper.pickImageFromCamera();
                            if (image != null) {
                              setState(() {
                                selectImage = image.path;
                              });
                              foodListProvider.updateProductImage(widget.productId, image.path);
                            }
                          },
                          onTapGallery: () async {
                            final XFile? image = await ImagePickerHelper.pickImageFromGallery();
                            if (image != null) {
                              setState(() {
                                selectImage = image.path;
                              });
                              foodListProvider.updateProductImage(widget.productId, image.path);
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
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .48),
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
                          color: Colors.black, // Divider ka rang
                          borderRadius: BorderRadius.circular(
                              100),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                color:
                                colorScheme(context).secondaryContainer,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                product.productCategory,
                                style: textTheme(context)
                                    .labelLarge!
                                    .copyWith(
                                    color: colorScheme(context)
                                        .secondary
                                        .withOpacity(0.4),
                                    letterSpacing: 0),
                              ),
                            ),
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor:
                            colorScheme(context).primary.withOpacity(0.1),
                            child: InkWell(
                              onTap: () async {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductAddPage(
                                  productId: product.productId,

                                ),));
                                // final updatedData = await Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ProductAddPage(
                                //       // productId: widget.productId,
                                //     ),
                                //   ),
                                // );

                                // if (updatedData != null) {
                                //   setState(() {});
                                // }
                              },
                              child: Icon(
                                Icons.border_color_outlined,
                                color: colorScheme(context).primary,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              foodListProvider.removeProduct(widget.productId); // Pass the correct productId
                              Navigator.pop(context); // Optionally close the detail page after deletion
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
                      const SizedBox(height: 15,),
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
                                color: colorScheme(context).primary
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
