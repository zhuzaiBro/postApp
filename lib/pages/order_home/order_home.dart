import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/model/grab.dart';
import 'package:post_app/pages/order_home/comp/home_appbar.dart';
import 'package:get/get.dart';
import 'package:post_app/pages/order_home/comp/user_drawer.dart';
import 'package:post_app/pages/order_home/model/home_order_controller.dart';
import 'package:post_app/utils/scroller.dart';
import 'package:post_app/utils/map.dart';
import '../login/model/user_controller.dart';
import 'comp/bottom_bar.dart';
import 'comp/grab_comp.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderHome extends StatefulWidget {
  const OrderHome({Key? key}) : super(key: key);

  @override
  State<OrderHome> createState() => _OrderHomeState();
}

class _OrderHomeState extends State<OrderHome> {
  final LocationFlutterPlugin _myLocPlugin = LocationFlutterPlugin();
  BaiduLocation location = BaiduLocation(
      longitude: 120.28924886067708, latitude: 30.482062174479168);
  Timer? _timer;

  int currentIndex = 0;

  // ScrollController scrollController =
  //     ScrollController(keepScrollOffset: false, initialScrollOffset: 40.h);

  @override
  void initState() {
    startGetLoc((BaiduLocation result) {
      //result为定位结果
      location = result;
    });
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent, //这里替换你选择的颜色
      ),
    );

    stopLocation();
    super.dispose();
  }

  void getLocation() {
    _myLocPlugin.startLocation();
    _timer = Timer(const Duration(seconds: 2), () {
      _myLocPlugin.stopLocation();
      _timer!.cancel();
      _timer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent, //这里替换你选择的颜色
      ),
    );
    return GetBuilder(
        init: HomeOrderController(),
        builder: (orderController) {
          return Scaffold(
            drawer: UserDrawer(userInfo: defaultUser),
            bottomNavigationBar: const MewkesButtonBar(),
            backgroundColor: const Color(0xfff5f5f5),
            appBar: HomeAppBar(userInfo: defaultUser),
            body: ScrollConfiguration(
              behavior: NoShadowScrollBehavior(),
              child: PageView(
                controller: orderController.pageController,
                onPageChanged: (index) {
                  handleIndexChanged(index, orderController);
                },
                children: [
                  buildGrabList(orderController, 0),
                  buildGrabList(orderController, 1),
                  buildGrabList(orderController, 2),
                ],
              ),
            ),
          );
        });
  }

  void handleIndexChanged(int index, HomeOrderController orderController) {
    orderController.currentIndex = RxInt(index);
    switch (index) {
      case 0:
        orderController.fetchAvailableData();
        break;
      case 1:
        orderController.fetchMyGrabs();
        break;

      case 2:
        orderController.fetchMyGrabs();
        break;
      default:
        orderController.fetchAvailableData();
    }
    orderController.refresh();
  }

  Widget buildGrabList(HomeOrderController orderController, int index) {
    List<Grab> data = [];
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    void Function() _onRefresh = () {};
    void Function() _onBottom = () {};
    switch (index) {
      case 0:
        data = orderController.availableGrabs.list!;
        _onRefresh = () async {
          orderController.availableGrabs.reSetPage();
          await orderController.fetchAvailableData();
          _refreshController.refreshCompleted();
        };
        _onBottom = () async {
          // await orderController.fetchAvailableData();
          if (orderController.availableGrabs.isMore!) {
            orderController.fetchAvailableData();
            _refreshController.loadComplete();
          } else {
            _refreshController.loadNoData();
          }
        };
        break;
      case 1:
        data = orderController.myGrabs.list!;
        _onRefresh = () async {
          orderController.myGrabs.reSetPage();
          await orderController.fetchMyGrabs();
          _refreshController.refreshCompleted();
        };
        _onBottom = () async {
          // await orderController.fetchMyGrabs();
          if (orderController.myGrabs.isMore!) {
            orderController.fetchMyGrabs();
            _refreshController.loadComplete();
          } else {
            _refreshController.loadNoData();
          }
        };
        break;
      case 2:
        data = orderController.deliveringGrabs.list!;
        _onRefresh = () async {
          orderController.deliveringGrabs.reSetPage();
          await orderController.fetchMyGrabs();
          _refreshController.refreshCompleted();
        };
        _onBottom = () async {
          if (orderController.deliveringGrabs.isMore!) {
            orderController.fetchMyGrabs();
            _refreshController.loadComplete();
          } else {
            _refreshController.loadNoData();
          }
        };
        break;
      default:
        data = orderController.availableGrabs.list!;
        _onRefresh = () async {
          orderController.availableGrabs.reSetPage();
          await orderController.fetchAvailableData();
          _refreshController.refreshCompleted();
        };
        _onBottom = () async {
          // await orderController.fetchAvailableData();
          _refreshController.loadNoData();
        };
    }
    return ScrollConfiguration(
      behavior: NoShadowScrollBehavior(),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onLoading: _onBottom,
        header: TwoLevelHeader(
          height: 50.h,
          decoration: const BoxDecoration(color: Color(0xfff5f5f5)),
          completeText: "刷新完成",
          refreshingText: "正在刷新",
          releaseText: "松开刷新",
          idleText: "下拉刷新",
        ),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            debugPrint(mode.toString());
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text(
                "上拉加载",
                style:
                    TextStyle(fontSize: 15.sp, color: const Color(0xff666666)),
              );
            } else if (mode == LoadStatus.loading) {
              body = const CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text(
                "加载失败！点击重试！",
                style:
                    TextStyle(fontSize: 15.sp, color: const Color(0xff666666)),
              );
            } else if (mode == LoadStatus.canLoading) {
              body = Text(
                "松手,加载更多!",
                style:
                    TextStyle(fontSize: 15.sp, color: const Color(0xff666666)),
              );
            } else {
              body = Text(
                "没有更多数据了!",
                style:
                    TextStyle(fontSize: 15.sp, color: const Color(0xff666666)),
              );
            }
            return Container(
              height: 50.0.h,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        child: (data.isNotEmpty && orderController.initialized)
            ? ListView.builder(
                padding: EdgeInsets.only(top: 8.h),
                itemCount: data.length,
                itemExtent: 244.h,
                itemBuilder: (ctx, index) {
                  return GrabComp(
                    grab: data[index],
                    callback: () {
                      orderController.setChooseGrab(data[index]);
                      Get.toNamed("/post_detail");
                    },
                    myLocation: location,
                  );
                })
            : Center(
                child: Column(
                  children: [
                    Image.network(
                        "https://cdn.discosoul.com.cn/farm-1309397063c7513d9d567d43e7a070e9dacb901890.png"),
                    Text(
                      index == 0 ? "附近暂时没有任务" : "你还没有任务，快去接单吧",
                      style: TextStyle(
                          color: const Color(0xff666666), fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
