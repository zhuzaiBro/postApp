import 'package:flutter/material.dart';

class NoShadowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return GlowingOverscrollIndicator(
          showLeading: false,
          //不显示尾部水波纹
          showTrailing: false,
          axisDirection: axisDirection, color: Colors.transparent,
          child: child,
        );
    }

  }
}