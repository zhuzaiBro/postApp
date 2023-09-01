import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/pages/login/model/user_controller.dart';

import 'package:post_app/model/user.dart';
import 'package:post_app/utils/dialog.dart';

List<WorkItem> list = [
  WorkItem(name: "健康证", icon: Icon(Icons.data_thresholding_sharp, size: 28.sp,color: const Color(0xff666666),), path: "/"),
  WorkItem(name: "身份信息", icon: Icon(Icons.insert_drive_file_rounded,size: 28.sp,color: const Color(0xff666666),), path: "/"),
  WorkItem(name: "平台协议", icon: Icon(CupertinoIcons.arrow_down_doc_fill,size: 28.sp,color: const Color(0xff666666),), path: "/"),
  WorkItem(name: "培训", icon: Icon(Icons.pedal_bike_sharp,size: 28.sp,color: const Color(0xff666666),), path: "/login"),
];

class UserDrawer extends StatelessWidget {
  const UserDrawer({Key? key, required this.userInfo}) : super(key: key);

  final User userInfo;
  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());

    return GetBuilder(
        init: userController,
        builder: (userController) {
          return Drawer(
            child: MediaQuery.removePadding(
              removeTop: false,
              context: context,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 58.h,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 12.w),
                          child: CircleAvatar(
                            minRadius: 38.w,
                            backgroundImage:
                                NetworkImage(userController.userInfo.avatar),
                          ),
                        ),
                        SizedBox(
                          width: 100.w,
                          child: Text(
                            userController.userInfo.nickname,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: const Color(0xff222222),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12.h),
                      height: 130.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                          color: const Color(0xffF0F3F4),
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.sp))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(right: 8.w),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 18.h,
                                              width: 4.w,
                                              margin:
                                                  EdgeInsets.only(right: 6.w),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff73E5BB),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              2.w))),
                                            ),
                                            Text(
                                              "订单统计",
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 8.w),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: const Color(0xff666666),
                                                size: 16.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 6.h),
                                        child: Row(
                                          children: [
                                            Text(
                                              "8888",
                                              style: TextStyle(
                                                  fontSize: 22.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xff47aa61)),
                                            ),
                                            Text(
                                              "单",
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff666666),
                                                  fontSize: 13.sp),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(left: 8.w),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 18.h,
                                              width: 4.w,
                                              margin:
                                                  EdgeInsets.only(right: 6.w),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffff4400),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              2.w))),
                                            ),
                                            Text(
                                              "我的账户",
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 8.w),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: const Color(0xff666666),
                                                size: 16.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 6.h),
                                        child: Row(
                                          children: [
                                            Text(
                                              "${userController.userInfo.brokeragePrice}",
                                              style: TextStyle(
                                                fontSize: 22.sp,
                                                color: const Color(0xffff4400),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "元",
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff666666),
                                                  fontSize: 13.sp),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 8.w),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 6.w),
                                          child: Icon(Icons.comment, color: const Color(0xff73E5BB), size: 22.sp,),
                                        ),
                                        Text(
                                          "我的评价",
                                          style: TextStyle(fontSize: 16.sp, color: const Color(0xff202020)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 8.w),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 6.w),
                                          child: Icon(Icons.border_color_sharp, color: const Color(0xffeea532), size: 22.sp,),
                                        ),
                                        Text(
                                          "违规申诉",
                                          style: TextStyle(fontSize: 16.sp, color: const Color(0xff202020)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      height: 100.h,
                      margin: EdgeInsets.only(top: 12.h),
                        padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                      decoration: BoxDecoration(
                          color: const Color(0xffececec),
                        borderRadius: BorderRadius.all(Radius.circular(12.sp))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            child: Text("工作配置", style: TextStyle(
                              color: const Color(0xff202020),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),),
                          ),
                          Row(
                            children: buildWorkItem(list),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 22.h),
                      child: ElevatedButton(
                        onPressed: () {
                          defaultDialog(() {
                            /// 处理用户退出登录
                          }, "title", "info");
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 46.h),
                            backgroundColor: Colors.grey[200]
                        ),
                        child: Text("账号设置", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: const Color(0xff666666)),),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 22.h),
                      child: ElevatedButton(
                        onPressed: () {
                            defaultDialog(() {
                              /// 处理用户退出登录
                            }, "title", "info");
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 46.h),
                          backgroundColor: Colors.red[400]
                        ),
                        child: Text("退出登录", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: const Color(0xffffffff)),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }


  List<Widget> buildWorkItem(List<WorkItem> list) {
    return list.map((e) {
      return Expanded(child: Container(
        child:  GestureDetector(
          onTap: () {
            Get.toNamed(e.path);
          },
          child: Column(
            children: [

              e.icon,
              Container(
                margin: EdgeInsets.only(top: 3.h),
                child: Text(e.name, style: TextStyle(fontSize: 14.sp, color: const Color(0xff666666)),),
              ),
            ],
          ),
        ),


      ),);
    }).toList();
  }
}

class WorkItem {

  final String name;
  final Widget icon;
  final String path;

  WorkItem({required this.name, required this.icon, required this.path});
}
