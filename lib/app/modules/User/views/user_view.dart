import 'package:crud_operations/app/common/controller/base_controller.dart';
import 'package:crud_operations/app/common/dialog/create_dialog.dart';
import 'package:crud_operations/app/common/dialog/delete_dialog.dart';
import 'package:crud_operations/app/common/dialog/progress_dialog.dart';
import 'package:crud_operations/app/common/dialog/retry_dialog.dart';
import 'package:crud_operations/app/common/widget/empty_widget.dart';
import 'package:crud_operations/app/common/widget/popup_menu.dart';
import 'package:crud_operations/app/common/widget/spinkit_indicator.dart';
import 'package:crud_operations/app/core/app_extension.dart';
import 'package:crud_operations/app/core/app_style.dart';
import 'package:crud_operations/app/data/user/model/user.dart';
import 'package:crud_operations/app/modules/User/views/widgets/status_container.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_controller.dart';
enum UserOperation { edit, delete, post, todo }
class UserView extends GetView<UserController> {

  PreferredSizeWidget get _appBar {
    return AppBar(
      leading: IconButton(
        onPressed: controller.getUserList,
        icon: const Icon(Icons.refresh,color: Colors.white),
      ),
      // actions: [
      //   PopupMenu<UserStatus>(
      //     icon: Icons.filter_list_outlined,
      //     items: UserStatus.values,
      //     onChanged: (UserStatus value) {
      //       controller.getUserList(status: value);
      //     },
      //   ),
      //   PopupMenu<Gender>(
      //     icon: Icons.filter_alt_outlined,
      //     items: Gender.values,
      //     onChanged: (Gender value) => controller.getUserList(gender: value),
      //   )
      // ],
      title: const Text("Users",style: TextStyle(color: Colors.white)),
    );
  }

  Widget get floatingActionButton {
    return FloatingActionButton(
      onPressed: () async {
        late User user;
        bool isCreate = await createDialog(
          context:  Get.context!,
          userData: (User userValue) => user = userValue,
        );

        if (isCreate) {
          controller.createUser(user);
          // if (!mounted) return;
          showDialog(
            context:  Get.context!,
            builder: (_) {
              return Obx(
                () {
                  switch (controller.apiStatus.value) {
                    case ApiState.loading:
                      return const ProgressDialog(
                        title: "Creating user...",
                        isProgressed: true,
                      );
                    case ApiState.success:
                      return ProgressDialog(
                        title: "Successfully created",
                        onPressed: () {
                          controller.getUserList();
                          Navigator.pop( Get.context!);
                        },
                        isProgressed: false,
                      );
                    case ApiState.failure:
                      return RetryDialog(
                        title: controller.errorMessage.value,
                        onRetryPressed: () => controller.createUser(user),
                      );
                  }
                },
              );
            },
          );
        }
      },
      child: const Icon(Icons.add,color: Colors.white),
    );
  }

  Widget userListItem(User user) {
    return Card(
      child: Row(
        children: [
          Image.asset(user.gender.name.getGenderWidget, height: 75),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: headLine4),
                const SizedBox(height: 10),
                Text(user.email, style: headLine6)
              ],
            ),
          ),
          const SizedBox(width: 15),
          StatusContainer(status: user.status),
          PopupMenu<UserOperation>(
            items: UserOperation.values,
            onChanged: (UserOperation value) async {
              switch (value) {
                case UserOperation.post:
                  // navigateTo(PostListScreen(user: user));
                  break;
                case UserOperation.todo:
                  // navigateTo(ToDoListScreen(user: user));
                  break;
                case UserOperation.delete:
                  deleteUser(user);
                  break;
                case UserOperation.edit:
                  editUser(user);
              }
            },
          ),
        ],
      ),
    );
  }

  void deleteUser(User user) async {
    bool isAccepted = await deleteDialog( Get.context!);
    if (isAccepted) {
      controller.deleteUser(user);
      // if (!mounted) return;
      showDialog(
        context:  Get.context!,
        builder: (_) {
          return Obx(
            () {
              switch (controller.apiStatus.value) {
                case ApiState.loading:
                  return const ProgressDialog(
                    title: "Deleting user...",
                    isProgressed: true,
                  );
                case ApiState.success:
                  return ProgressDialog(
                    title: "Successfully deleted",
                    onPressed: () {
                      controller.getUserList();
                      Navigator.pop( Get.context!);
                    },
                    isProgressed: false,
                  );
                case ApiState.failure:
                  return RetryDialog(
                    title: controller.errorMessage.value,
                    onRetryPressed: () => controller.deleteUser(user),
                  );
              }
            },
          );
        },
      );
    }
  }

  void editUser(User user) async {
    late User userObj;
    bool isUpdate = await createDialog(
      user: user,
      type: Type.update,
      context:  Get.context!,
      userData: (User userValue) {
        userObj = userValue;
      },
    );

    if (isUpdate) {
      controller.updateUser(userObj);
      // if (!mounted) return;
      showDialog(
        context:  Get.context!,
        builder: (_) {
          return Obx(
            () {
              switch (controller.apiStatus.value) {
                case ApiState.loading:
                  return const ProgressDialog(
                    title: "Updating user...",
                    isProgressed: true,
                  );
                case ApiState.success:
                  return ProgressDialog(
                    title: "Successfully updated",
                    onPressed: () {
                      controller.getUserList();
                      Navigator.pop( Get.context!);
                    },
                    isProgressed: false,
                  );
                case ApiState.failure:
                  return RetryDialog(
                    title: controller.errorMessage.value,
                    onRetryPressed: () => controller.updateUser(userObj),
                  );
              }
            },
          );
        },
      );
    }
  }

  void navigateTo(Widget screen) {
    // if (!mounted) return;
    Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: _appBar,
      body: controller.obx(
        (state) => ListView.builder(
          shrinkWrap: true,
          itemCount: state?.length,
          itemBuilder: (_, index) {
            User user = state![index];
            return userListItem(user).marginSymmetric(horizontal: 10);
          },
        ),
        onLoading: const SpinKitIndicator(type: SpinKitType.circle),
        onError: (error) => RetryDialog(
          title: "$error",
          onRetryPressed: () => controller.getUserList(),
        ),
        onEmpty: const EmptyWidget(message: "No user!"),
      ),
    );
  }

}
