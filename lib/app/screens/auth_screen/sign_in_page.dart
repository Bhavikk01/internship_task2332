import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'getx_helper/auth_controller.dart';

class SignInPage extends GetView<AuthController> {
  SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Sign In',
              style: TextStyle(color: Colors.white60, fontSize: 15.sp),
            ),
            SizedBox(
              height: 13.h,
            ),
            Text(
              'Enter your phone number',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            TextField(
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                letterSpacing: 2,
              ),
              keyboardType: TextInputType.number,
              controller: controller.phoneNumber,
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelText: "Phone Number",
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
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.w),
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.validate()) {
                    await controller.handleSignInByPhone();
                  } else {
                    Get.snackbar(
                      '',
                      '',
                      titleText: Text(
                        'Phone Number',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp
                        ),
                      ),
                      messageText: Text(
                        'Please enter a valid phone number',
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
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.w),
                  child: Text(
                    "Get OTP",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "Didn't get the otp? Click here",
                style: TextStyle(color: Colors.white60, fontSize: 15.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
