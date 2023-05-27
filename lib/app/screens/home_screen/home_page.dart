
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f6fb),
      body: Center(
        child: Text(
          'Hey Welcome 🖐',
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}
