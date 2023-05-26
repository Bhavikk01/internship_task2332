
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../API/api_client.dart';
import '../../routes/route_path.dart';

class SetUpProfileController extends GetxController {


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  setUpUserProfile() async {
    Response res = await ApiClient.to.postData(
        'https://test-otp-api.7474224.xyz/profilesubmit.php',
        {
          "name" : nameController.text,
          "email" : emailController.text
        }
    );
    var jsonData = jsonDecode(res.body);
    log('This is the user setup response: $jsonData');
    if (jsonData['status'] == true) {
      Get.offAllNamed(RoutePaths.homeScreen);
    } else {
      Get.snackbar(
        '',
        '',
        titleText: Text(
          'User Setup',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.sp
          ),
        ),
        messageText: Text(
          "You don't have a valid auth token",
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
}