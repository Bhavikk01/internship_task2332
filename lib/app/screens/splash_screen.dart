import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_task/app/routes/route_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState(){

    Timer(const Duration(milliseconds: 4500), (){
      setState(() {
        Get.offAllNamed(RoutePaths.mobileVerifyScreen);
      });
    });

    Timer(
        const Duration(milliseconds: 200),(){
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: const Duration(milliseconds: 2500),
        child: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.transparent,
          child: Image.asset(
            'assets/logo.png',
            height: 150,
            width: 150,
          ),
        ),
      ),
    );
  }
}