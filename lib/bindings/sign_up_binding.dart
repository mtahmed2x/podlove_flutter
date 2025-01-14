import 'package:get/get.dart';
import 'package:podlove_flutter/controllers/auth/sign_up_controller.dart';
import 'package:podlove_flutter/data/repositories/sign_up_repository.dart';

import '../data/services/api_service.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService('http://192.168.100.5:7000'));
    Get.lazyPut<SignUpRepository>(
        () => SignUpRepository(Get.find<ApiService>()));
    Get.lazyPut<SignUpController>(() => SignUpController(Get.find<SignUpRepository>()));
  }
}
