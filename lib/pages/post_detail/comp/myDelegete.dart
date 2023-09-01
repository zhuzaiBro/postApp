import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    final mapSize = layoutChild(
      "map",
      BoxConstraints(
        maxHeight: Get.height / 2,
        minWidth: Get.width,
        minHeight: Get.height / 2,
        maxWidth: Get.width,
      ),
    );
    positionChild("map", const Offset(0, 0));

    final bizSize = layoutChild(
      "biz",
      BoxConstraints(
        maxHeight: Get.height / 2,
        minWidth: Get.width,
        minHeight: Get.height / 2,
        maxWidth: Get.width,
      ),
    );
    positionChild("biz", const Offset(0, 20));
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    // TODO: implement shouldRelayout
    return true;
  }
}
