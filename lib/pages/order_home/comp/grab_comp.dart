import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:post_app/model/grab.dart';
import 'package:post_app/pages/order_home/model/home_order_controller.dart';
import 'package:post_app/pages/post_detail/model/controller.dart';


Map<String, String> mapDeliveryInfo = {
  "AVAILABLE": "抢单",
  "LOCKED": "我已取货",
  "DELIVERING": "我已送达",
};


class GrabComp extends StatelessWidget {
  GrabComp(
      {Key? key,
      required this.grab,
      required this.callback,
      required this.myLocation})
      : super(key: key);

  final Grab grab;
  final BaiduLocation myLocation;
  void Function() callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h, left: 15.w, right: 15.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        width: 360.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.w)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xffececec), // 阴影的颜色
                offset: Offset.zero, // 阴影与容器的距离
                blurRadius: 45.sp, // 高斯的标准偏差与盒子的形状卷积。
                spreadRadius: 0.0, // 在应用模糊之前，框应该膨胀的量。
              )
            ],
            color: const Color(0xffffffff)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 6.h),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffececec),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${handleSendTime(grab.orders[0].createTime)}送达",
                      style: TextStyle(
                        color: const Color(0xff222222),
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text("奖励${grab.brokerage}元"),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6.h),
              alignment: Alignment.topCenter,
              height: 136.h,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                "${getDistance(
                                  double.parse(
                                      grab.orders[0].userAddressLatitude),
                                  double.parse(
                                      grab.orders[0].userAddressLongitude),
                                  myLocation.latitude!,
                                  myLocation.longitude!,
                                )}KM",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: const Color(0xff222222),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text("取货", style: TextStyle(fontSize: 14.sp, color: const Color(0xff666666) ),),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 40.w,
                        width: 2.w,
                        decoration: const BoxDecoration(
                          color: Color(0xffcccccc),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                "${getDistance(
                                  double.parse(grab.orders[0].storeLatitude),
                                  double.parse(grab.orders[0].storeLongitude),
                                  double.parse(
                                      grab.orders[0].userAddressLatitude),
                                  double.parse(
                                      grab.orders[0].userAddressLongitude),
                                )}M",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: const Color(0xff222222),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text("送货", style: TextStyle(fontSize: 14.sp, color: const Color(0xff666666) ),),
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                  // 配送的店面用户信息
                  Expanded(child: Container(
                    margin: EdgeInsets.only(left: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                grab.orders[0].storeName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                grab.orders[0].storeAddress,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xff666666)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                    child: Text(
                                      grab.orders[0].userAddress,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        // backgroundColor: Color(0xffff4400),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ],
                            ))
                      ],
                    ),
                  ),)
                  ,
                ],
              ),
            ),
            grab.status == "COMPLETED" ?  Container(
                alignment: Alignment.center,
                width: 300.w,
                height: 26.h,
                child: Text("订单已完成", style: TextStyle(
                  fontSize: 16.sp,
                ),)
            ) : ElevatedButton(
                onPressed: () {
                  final HomeOrderController orderController = Get.put(HomeOrderController());
                  orderController.setChooseGrab(grab);
                  orderController.handleSendBtnPres();
                },
                style: ElevatedButton.styleFrom(

                  shadowColor: const Color(0xffcefc52),
                  elevation: 2.0,
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: 300.w,
                  height: 26.h,
                  child: Text(
                    mapDeliveryInfo[grab.status]!,
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

String getDistance(double lat1, double lng1, double lat2, double lng2) {
  double radLat1 = rad(lat1);
  double radLat2 = rad(lat2);
  double a = radLat1 - radLat2;
  double b = rad(lng1) - rad(lng2);
  double s = 2 *
      asin(sqrt(pow(sin(a / 2), 2) +
          cos(radLat1) * cos(radLat2) * pow(sin(b / 2), 2)));
  return (s * 6378.1380).toStringAsFixed(2);
}

double rad(double d) {
  return d * pi / 180.0;
}

String handleSendTime(String time) {
  var createTime = DateTime.parse(time);
  var targetTime = createTime.add(const Duration(minutes: 45));
  var now = DateTime.now();
  if (targetTime.isBefore(now)) {
    /// 如果预期超时了，再额外加点时间
    targetTime = now.add(const Duration(minutes: 45));
  }

  return "${targetTime.hour}:${targetTime.minute}";
}
