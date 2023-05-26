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
        gradient: LinearGradient(
          colors: [Theme.of(context).colorScheme.secondary, Theme.of(context).colorScheme.secondary.withOpacity(0.4)],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
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