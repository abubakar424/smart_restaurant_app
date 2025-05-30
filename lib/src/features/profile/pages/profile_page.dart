import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/utils/custom_dialog.dart';
import '../../../model/profile/user_profile_model.dart';
import '../../../router/routes.dart';
import '../widgets/custom_tab.dart';


class ProfilePage extends StatefulWidget {
  final UserProfile userProfile;
  ProfilePage({super.key, required this.userProfile});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _profileImageUrl;
  String? name;
  String? email;
  bool _isLoading = true;

  File? _image;
  ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  Future<void> _fetchProfileImage() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final doc = await _firestore.collection('userDetail').doc(user.uid).get();
        if (doc.exists && doc.data() != null) {
          setState(() {
            _profileImageUrl = doc.data()!['profileImage'] as String?;
          });
        }
      }
    } catch (e) {
      print('Error fetching profile image: $e');
    }
  }

  void _fetchUserDetails() async {
    try {
      setState(() { _isLoading = true; });

      final user = _auth.currentUser;
      if(user != null) {
        final doc = await _firestore.collection('userDetail').doc(user.uid).get();

        if(doc.exists) {
          setState(() {
            name = doc['name'] ?? 'No Name';
            email = doc['email'] ?? 'No Email';
            _profileImageUrl = doc['profileImage'];
            _isLoading = false;
          });
        }
      }
    } catch(e) {
      setState(() { _isLoading = false; });
      print('Error: $e');
    }
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _fetchUserDetails();
      _fetchProfileImage();
    });
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Future<void> _uploadImage(File imageFile) async{
      try{
        final user = _auth.currentUser;
        if(user == null) return ;
        setState(() {
          _isUploading = true;
        });
        showDialog(context: context, builder: (context){
          return Center(
            child: CircularProgressIndicator(),
          );
        });

        final Reference ref = _storage.ref().child("user_image/${user.uid}");
        await ref.putFile(imageFile);

        final String downloadUrl = await ref.getDownloadURL();
        await _firestore.collection("userDetail").doc(user.uid).set({
          'profileImage': downloadUrl,
          'lastUpdated': FieldValue.serverTimestamp(),
        },SetOptions(merge: true));

        if(mounted){
          setState(() {
            _profileImageUrl = downloadUrl;
            _isUploading = false;
          });
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile picture updated successfully!")));
        }
      }catch(e){
        if(mounted){
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error uploading image: ${e.toString()}")));
        }
        setState(() {
          _isUploading = false;
        });
      }
    }

    Future<void> _pickedImage(ImageSource source) async{
      final pickedFile = await _picker.pickImage(source: source);

      if(pickedFile != null){
        setState(() {
          _image = File(pickedFile.path);
        });
      }
      await _uploadImage(_image!);
    }

    void _showPickOptionDialog(BuildContext context){
      showDialog(
          context: context,
          builder: (context){
        return AlertDialog(
          title: Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: (){
                  Navigator.of(context).pop();
                  _pickedImage(ImageSource.gallery);
                },
              ),
              ListTile(
                title: Text('Camera'),
                leading: Icon(Icons.camera_alt),
                onTap: (){
                  Navigator.of(context).pop();
                  _pickedImage(ImageSource.camera);
                },
              )
            ],
          ),
        );
      });
    }


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
                            // CustomBackButton(),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Text(
                              "Profile",
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
            Container(
              height: 228,
              width: width,
              decoration: BoxDecoration(
                  color: AppColors.orangeBg,
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width:
                        88, // Diameter of the CircleAvatar + Border width (2 * 4)
                    height: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.blue, // Border color
                        width: 2.0, // Border width
                      ),
                    ),
                    child: InkWell(
                      onTap: _isUploading ? null : (){
                        _showPickOptionDialog(context);
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: _image != null ? FileImage(_image!): _profileImageUrl != null && _profileImageUrl!.isNotEmpty ? CachedNetworkImageProvider(_profileImageUrl!) : AssetImage(AppImages.profile),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isLoading ? "isLoading...": (name ?? "No Name"),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700, color: AppColors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _isLoading ? "isLoading..." :  (email ?? "No Email"),
                    style: TextStyle(color: AppColors.white),

                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  UserReviewItem(
                avatarImageUrl:AppIcons.profileIcon, // Example image URL
                title: 'Personal Info',
                onTap: () {
                  context.pushNamed(
                    AppRoute.personalInfoPage,
                    extra: widget.userProfile,
                    );
                  // Define what happens when this item is tapped
                  print('Navigate to personal info');
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              UserReviewItem(
                avatarImageUrl:
                    AppIcons.settingIcon,

                     // Example image URL
                title: 'Settings',
                onTap: () {
                  context.pushNamed(AppRoute.settingPage);


                  // Define what happens when this item is tapped
                  print('Navigate settings');
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              UserReviewItem(
                avatarImageUrl:
                  AppIcons.faqIcon, // Example image URL
                title: 'User Reviews',
                onTap: () {
                    context.pushNamed(AppRoute.reviewsPage);
                  print('Navigate to User Reviews');
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              UserReviewItem(
                avatarImageUrl:
                  AppIcons.payment, // Example image URL
                title: 'Orders History',
                onTap: () {
                    context.pushNamed(AppRoute.orderHistoryPage);
                  print('Navigate to Oders History');
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              UserReviewItem(
                avatarImageUrl:
                   AppIcons.logoutIcon, // Example image URL
                title: 'Log Out',
                onTap: () {

                  // Show the first dialog
            CustomDialog.showLogoutDialog(
              context: context,
              onLogout: () {
                // After user confirms, show the second dialog
                CustomDialog.showConfirmationDialog(
                  context: context,
                  message: "You’ve successfully Logged Out.",
                  onConfirm: () {
                    print("User has logged out.");
                  },
                );
              },
            );




                  print('Navigate dialog');
                },
              ),

                ],
              ),
            ),

          ])),
    );
  }
}
