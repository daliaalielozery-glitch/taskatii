import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_list/core/app_constants.dart';
import 'package:to_do_list/features/auth/models/user_model.dart';
import 'package:to_do_list/features/auth/widget/custom_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthState();
}

class _AuthState extends State<AuthScreen> {
  final user = Hive.box<UserModel>(AppConstants.userBox).getAt(0);
  final ImagePicker picker = ImagePicker();
  //variable to store the image on it frome camera or gallery
  XFile? image;
  TextEditingController nameController = TextEditingController();
  void openCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  void openGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            spacing: 5.h,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //visibility used to show two widgets  (icon or image)
              Visibility(
                visible: image == null,
                child: CircleAvatar(
                  radius: 70.r,
                  backgroundColor: Color(0xff2F2F2F),
                  child: Icon(
                    Icons.person_rounded,
                    color: Color(0xFF4F5CD1),
                    size: 120.r,
                  ),
                ),
                replacement: CircleAvatar(
                  radius: 70.r,
                  backgroundColor: Color(0xff2F2F2F),
                  child: Image.file(File(image?.path ?? "")),
                ),
              ),
              CustomButton(
                btn_text: "Upload Frome camera",
                //async  after the fuction
                // and await put before the action to wait and do the task to stop all the app until taking a photo
                onPressed: () {
                  openCamera();
                },
              ),
              CustomButton(
                btn_text: "Upload Frome gallery",
                onPressed: () {
                  openGallery();
                },
              ),
              Divider(thickness: 1.h),
              TextFormField(
                controller: nameController,
                onTapUpOutside: (v) {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                  hint: Text("Enter Your Name "),
                ),
              ),
              CustomButton(
                btn_text: "Done",
                onPressed: () {
                  Hive.box<UserModel>(AppConstants.userBox)
                      .add(
                        UserModel(
                          image: image?.path ?? "",
                          name: nameController.text,
                        ),
                      )
                      .then((s) {
                        print("Success$s");
                      })
                      .catchError((e) {
                        print("Error$e");
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
