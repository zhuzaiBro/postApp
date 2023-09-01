import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_app/pages/login/model/user_controller.dart';

enum LoginType {
  passWord(title: "账号密码登录"),
  phone(title: "手机号登录");

  final String title;

  const LoginType({required this.title});
  String getChangedTitle() {
    if (title == LoginType.passWord.title) {
      return LoginType.phone.title;
    } else {
      return LoginType.passWord.title;
    }
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  gapPadding: 0,
  borderSide: BorderSide(
    width: 0,
    color: Colors.transparent,
  ),
);

class _LoginState extends State<Login> {
  bool isUseToken = false;
  bool isUserOk = false;

  LoginType loginType = LoginType.passWord;

  var userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent, //这里替换你选择的颜色
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: (() {
          FocusScope.of(context).requestFocus(FocusNode());
        }),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/loginBg.png"), fit: BoxFit.fill)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 44.h, bottom: 22.h),
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          CupertinoIcons.back,
                          color: const Color(0xff5c5c5c),
                          size: 32.sp,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Text(
                          "注册",
                          style: TextStyle(
                              fontSize: 18.sp, color: const Color(0xff202020)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                '欢迎登录喵送员',
                style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff202020)),
              ),
              const SizedBox(height: 30),
              Container(
                // margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 0.25),
                  borderRadius: BorderRadius.circular((20.0)),
                ),
                child: TextField(
                  cursorColor: const Color(0xff47aa61),
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    userController.loginParam.username = value;
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const InputDecoration(
                    hintText: "请输入手机号码",
                    contentPadding:
                        EdgeInsets.only(top: 0, left: 15, right: 15),
                    border: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    disabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 0.25),
                  borderRadius: BorderRadius.circular((20.0)),
                ),
                child: loginType == LoginType.passWord
                    ? TextField(
                        cursorColor: const Color(0xff47aa61),
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          userController.loginParam.password = value;
                        },
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(top: 0, left: 15, right: 15),
                            border: InputBorder.none,
                            hintText: '输入密码'),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: TextField(
                                cursorColor: const Color(0xff47aa61),
                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  userController.loginParam.code = value;
                                },
                                onEditingComplete: () {
                                  FocusScope.of(context).unfocus();
                                },
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: 0, left: 15, right: 15),
                                    border: InputBorder.none,
                                    hintText: '输入验证码'),
                              ),
                            ),
                          ),
                          Container(
                            width: 120.w,
                            padding: EdgeInsets.only(right: 12.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 1.w,
                                  height: 26.h,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff999999)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    userController.getCode(userController.loginParam.username);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text("获取验证码"),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                child: Row(
                  children: [
                    Checkbox(
                        value: isUserOk,
                        checkColor: const Color(0xffcefc52),
                        activeColor: const Color(0xff222222),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(5.sp),
                        )),
                        onChanged: (value) {
                          debugPrint(value.toString());
                          setState(() {
                            isUserOk = value!;
                          });
                        }),
                    Container(
                      margin: EdgeInsets.only(right: 2.w),
                      child: Text(
                        "登录代表你已同意",
                        style: TextStyle(
                            color: Color(0xff666666), fontSize: 14.sp),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 2.w),
                      child: Text(
                        "用户协议、隐私政策",
                        style: TextStyle(
                            color: Color(0xff47aa61), fontSize: 14.sp),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async {
                    if (!isUserOk) {
                      Get.snackbar("提示", "请同意用户协议和隐私政策！");
                      return;
                    }

                    if(loginType == LoginType.passWord) {
                      userController.login();
                    } else {
                      debugPrint(
                          "${loginType.title}username ${userController.loginParam.username} pwd  ${userController.loginParam.code}");
                      userController.codeLogin();
                    }

                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 300.w,
                    height: 52.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                        gradient: const LinearGradient(colors: [
                          Color(0xff47aa61),
                          Color(0xffcefc52),
                        ]),
                        boxShadow: [
                          BoxShadow(color: Color(0xffecc020), blurRadius: 2.sp)
                        ]),
                    child: Text(
                      '登录',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xffffffff)),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 42.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (loginType == LoginType.phone) {
                            loginType = LoginType.passWord;
                          } else {
                            loginType = LoginType.phone;
                          }
                        });
                      },
                      child: Container(
                        child: Text(
                          loginType.getChangedTitle(),
                          style: TextStyle(
                              fontSize: 14.sp, color: const Color(0xff666666)),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Text("遇到问题",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xff666666))),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
