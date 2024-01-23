import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/src/data/services/firebase_storage.dart';
import 'package:food_ninja/src/presentation/widgets/buttons/back_button.dart';
import 'package:food_ninja/src/presentation/widgets/buttons/primary_button.dart';
import 'package:food_ninja/src/presentation/widgets/loading_indicator.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  final FirebaseStorageService _firebaseStorageService = FirebaseStorageService(
    FirebaseStorage.instance,
  );
  XFile? _image;
  String? imageUrl;

  // pick image from gallery
  Future<void> _pickImageFromGallery() async {
    _image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );

    setState(() {});
  }

  // pick image from camera
  Future<void> _pickImageFromCamera() async {
    _image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
    );

    setState(() {});
  }

  @override
  void initState() {
    // get data from hive
    var box = Hive.box('myBox');
    imageUrl = box.get('image', defaultValue: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              "assets/svg/pattern-small.svg",
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: PrimaryButton(
                text: "Next",
                onTap: () async {
                  var box = Hive.box('myBox');

                  // show loading
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const LoadingIndicator(),
                  );

                  // upload image to firebase storage
                  if (_image != null) {
                    imageUrl = await _firebaseStorageService.uploadImage(
                      "users/${box.get('email')}",
                      File(_image!.path),
                    );
                  }

                  // save image url to hive
                  box.put('image', imageUrl);

                  // hide loading
                  // navigate to next page
                  if (mounted) {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/register/set-location');
                  }
                },
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top + 40,
                  ),
                  const CustomBackButton(),
                  const SizedBox(height: 20),
                  Text(
                    "Upload Your Profile \nPhoto",
                    style: CustomTextStyle.size25Weight600Text(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "This data will be displayed in your account \nprofile for security",
                    style: CustomTextStyle.size14Weight400Text(),
                  ),
                  const SizedBox(height: 20),
                  // if image is available show image else show placeholder
                  _image != null
                      ? Center(
                          child: Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [AppStyles.boxShadow7],
                              borderRadius: AppStyles.largeBorderRadius,
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: AppStyles.largeBorderRadius,
                                  child: Image.file(
                                    File(_image!.path),
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _image = null;
                                      });
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.5),
                                        borderRadius:
                                            AppStyles.largeBorderRadius,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : imageUrl != ""
                          ? Center(
                              child: Container(
                                width: 250,
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [AppStyles.boxShadow7],
                                  borderRadius: AppStyles.largeBorderRadius,
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: AppStyles.largeBorderRadius,
                                      child: Image.network(
                                        imageUrl!,
                                        width: 250,
                                        height: 250,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Center(
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            imageUrl = "";
                                          });
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            borderRadius:
                                                AppStyles.largeBorderRadius,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                Ink(
                                  decoration: BoxDecoration(
                                    color: AppColors().cardColor,
                                    boxShadow: [AppStyles.boxShadow7],
                                    borderRadius: AppStyles.largeBorderRadius,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      _pickImageFromGallery();
                                    },
                                    borderRadius: AppStyles.largeBorderRadius,
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 130,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/gallery.svg",
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "From Gallery",
                                            style: CustomTextStyle
                                                .size14Weight400Text(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // from camera
                                Ink(
                                  decoration: BoxDecoration(
                                    color: AppColors().cardColor,
                                    boxShadow: [AppStyles.boxShadow7],
                                    borderRadius: AppStyles.largeBorderRadius,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      _pickImageFromCamera();
                                    },
                                    borderRadius: AppStyles.largeBorderRadius,
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 130,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/camera.svg",
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "From Camera",
                                            style: CustomTextStyle
                                                .size14Weight400Text(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),
                              ],
                            ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
