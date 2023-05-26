import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internship_task/app/API/api_client.dart';
import 'package:internship_task/app/routes/route_path.dart';

class AuthController extends GetxController {
  Rx<int> seconds = 60.obs;
  Rx<bool> isLoading = false.obs;
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String requestId = '';

  handleSignInByPhone() async {
    Response res = await ApiClient.to.postData(
      'https://test-otp-api.7474224.xyz/sendotp.php',
      {'mobile': phoneNumber.text},
    );
    log('This is the phone verification response: ${res.body}');
    if (res.body['status'] == true) {
      requestId = res.body['request_id'];
      Get.toNamed(RoutePaths.otpVerificationScreen);
    } else {
      Fluttertoast.showToast(
        msg: "Unknown error occurred",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.grey[300],
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  validateOtp() async {
    if ((otpController.text).length == 6) {
      isLoading.value = true;
      try {
        Response res = await ApiClient.to.postData(
          'http://localhost/sample-api-login/verifyotp.php',
            {
              "request_id": requestId,
              "code": otpController.text
            },
        );
        isLoading.value = false;
        log('This is the otp verification response: ${res.body}');
        if (res.body['status'] == true) {
          return true;
        } else {
          return false;
        }
      } catch (error) {
        isLoading.value = false;
        Get.snackbar(
          "Auth Failed",
          'The input OTP is either invalid or expired',
          snackStyle: SnackStyle.FLOATING,
          icon: const Icon(
            Icons.person,
            color: Color(0xff28282B),
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey[200],
          borderRadius: 10.r,
          margin: EdgeInsets.all(10.w),
          padding: EdgeInsets.all(15.w),
          colorText: const Color(0xff28282B),
          duration: const Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      }
    } else {
      return false;
    }
  }

  bool validate() {
    return (int.tryParse(phoneNumber.text) != null) &&
        phoneNumber.text.length == 10;
  }

  void decrementSeconds() async {
    seconds.value = 60;
    while (seconds.value > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (isClosed) {
        return;
      } else {
        seconds.value--;
      }
    }
  }
}
