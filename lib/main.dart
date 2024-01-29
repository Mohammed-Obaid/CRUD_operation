import 'package:crud_operations/app/core/app_asset.dart';
import 'package:crud_operations/app/core/app_theme.dart';
import 'package:crud_operations/di.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
    await init();
  runApp(
    GetMaterialApp(
      title: "CRUD demo",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightAppTheme,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
