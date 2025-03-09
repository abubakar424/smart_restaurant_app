import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_restaurant_app/src/features/food_list/pages/provider/food_list_provider.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../product/provider/product_provider.dart';
class ProductAddPage extends StatefulWidget {
  final int productId;
  const ProductAddPage({super.key, required this.productId});

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController categoryController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    final product = Provider.of<ProductProvider>(context, listen: false)
        .getProductById(widget.productId);

    nameController = TextEditingController(text: product.productName);
    categoryController = TextEditingController(text: product.productCategory);
    priceController = TextEditingController(text: product.productPrice);
    descriptionController = TextEditingController(text: product.productDescr);
  }

  @override
  Widget build(BuildContext context) {
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
                left: 20,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back),
                ),
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product Name',style: textTheme(context).labelLarge!.copyWith(letterSpacing: 0),),
                    const SizedBox(height: 5,),
                    CustomTextFormField(
                      controller: nameController,
                      hint: 'Product Name',
                    ),
                    const SizedBox(height: 20),
                    Text('Category',style: textTheme(context).labelLarge!.copyWith(letterSpacing: 0)),
                    const SizedBox(height: 5,),
                    CustomTextFormField(
                      controller: categoryController,
                      hint: 'Category',
                    ),
                    const SizedBox(height: 20),
                    Text('Price',style: textTheme(context).labelLarge!.copyWith(letterSpacing: 0)),
                    const SizedBox(height: 5,),
                    CustomTextFormField(
                      controller: priceController,
                      hint: 'Price',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    Text('Ingredients',style: textTheme(context).labelLarge!.copyWith(letterSpacing: 0)),
                    const SizedBox(height: 5,),
                    const CustomTextFormField(
                      hint: 'Chicken, Tomato... |',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    Text('Description',style: textTheme(context).labelLarge!.copyWith(letterSpacing: 0)),
                    const SizedBox(height: 5,),
                    CustomTextFormField(
                      controller: descriptionController,
                      maxline: 5,
                      hint: 'Description',
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: CustomButton(
                        height: 49,
                        text: 'Save Changes',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Provider.of<FoodListProvider>(context, listen: false)
                                .updateProduct(
                              widget.productId,
                              nameController.text,
                              categoryController.text,
                              priceController.text,
                              descriptionController.text,
                            );
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
