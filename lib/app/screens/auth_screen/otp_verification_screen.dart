import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../routes/route_path.dart';
import '../../services/user.dart';
import 'getx_helper/auth_controller.dart';

class OtpVerificationScreen extends GetView<AuthController> {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.decrementSeconds();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40.h,
            ),
            Text(
              'Hey 👋',
              style: TextStyle(color: Colors.white60, fontSize: 15.sp),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              'Enter Your OTP Here',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(top: 25.w, bottom: 15.w, left: 5.w, right: 5.w),
              child: Center(
                child: PinCodeTextField(
                  autoDisposeControllers: false,
                  autoFocus: true,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.none,
                  cursorColor: Colors.white,
                  enableActiveFill: true,
                  pinTheme: PinTheme(
                    fieldOuterPadding: EdgeInsets.symmetric(horizontal: 2.w),
                    inactiveColor: Colors.transparent,
                    selectedColor: Colors.transparent,
                    // borderWidth: 0,
                    selectedFillColor: Theme.of(context).colorScheme.primary,
                    activeColor: Theme.of(context).colorScheme.primary,
                    activeFillColor: Theme.of(context).colorScheme.primary,
                    inactiveFillColor: Theme.of(context).colorScheme.primary,
                    errorBorderColor: null,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.zero,
                    fieldHeight: 50,
                    fieldWidth: 40,
                  ),
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white
                  ),
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
              () => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: ElevatedButton(
                  onPressed: () async {
                    if (!controller.isLoading.value &&
                        await controller.validateOtp()) {
                      Get.offAllNamed(RoutePaths.setUpProfile);
                    }
                  },
                  child: !controller.isLoading.value
                      ? Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                            "Verify",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp
                            ),
                          ),
                      )
                      : Container(
                          height: 38.h,
                          width: 38.w,
                          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 8.w),
                          child: const CircularProgressIndicator(color: Colors.white),
                        ),
                ),
              ),
            ),

            // Content Line :Resend code
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  controller.decrementSeconds();
                },
                child: Text(
                  'Click to Resend Code',
                  style: TextStyle(color: Colors.white60, fontSize: 15.sp),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Obx(
              () => Center(
                child: Text(
                  '${'Resend after'} ${controller.seconds.value} seconds',
                  style: TextStyle(color: Colors.white60, fontSize: 15.sp),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Didn't Receive the code yet?Click on resend in 0:20 sec",
                style: TextStyle(color: Colors.white60, fontSize: 12.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
