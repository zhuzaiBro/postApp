import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:post_app/pages/handle_exception/handle_exception.dart';
import 'package:post_app/pages/login/login.dart';
import 'package:post_app/pages/order_home/order_home.dart';
import 'package:post_app/pages/post_detail/post_detail.dart';
import 'package:post_app/pages/login/login.dart';
import 'package:post_app/pages/upload_exception/upload_exception.dart';


List<GetPage<dynamic>> Routes = [
  GetPage(
    name: "/home",
    page: () => const OrderHome(),
  ),

  GetPage(
    name: "/post_detail",
    page: () => const PostDetail(),
  ),

  GetPage(name: "/login", page: () => const Login()),

  GetPage(name: "/handleException",
  page: () => const HandleException()
  ),

  GetPage(name: "/uploadException", page: () => const UploadException())

];
