import 'package:crud_operations/app/common/controller/base_controller.dart';
import 'package:crud_operations/app/data/user/model/user.dart';
import 'package:crud_operations/app/data/user/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class UserController extends GetxController with StateMixin<List<User>> ,BaseController {
  final UserRepository userRepository;

  UserController({required this.userRepository});


 @override
  void onInit() {
    getUserList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

 Future<void> getUserList({
    Gender gender = Gender.all,
    UserStatus status = UserStatus.all,
  }) async {
    change(null, status: RxStatus.loading());
    Either<String, List<User>> failureOrSuccess =
        await userRepository.getUsers(gender: gender, status: status);

    failureOrSuccess.fold(
      (String failure) {
        change(null, status: RxStatus.error(failure));
      },
      (List<User> users) {
        if (users.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          change(users, status: RxStatus.success());
        }
      },
    );
  }

   void createUser(User user) {
    createItem(userRepository.createUser(user));
  }

  void updateUser(User user) {
    updateItem(userRepository.updateUser(user));
  }

  void deleteUser(User user) {
    deleteItem(userRepository.deleteUser(user));
  }

 


}
