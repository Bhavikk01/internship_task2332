import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../routes/route_path.dart';
import 'getx_helper/auth_controller.dart';

class OtpVerificationScreen extends GetView<AuthController> {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.decrementSeconds();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back,
                  size: 32.w,
                  color: Colors.black54,
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              width: 200.w,
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/illustration-3.png',
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Verification',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Enter your OTP code number",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 28.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 18.w, horizontal: 15.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8.r,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 25.w,
                      bottom: 15.w,
                    ),
                    child: Center(
                      child: PinCodeTextField(
                        autoDisposeControllers: false,
                        autoFocus: true,
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.none,
                        cursorColor: Colors.black,
                        enableActiveFill: true,
                        pinTheme: PinTheme(
                          fieldOuterPadding:
                              EdgeInsets.symmetric(horizontal: 4.w),
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          inactiveColor: Colors.purple,
                          disabledColor: Colors.purple,
                          activeColor: Colors.purple,
                          selectedColor: Colors.purple,
                          shape: PinCodeFieldShape.box,
                          selectedFillColor: Colors.white,
                          borderRadius: BorderRadius.circular(6.r),
                          borderWidth: 2.w,
                          fieldHeight: 40.h,
                          fieldWidth: 40.w,
                        ),
                        textStyle:
                            TextStyle(fontSize: 16.sp, color: Colors.black),
                        animationDuration: const Duration(milliseconds: 300),
                        onCompleted: (value) {},
                        onChanged: (value) {},
                        beforeTextPaste: (text) {
                          return true;
                        },
                        appContext: context,
                        controller: controller.otpController,
                      ),
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!controller.isLoading.value &&
                              await controller.validateOtp()) {
                            Get.offAllNamed(RoutePaths.setUpProfile);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                        ),
                        child: !controller.isLoading.value
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Text(
                                  "Verify",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              )
                            : Container(
                                height: 38.h,
                                width: 38.w,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.w, horizontal: 8.w),
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            Text(
              "Didn't you receive any code?",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 18.h,
            ),
            Text(
              "Resend New Code",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
