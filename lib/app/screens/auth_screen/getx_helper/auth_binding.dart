
import 'package:get/get.dart';
import 'package:internship_task/app/screens/auth_screen/getx_helper/auth_controller.dart';

class AuthBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }

}