import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:post_app/config/config.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

final box = GetStorage('mewkes');

Dio request({bool needCheck = true}) {
  String accessToken = box.read("token") ?? "";
  debugPrint("=========$accessToken=========");
  if (needCheck && accessToken == "") {
    Get.dialog(
      Center(
        child: Container(
          width: 300.w,
          height: 320.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
              color: const Color(0xfff5f5f5),
              borderRadius: BorderRadius.all(Radius.circular(12.sp))),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 12.h),
                child: Text(
                  "您的登录已过期，请重新授权登录！",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xff222222),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  height: 100.h,
                  child: Image.network(
                      "https://cdn.discosoul.com.cn/farm-1309397063973155fb09f74c2f8c3ccae0e242ec7f.png"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                    Get.toNamed("/login");
                },
                style: ElevatedButton.styleFrom(minimumSize: Size(220.w, 38.h), elevation: 2.0,),
                child: Text("去登录",
                style: TextStyle(
                  color: const Color(0xff222222),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                style: TextButton.styleFrom(
                  shadowColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory
                ),
                child: Text(
                  "我再想想",
                  style: TextStyle(color: Color(0xff666666)),
                ),
              )
            ],
          ),
        ),
      ),
      useSafeArea: true,
    );
  }
  var dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'content-type': "application/json",
        'Authorization': "Bearer $accessToken",
      },
    ),
  );

  dio.interceptors.add(QueuedInterceptorsWrapper(onRequest: (options, handler) {
    return handler.next(options);
  }, onError: (error, handler) {
    if (error.response?.statusCode == 401) {
      var options = error.response!.requestOptions;
      debugPrint("response?.statusCode == 401  ");
      Get.dialog(
        Center(
          child: Container(
            width: 300.w,
            height: 320.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
                color: const Color(0xfff5f5f5),
                borderRadius: BorderRadius.all(Radius.circular(12.sp))),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  child: Text(
                    "您的登录已过期，请重新授权登录！",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xff222222),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    height: 100.h,
                    child: Image.network(
                        "https://cdn.discosoul.com.cn/farm-1309397063973155fb09f74c2f8c3ccae0e242ec7f.png"),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/login");
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(220.w, 38.h), elevation: 2.0,),
                  child: Text("去登录",
                    style: TextStyle(
                      color: const Color(0xff222222),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: TextButton.styleFrom(
                      shadowColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory
                  ),
                  child: Text(
                    "我再想想",
                    style: TextStyle(color: Color(0xff666666)),
                  ),
                )
              ],
            ),
          ),
        ),
        useSafeArea: true,
      );
      return;
    }
    return handler.next(error);
  }, onResponse: (resp, handler) {
    var statusCode = resp.data['status'];
    if (statusCode == 200) {
      debugPrint("resp.data['status'] == 200");
      return handler.next(resp);
    } else if (statusCode == 401) {
      // token过期了，清理数据
      box.remove("token");
      box.remove("expires_time");
    }
  }));

  return dio;
}
