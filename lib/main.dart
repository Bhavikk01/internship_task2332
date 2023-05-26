import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internship_task/app/routes/route_path.dart';
import 'package:internship_task/app/services/storage.dart';
import 'package:internship_task/app/services/user.dart';

import 'app/API/api_client.dart';
import 'app/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<ApiClient>(ApiClient());
  await Get.putAsync<StorageService>(() => StorageService().init());
  Get.put<UserStore>(UserStore());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) =>  GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xff041c50),
          scaffoldBackgroundColor: Colors.grey.shade100,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.grey,).copyWith(secondary: const Color(0xff041c50),
            primary: const Color(0xe2272728),
          ),
        ),
        initialRoute: RoutePaths.splashScreen,
        getPages: RouteClass.routes,
      ),
    );
  }
}