import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:post_app/api/user.dart';
import 'package:post_app/config/constance.dart';
import 'package:post_app/pages/login/model/login_param.dart';
import 'package:post_app/utils/request.dart';
import 'package:post_app/model/user.dart';

User defaultUser = User(uid: 0, username: "", checkStatus: false, realName: "", nickname: "", avatar: "https://cdn.discosoul.com.cn/farm-1309397063c63aa871cf38453688062178e6f2e858.jpg", phone: "", addIp: "", lastIp: "", nowMoney: 0, brokeragePrice: 0, status: false, userType: "app", payCount: 0, spreadCount: 0, addres: "", loginType: "app");


class UserController extends GetxController {

  User userInfo = defaultUser;
  LoginParam loginParam = LoginParam("", "");
  String token = "";
  
  @override
  void onInit() {
    debugPrint("LoginParam loginParam = LoginParam("", "");");
    getUserInfo();
    super.onInit();
  }

  
  Future<void> getUserInfo() async {
    userInfo = await fetchUserInfo();
  }
  
  Future<void> login () async {
    Map<String, dynamic> data = {};
    data['username'] = loginParam.username;
    data['password'] = loginParam.password;
    var res = await  request(needCheck: false).post("/auth/oauth/login", data: data);

    String tokenStr = res.data['data']['token'];
    String expiresTime = res.data['data']['expires_time'];

    GetStorage(mewkes).write(accessToken, tokenStr);
    GetStorage(mewkes).write(expire, expiresTime);

    token = tokenStr;

  }

  Future<void> getCode(String phone) async {
    debugPrint("$phone");
    await requestCode(phone);
    Get.snackbar("提示", "发送成功，请注意查收短信");
  }

  Future<void> codeLogin() async {
    var res = await mobileLogin(loginParam.username, loginParam.code);

    debugPrint(res.toString());
  }

}