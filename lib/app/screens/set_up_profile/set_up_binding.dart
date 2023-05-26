
import 'package:get/get.dart';
import 'package:internship_task/app/screens/set_up_profile/set_up_profile_controller.dart';

class SetUpBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => SetUpProfileController());
  }

}