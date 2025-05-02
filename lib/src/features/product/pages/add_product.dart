import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/utils/custom_snackbar.dart';
import '../../../common/utils/image_picker_helper.dart';
import '../../../common/utils/validations.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../model/product_model.dart';
import '../provider/product_provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productCategory = TextEditingController();
  TextEditingController productDescr = TextEditingController();

  String? selectImage;
  String? selectCategory;
  List<String> category = ['Foods', 'Drinks'];

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme(context).onPrimary,
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    border: Border.all(
                        color: colorScheme(context).outlineVariant, width: 1),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text(
                            "Add Product",
                            style: textTheme(context)
                                .headlineMedium
                                ?.copyWith(fontSize: 24),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Upload Picture",
                            style: textTheme(context).titleSmall,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: GestureDetector(
                          onTap: () {
                            ImagePickerHelper.showImageSourceSelection(
                              context,
                              onTapCamera: () async {
                                final XFile? image =
                                await ImagePickerHelper.pickImageFromCamera();
                                if (image != null) {
                                  setState(() {
                                    selectImage = image.path;
                                  });
                                }
                              },
                              onTapGallery: () async {
                                final XFile? image =
                                await ImagePickerHelper.pickImageFromGallery();
                                if (image != null) {
                                  setState(() {
                                    selectImage = image.path;
                                  });
                                }
                              },
                            );
                          },
                          child: Center(
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.blackColor),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                                color: colorScheme(context).surface,
                              ),
                              child: selectImage == null
                                  ? Icon(
                                Icons.add_box_outlined,
                                color: colorScheme(context).outline,
                                size: 18,
                              )
                                  : Image.file(
                                File(selectImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Product Name",
                          style: textTheme(context).titleSmall,
                        ),
                      ),
                      CustomTextFormField(
                        enableBorder: false,
                        controller: productName,
                        hint: "Enter product name",
                        inputAction: TextInputAction.next,
                        fillColor: colorScheme(context).surface,
                        validator: (value) =>
                            Validation.fieldValidation(value, "product name"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Product Price",
                          style: textTheme(context).titleSmall,
                        ),
                      ),
                      CustomTextFormField(
                        enableBorder: false,
                        keyboardType: TextInputType.number,
                        controller: productPrice,
                        hint: "Product price",
                        inputAction: TextInputAction.next,
                        fillColor: colorScheme(context).surface,
                        validator: (value) =>
                            Validation.fieldValidation(value, "product price"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Product Category",
                          style: textTheme(context).titleSmall,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme(context).onPrimary,
                          borderRadius: BorderRadius.circular(8),
                          border:
                          Border(bottom: BorderSide(color: AppColors.blackColor)),
                        ),
                        width: double.infinity,
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: const InputDecoration(border: InputBorder.none),
                          hint: Text(
                            'Select category',
                            style: textTheme(context).labelLarge!.copyWith(
                                letterSpacing: 0,
                                fontSize: 13,
                                color: colorScheme(context).outline),
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectCategory = value;
                            });
                          },
                          items: category.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: textTheme(context).labelLarge!.copyWith(
                                  letterSpacing: 0,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            );
                          }).toList(),
                          validator: (newValue) {
                            if (newValue == null) {
                              return 'Please select a value';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Product Description",
                          style: textTheme(context).titleSmall,
                        ),
                      ),
                      CustomTextFormField(
                        enableBorder: false,
                        controller: productDescr,
                        hint:
                        "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                        fillColor: colorScheme(context).surface,
                        validator: (value) =>
                            Validation.fieldValidation(value, "description"),
                        maxline: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: CustomButton(
                            onTap: () async {
                              if (formKey.currentState!.validate() &&
                                  selectImage != null &&
                                  selectCategory != null) {
                                try {
                                  final int newProductId =
                                  productProvider.getNextProductId();
                                  final product = ProductModel(
                                    productId: newProductId,
                                    productName: productName.text,
                                    productPrice: productPrice.text,
                                    productDescr: productDescr.text,
                                    productImage: selectImage!,
                                    productCategory: selectCategory!,
                                  );

                                  // Add product to Firebase
                                  await productProvider.addProduct(
                                      product, File(selectImage!));

                                  // Show success message and go back
                                  showSnackbar(
                                    message: "Product added successfully",
                                    isError: false,
                                  );
                                  context.pop();
                                } catch (e) {
                                  showSnackbar(
                                    message: "Failed to add product: $e",
                                    isError: true,
                                  );
                                }
                              } else {
                                showSnackbar(
                                  message:
                                  "Please fill in all fields and upload an image",
                                  isError: true,
                                );
                              }
                            },
                            text: 'Upload',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}