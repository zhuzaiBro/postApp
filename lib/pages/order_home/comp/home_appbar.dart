import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/pages/order_home/model/home_order_controller.dart';
import 'package:post_app/model/user.dart';
import 'TabItem.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User userInfo;

  const HomeAppBar({Key? key,required this.userInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final grabController = Get.put(HomeOrderController());

    final List<TabItem> tabItems = [
      TabItem(title: "新任务(${grabController.availableGrabs.total})", index: 0),
      TabItem(title: "待取货(${grabController.myGrabs.total})", index: 1),
      TabItem(title: "配送中(${grabController.deliveringGrabs.total})", index: 2),
    ];


    final double statusBarHeight = MediaQuery.of(context).padding.top;


      return Container(
        decoration: const BoxDecoration(color: Color(0xff2A3228)),
        padding: EdgeInsets.only(
            top: statusBarHeight , left: 15, right: 15, bottom: 8),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 12.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Icon(
                     Icons.format_list_bulleted_sharp,
                      size: 32.sp,
                      color: const Color(0xfff5f5f5),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(left: 12.w),
                      padding:
                      EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
                      decoration: BoxDecoration(
                          color: Color(0xff3c3f41),
                          borderRadius: BorderRadius.all(Radius.circular(12.w))),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.qrcode_viewfinder,
                            color: Color(0xfff5f5f5),
                          ),
                          Text(
                            "下线中",
                            style:
                            TextStyle(fontSize: 12, color: Color(0xfff5f5f5)),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Tabs
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        child: Row(
                          children: buildTabItems(tabItems),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      );



  }

  List<Widget> buildTabItems(List<TabItem> list) {
    HomeOrderController controller = Get.put(HomeOrderController());

    return list.map((item) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            controller.pageController.animateToPage(item.index, duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              item.title,
              style: TextStyle(
                color: controller.currentIndex == RxInt(item.index)
                    ? const Color(0xffcefc52)
                    : const Color(0xfff5f5f5),
                fontSize: 16.sp,
                fontWeight: controller.currentIndex == RxInt(item.index)
                    ? FontWeight.w600
                    : FontWeight.w500,
              ),
            ),
          )
        ),
      );
    }).toList();
  }

  @override
  Size get preferredSize => Size(double.infinity, 88.h);
}
