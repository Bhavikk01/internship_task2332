import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_task/app/screens/home_screen/home_page.dart';
import 'package:internship_task/app/screens/splash_screen.dart';
import 'package:internship_task/app/services/storage.dart';
import 'package:internship_task/app/services/user.dart';

import 'app/screens/home_screen/getx_helper/controller.dart';
import 'app/services/firebase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCbqR5BJdZUVKFY4DoPUc61z20rBdnb5Yk",
      appId: "1:746912992424:ios:d1f78a8ea3d92d3593869d",
      messagingSenderId: "746912992424",
      projectId: "internship-task-2332",
    ),
  );
  Get.put<FirebaseFireStore>(FirebaseFireStore());
  Get.put<MapController>(MapController());
  await Get.putAsync<StorageService>(() => StorageService().init());
  Get.put<UserStore>(UserStore());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff041c50),
        scaffoldBackgroundColor: Colors.grey.shade100,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey,).copyWith(secondary: const Color(0xff041c50)),
      ),
      home: const SplashScreen(),
    );
  }
}