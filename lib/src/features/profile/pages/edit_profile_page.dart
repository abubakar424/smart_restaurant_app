import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/utils/image_picker_helper.dart';
import '../../../common/utils/validations.dart';
import '../../../common/widgets/custom_back_button.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../model/profile/user_profile_model.dart';


class EditProfilePage extends StatefulWidget {
  final UserProfile userProfile;

  const EditProfilePage({super.key, required this.userProfile});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  static final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  String? updatedImageUrl;

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
                              "Personal Profile",
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
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 120, // Adjust this size as needed
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.blue, // Blue border
                            width: 3.0,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: updatedImageUrl != null
                              ? FileImage(File(
                                  updatedImageUrl!)) // Display newly selected image if exists
                              : NetworkImage(widget.userProfile.imageUrl)
                                  as ImageProvider, // Original network image
                          backgroundColor: Colors.transparent,

                          // backgroundImage:
                          //     NetworkImage(widget.userProfile.imageUrl),
                          // backgroundColor: Colors.transparent,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            ImagePickerHelper.showImageSourceSelection(
                              context,
                              onTapCamera: () async {
                                final XFile? pickedImage =
                                    await ImagePickerHelper
                                        .pickImageFromCamera();
                                if (pickedImage != null) {
                                  setState(() {
                                    updatedImageUrl = pickedImage.path;
                                  });
                                }
                              },
                              onTapGallery: () async {
                                final XFile? pickedImage =
                                    await ImagePickerHelper
                                        .pickImageFromGallery();
                                if (pickedImage != null) {
                                  setState(() {
                                    updatedImageUrl = pickedImage.path;
                                  });
                                }
                              },
                            );
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: AppColors
                                  .blue, // Blue background for the edit icon
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit, // Edit icon
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Full Name',
                          style: TextStyle(
                              fontSize: 14,
                              color: colorScheme(context).onSurface,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        CustomTextFormField(
                          controller: fullNameController,
                          hint: 'James Smith',
                          validator: (value) =>
                              Validation.fieldValidation(value, "full name"),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Email address',
                          style: TextStyle(
                              fontSize: 14,
                              color: colorScheme(context).onSurface,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        CustomTextFormField(
                          controller: emailController,
                          validator: Validation.emailValidation,
                          hint: 'hello@halallab.co',
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Phone Number',
                          style: TextStyle(
                              fontSize: 14,
                              color: colorScheme(context).onSurface,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        CustomTextFormField(
                          controller: phoneController,
                          hint: '+92xxxxxxxxxx',
                          validator: Validation.phoneNumberValidation,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Bio (Optional)',
                          style: TextStyle(
                              fontSize: 14,
                              color: colorScheme(context).onSurface,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        CustomTextFormField(
                          controller: bioController,
                          hint: 'eg: I love food',
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  CustomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // Creating an updated UserProfile
                        final updatedProfile = UserProfile(
                            imageUrl: widget.userProfile.imageUrl,
                            name: fullNameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            bio: bioController.text.isNotEmpty
                                ? bioController.text
                                : widget.userProfile.bio,
                            id: widget.userProfile.id
                            // bio: bioController.text,
                            // id: '',
                            );

                        // Passing updated profile data back
                        Navigator.of(context).pop(updatedProfile);
                      }
                    },
                    text: 'Save Changes',
                  )
                ],
              ),
            ),
          ])),
    );
  }
}
