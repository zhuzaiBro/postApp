import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:post_app/pages/login/model/user_controller.dart';
import 'package:post_app/model/user.dart';
import 'package:post_app/utils/request.dart';
import 'package:post_app/config/constance.dart';

Future<User> fetchUserInfo() async {
  String? expire = GetStorage('mewkes').read("expires_time");
  if (expire == null) {
    return defaultUser;
  }
  DateTime expireTime = DateTime.parse(expire);
  if (expireTime.isBefore(DateTime.now())) {
    /// todo 说明token过期了
    GetStorage(mewkes).remove(accessToken);
    GetStorage(mewkes).remove(expire);
  }



  var res = await request().get('/mall/userinfo');

  return User.fromJson(res.data['data']);

}

Future<void> requestCode(String phone)  async{
  var res = await request(needCheck: false).post("/mall/api/auth/register/verify", data: {"phone": phone });

  debugPrint(res.toString());
}

Future<String> mobileLogin (String phone, String code) async {
  var res = await request(needCheck: false).post("/mall/api/auth/register", data: {
    "account": phone,
    "captcha": code
  });
  debugPrint("=========REA${res.data.toString()}");
  return res.data;
}
