import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'getx_helper/auth_controller.dart';

class SignInPage extends GetView<AuthController> {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 22.w),
          child: Column(
            children: [
              SizedBox(
                height: 18.h,
              ),
              Container(
                width: 200.w,
                height: 200.h,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/illustration-2.png',
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "we need to verify your number before getting started",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8.r,
                        offset: const Offset(4, 4),
                      ),
                    ]),
                child: Column(
                  children: [
                    Obx(
                    () => TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.phoneNumber,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          prefix: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(
                              '+91',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          suffixIcon: controller.isValid.value
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 32.w,
                                )
                              : null,
                        ),
                        onChanged: (number) {
                          controller.validate();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (controller.isValid.value) {
                            await controller.handleSignInByPhone();
                          } else {
                            Get.snackbar(
                              '',
                              '',
                              titleText: Text(
                                'Phone Number',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                ),
                              ),
                              messageText: Text(
                                'Please enter a valid phone number',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
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
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Send OTP',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
