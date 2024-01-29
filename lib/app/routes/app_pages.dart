import 'package:get/get.dart';

import '../modules/User/bindings/user_binding.dart';
import '../modules/User/views/user_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.USER;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.USER,
      page: () =>  UserView(),
      binding: UserBinding(),
    ),
  ];
}
