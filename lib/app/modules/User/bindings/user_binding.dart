import 'package:crud_operations/app/data/user/repository/user_repository.dart';
import 'package:crud_operations/di.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(
      () => UserController(userRepository:getIt<UserRepository>()),
    );
  }
}
