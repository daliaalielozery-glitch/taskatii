import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_list/core/app_constants.dart';
import 'package:to_do_list/features/add_task/widgets/custom_text_form_field.dart';
import 'package:to_do_list/features/auth/models/user_model.dart';
import 'package:to_do_list/features/auth/widget/custom_button.dart';
import 'package:to_do_list/features/home/home_screen.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final userBox = Hive.box<UserModel>(AppConstants.userBox);
    if (userBox.isNotEmpty) {
      final user = userBox.getAt(0);
      _nameController.text = user?.name ?? '';
      if (user?.image.isNotEmpty ?? false) {
        _image = XFile(user!.image);
      }
    }
  }

  void _pickImage(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() => _image = pickedImage);
    }
    Navigator.pop(context); // close bottom sheet after picking
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              btn_text: 'Upload from Camera',
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            SizedBox(height: 10.h),
            CustomButton(
              btn_text: 'Upload from Gallery',
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  void _showNameUpdate() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 16.0.w,
          right: 16.0.w,
          top: 16.0.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(
              controller: _nameController,
              hintText: 'Enter Your Name',
            ),
            SizedBox(height: 16.h),
            CustomButton(
              btn_text: 'Update Your Name',
              onPressed: () async {
                final userBox = Hive.box<UserModel>(AppConstants.userBox);
                if (userBox.isNotEmpty) {
                  final user = userBox.getAt(0);
                  userBox.putAt(
                    0,
                    UserModel(
                      image: user?.image ?? '',
                      name: _nameController.text,
                    ),
                  );
                } else {
                  await userBox.add(
                    UserModel(
                      image: _image?.path ?? '',
                      name: _nameController.text,
                    ),
                  );
                }
                Navigator.pop(context); // close bottom sheet
                setState(() {}); // refresh UI
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfile() async {
    final userBox = Hive.box<UserModel>(AppConstants.userBox);
    if (userBox.isNotEmpty) {
      final user = userBox.getAt(0);
      userBox.putAt(
        0,
        UserModel(
          image: _image?.path ?? user!.image,
          name: _nameController.text,
        ),
      );
    } else {
      await userBox.add(
        UserModel(image: _image?.path ?? '', name: _nameController.text),
      );
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _showImageOptions,
                child: CircleAvatar(
                  radius: 70.r,
                  backgroundColor: const Color(0xff2F2F2F),
                  child: _image == null
                      ? Icon(
                          Icons.person_rounded,
                          color: const Color(0xFF4F5CD1),
                          size: 120.r,
                        )
                      : ClipOval(
                          child: Image.file(
                            File(_image!.path),
                            fit: BoxFit.cover,
                            width: 140.r,
                            height: 140.r,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: _showNameUpdate,
                child: Text(
                  _nameController.text.isEmpty
                      ? 'Your Name'
                      : _nameController.text,
                  style: TextStyle(fontSize: 18.sp, color: Colors.black87),
                ),
              ),
              SizedBox(height: 32.h),
              CustomButton(btn_text: 'Done', onPressed: _saveProfile),
            ],
          ),
        ),
      ),
    );
  }
}
