import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:post_app/pages/handle_exception/model/handle_exception_controller.dart';

class HandleException extends StatelessWidget {
  const HandleException({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final handleExceptionController = Get.put(HandleExceptionController());
    return GetBuilder(
      init: handleExceptionController,
      builder: (controller) {
        return CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              previousPageTitle: "",
              middle: Text("遇到问题"),

            ),

            child: Container(
              width: Get.width,
              height: Get.height,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 88.h),
              color: Color(0xffff4400),
              child: Column(
                children: [
                  Container(
                    child: Text("车坏了"),
                  ),
                  CupertinoButton(
                      color: Color(0xff008c8c),
                      child: Text("ads"), onPressed: () {

                  })
                ],
              ),
            )
        );
      },
    );
  }
}
