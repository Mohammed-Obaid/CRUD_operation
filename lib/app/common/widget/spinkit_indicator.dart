import 'package:crud_operations/app/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum SpinKitType { wave, circle }

class SpinKitIndicator extends StatelessWidget {
  const SpinKitIndicator({
    super.key,
    this.type = SpinKitType.wave,
  });

  final SpinKitType type;

  @override
  Widget build(BuildContext context) {
    Widget widget;
    switch (type) {
      case SpinKitType.wave:
        widget = const SpinKitWave(
          color: AppColor.mainThemeColor,
          size: 50.0,
        );
        break;
      case SpinKitType.circle:
        widget = const SpinKitFadingCircle(
          color: AppColor.mainThemeColor,
          size: 50.0,
        );
    }
    return Center(child: widget);
  }
}
