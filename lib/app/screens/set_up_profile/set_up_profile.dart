
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internship_task/app/screens/set_up_profile/set_up_profile_controller.dart';


class SetUpProfile extends GetView<SetUpProfileController> {
  SetUpProfile({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 110.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.asset(
                        "assets/titlepage.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Welcome!\nLooks like you are new here. Tell us a bit about yourself',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: const AssetImage(
                          'assets/avatar.png',
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.add_circle,
                            color: Colors.white,
                            size: 23.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      TextFormField(
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                        keyboardType: TextInputType.number,
                        controller: controller.nameController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: "User Name",
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0,
                          ),
                          filled: true,
                          fillColor: Colors.white24,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                        keyboardType: TextInputType.number,
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0,
                          ),
                          filled: true,
                          fillColor: Colors.white24,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.w),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if(GetUtils.isEmail(controller.emailController.text)){
                                await controller.setUpUserProfile();
                              }else{
                                Get.snackbar(
                                  '',
                                  '',
                                  titleText: Text(
                                    'Email Verification',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp
                                    ),
                                  ),
                                  messageText: Text(
                                    'Please enter a valid email Id',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp
                                    ),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 10.w,
                                  ),
                                  backgroundColor: Colors.grey[300],
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15.w),
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
