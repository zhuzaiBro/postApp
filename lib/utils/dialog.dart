import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void defaultDialog(void Function() callback, String title, String info) {
  Get.defaultDialog(
    title: title,
    confirmTextColor: const Color(0xffffffff),
    content: Container(
      alignment: Alignment.center,
      child: Text(info),
    ),
    cancel: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text(
          "取消",
          style: TextStyle(fontSize: 16.sp),
        )),
    confirm: ElevatedButton(
      onPressed:
      // 接单后的操作
      callback,
      child: Text(
        "确定",
        style: TextStyle(fontSize: 16.sp),
      ),
    ),
  );
}
