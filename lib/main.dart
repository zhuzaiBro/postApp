import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:post_app/pages/order_home/order_home.dart';
import 'package:post_app/router/routes.dart';
import 'package:post_app/utils/map.dart';
import 'package:post_app/config/constance.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  /// 初始化存储
  await GetStorage.init(mewkes);
  WidgetsFlutterBinding.ensureInitialized();
  /// 动态申请定位权限
  requestPermission();

  /// 初始化百度地图SDK
  initMap();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext ctx, Widget? widget) {
        return GetMaterialApp(
            localizationsDelegates: const [RefreshLocalizations.delegate],
          theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xff222222),
              backgroundColor: const Color(0xffcefc52),
              shadowColor: const Color(0xffcefc52),
              elevation: 2.0,
            )),
            cardColor: const Color(0xffcefc52),
          ),
          home: const OrderHome(),
          initialRoute: '/',
          getPages: Routes,
          routingCallback: (routing) {
            if (routing?.current != "") {
              debugPrint("currentPage：${routing?.current}");
            }
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
