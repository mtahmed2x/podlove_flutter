import 'package:get/get.dart';
import 'package:podlove_flutter/controllers/auth/sign_up_controller.dart';
import 'package:podlove_flutter/services/api_service.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService().init(), fenix: true);
    Get.lazyPut(() => SignUpController());
  }
}
