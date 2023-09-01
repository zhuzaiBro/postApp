


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:post_app/pages/order_home/model/home_order_controller.dart';
import 'package:post_app/pages/upload_exception/model/upload_exception_controller.dart';

class UploadException extends StatefulWidget {
  const UploadException({Key? key}) : super(key: key);

  @override
  State<UploadException> createState() => _UploadExceptionState();
}

class _UploadExceptionState extends State<UploadException> {

  /// 异常图片
  List<String> picUrls = [];
  /// 异常内容
  String description = "";

  final orderController = Get.put(HomeOrderController());
  final uploadExceptionController = Get.put(UploadExceptionController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: uploadExceptionController,
        builder: (controller) {
      return CupertinoPageScaffold(

        navigationBar: CupertinoNavigationBar(
          previousPageTitle: "上传异常",

        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            children: [
              Container(
                child: Icon(Icons.upload, size: 28.sp, color: const Color(0xff666666),),
              )
            ],
          ),
        ),
      );
    });
  }


}
