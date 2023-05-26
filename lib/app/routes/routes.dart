
import 'package:get/get.dart';
import 'package:internship_task/app/routes/route_path.dart';

import '../screens/auth_screen/getx_helper/auth_binding.dart';
import '../screens/auth_screen/otp_verification_screen.dart';
import '../screens/auth_screen/sign_in_page.dart';
import '../screens/splash_screen.dart';


class RouteClass {
  static String getSlashScreen() => RoutePaths.splashScreen;


  static String getMobileScreen() => RoutePaths.mobileVerifyScreen;


  static List<GetPage> routes = [

    GetPage(
      name: RoutePaths.splashScreen,
      page: () => const SplashScreen(),
    ),

    GetPage(
      name: RoutePaths.mobileVerifyScreen,
      page: () => SignInPage(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: RoutePaths.otpVerificationScreen,
      page: () => const OtpVerificationScreen(),
    ),

  ];
}
