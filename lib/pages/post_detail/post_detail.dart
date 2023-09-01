import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/model/grab.dart';
import 'package:post_app/pages/order_home/model/home_order_controller.dart';
import 'package:post_app/pages/post_detail/model/controller.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:post_app/pages/order_home/comp/grab_comp.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/cart_info.dart';
import '../../utils/scroller.dart';
import '../../widgets/gesture_animate_view.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key});

  @override
  State<PostDetail> createState() => _PostDetail();
}

class _PostDetail extends State<PostDetail> with TickerProviderStateMixin {
  final postDetailController = Get.put(PostDetailController());
  final orderController = Get.put(HomeOrderController());
  ScrollEnum scrollEnum = ScrollEnum.middle;
  final scrollController =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  double scrollTop = 0.0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {
        scrollTop = scrollController.offset;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent, //这里替换你选择的颜色
      ),
    );

    return GetBuilder(
      init: postDetailController,
      builder: (detailController) {
        return Scaffold(
          body: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  generateMap(postDetailController.location),
                  GestureAnimateView(
                    scrollTop: scrollTop,
                    onScrollCall: (ScrollEnum e) {
                      setState(() {
                        scrollEnum = e;
                      });
                    },
                    bottomHeight: Get.height / 2,
                    child: _listInfo(),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildBottom(),
                  ),
                ],
              )),
        );
      },
    );
  }

  /// 创建地图
  Container generateMap(BaiduLocation location) {
    return Container(
        decoration: const BoxDecoration(),
        // height: ,
        width: 390.w,
        child: Stack(
          children: [
            BMFMapWidget(
              onBMFMapCreated: postDetailController.onBMFMapCreated,
              mapOptions: initMapOptions(location),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 42.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      CupertinoIcons.back,
                      size: 38.sp,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 8.w),
                      padding:
                          EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
                      decoration: BoxDecoration(
                          color: const Color(0xfff7eeea),
                          borderRadius: BorderRadius.all(Radius.circular(5.w)),
                          boxShadow: const [
                            BoxShadow(
                                color: Color(0xfff7eecc),
                                spreadRadius: 1.0,
                                blurRadius: 1.0)
                          ]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.info_circle,
                            size: 22.sp,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8.w),
                            child: Text(
                              "取送路线示意，非导航规划，请遵守交规",
                              style: TextStyle(fontSize: 13.sp),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 298.h,
              child: Container(
                padding: EdgeInsets.only(bottom: 12.h, left: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // postDetailController.getLocation();
                      },
                      child: Container(
                        width: 36.sp,
                        height: 36.sp,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.sp),
                          ),
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: const Color(0xff202020),
                          size: 28.sp,
                        ),
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  BMFMapOptions initMapOptions(BaiduLocation location) {
    BMFMapOptions mapOptions = BMFMapOptions(
      center: BMFCoordinate(location.latitude!, location.longitude!),
      zoomLevel: 12,
      rotateEnabled: false,
      mapPadding: BMFEdgeInsets.fromEdgeInsets(
        EdgeInsets.only(
            top: 120.h, bottom: 500.h, left: 15.w, right: 15.w),
      ),
    );
    return mapOptions;
  }

  Widget _listInfo() {
    return Container(
      height: Get.height / 2,
      padding: EdgeInsets.only(right: 15.w, left: 15.w, top: 18.h),
      decoration: BoxDecoration(
          color: const Color(0xffffffff),
          boxShadow: [
            BoxShadow(
                color: const Color(0xff999999),
                offset: Offset.zero,
                blurRadius: 2.w)
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.w), topRight: Radius.circular(32.w))),
      transform: Matrix4.translationValues(0, -98.h, 0),
      child: ScrollConfiguration(
        behavior: NoShadowScrollBehavior(),
        child: ListView(
          controller: scrollController,
          primary: false,
          shrinkWrap: false,
          physics: scrollEnum == ScrollEnum.top
              ? const ClampingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.only(right: 164.w, bottom: 7.h, left: 164.w),
              height: 3.6.h,
              width: 40.w,
              decoration: BoxDecoration(
                  color: const Color(0xff999999),
                  borderRadius: BorderRadius.all(Radius.circular(1.8.h))),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8.h),
              child: Row(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 8.w),
                        child: Icon(
                          CupertinoIcons.clock_solid,
                          size: 22.sp,
                        ),
                      ),
                      Text(
                        "还剩",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Text(
                          "20分钟",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: const Color(0xfff47d45)),
                        ),
                      ),
                      Text(
                        "送货",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15.sp),
                      )
                    ],
                  )
                ],
              ),
            ),
            _buildStartAndEnd(),
            _buildGoodList(),
            _buildOrderInfo(),
            _buildOrderIncome(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 5.h, bottom: 22.h, left: 15.w, right: 15.w),
      decoration: BoxDecoration(color: const Color(0xfff3f3f3), boxShadow: [
        BoxShadow(color: const Color(0xffececec), blurRadius: 1.sp)
      ]),
      height: 98.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              // Get.
              Get.bottomSheet(Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                height: 120.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22.sp),
                      topRight: Radius.circular(22.sp),
                    ),
                    color: const Color(0xffffffff)),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        launch(
                            "tel:${orderController.chooseGrab.orders[0].userPhone}");
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        child: Text(
                          "拨打给顾客",
                          style: TextStyle(
                              color: const Color(0xff138ac0),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launch(
                            "tel:${orderController.chooseGrab.orders[0].storePhone}");
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        child: Text(
                          "拨打给商家",
                          style: TextStyle(
                              color: const Color(0xff138ac0),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
              ));
            },
            child: Container(
              width: 60.w,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 12.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 2.h),
                    child: Icon(
                      CupertinoIcons.phone_fill,
                      size: 28.sp,
                      color: const Color(0xff202020),
                    ),
                  ),
                  Text(
                    "联系",
                    style: TextStyle(
                        color: const Color(0xff202020), fontSize: 12.sp),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
             Get.toNamed("/handleException");
            },
            child: Container(
              width: 60.w,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 12.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 2.h),
                    child: Icon(
                      Icons.chat,
                      size: 28.sp,
                      color: const Color(0xff202020),
                    ),
                  ),
                  Text(
                    "遇到问题",
                    style: TextStyle(
                        color: const Color(0xff202020), fontSize: 12.sp),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(100.w, 46.h),
                      backgroundColor: orderController.chooseGrab.status ==
                              GrabStatus.DELIVERING.status
                          ? const Color(0xff47aa61)
                          : const Color(0xffff3300),
                      foregroundColor: const Color(0xfff5f5f5)),
                  onPressed: () {
                    orderController.handleSendBtnPres();
                  },
                  child: Text(
                      GrabStatus.getName(orderController.chooseGrab.status),
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600)))),
        ],
      ),
    );
  }

  Widget _buildStartAndEnd() {
    return Container(
      padding: EdgeInsets.only(bottom: 12.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffececec),
          ),
        ),
      ),
      height: 160.h,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 12.w),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 26.sp,
                  height: 26.sp,
                  decoration: BoxDecoration(
                      color: const Color(0xfff47d45),
                      borderRadius: BorderRadius.all(Radius.circular(13.sp))),
                  child: Text(
                    "取",
                    style: TextStyle(
                        color: const Color(0xfff5f5f5), fontSize: 16.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12.h),
                  child: Column(
                    children: [
                      Text(
                        getDistance(
                          double.parse(orderController
                              .chooseGrab.orders[0].userAddressLatitude),
                          double.parse(orderController
                              .chooseGrab.orders[0].userAddressLongitude),
                          double.parse(orderController
                              .chooseGrab.orders[0].storeLatitude),
                          double.parse(orderController
                              .chooseGrab.orders[0].storeLongitude),
                        ),
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "km",
                        style: TextStyle(fontSize: 13.sp),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 26.sp,
                  height: 26.sp,
                  decoration: BoxDecoration(
                      color: const Color(0xff56a875),
                      borderRadius: BorderRadius.all(Radius.circular(13.sp))),
                  child: Text(
                    "送",
                    style: TextStyle(
                        color: const Color(0xfff5f5f5), fontSize: 16.sp),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 260.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderController.chooseGrab.orders[0].storeName,
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2.h),
                              width: 300.w,
                              child: Text(
                                orderController
                                    .chooseGrab.orders[0].storeAddress,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    overflow: TextOverflow.ellipsis,
                                    color: const Color(0xff666666)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: postDetailController.searchStore2User,
                        child: Icon(
                          CupertinoIcons.location_circle_fill,
                          size: 32.sp,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 268.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderController.chooseGrab.orders[0].userAddress,
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              width: 300.w,
                              margin: EdgeInsets.only(top: 2.h),
                              child: Text(
                                orderController.chooseGrab.orders[0].realName,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color(0xff666666),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: postDetailController.searchStore2User,
                        child: Icon(
                          CupertinoIcons.location_circle_fill,
                          size: 32.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildGoodList() {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.only(bottom: 12.h),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color((0xffececec))))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "商品列表",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          Column(
            children:
                _buildGoods(orderController.chooseGrab.orders[0].cartInfo),
          )
        ],
      ),
    );
  }

  List<Widget> _buildGoods(List<CartInfo> goods) {
    return goods.map((e) {
      return Container(
        margin: EdgeInsets.only(top: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              e.cartInfoMap.productInfo.storeName,
              style: TextStyle(fontSize: 14.sp, color: const Color(0xff666666)),
            ),
            Text(
              "x${e.cartInfoMap.cartNum}",
              style: TextStyle(fontSize: 14.sp, color: const Color(0xff666666)),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildOrderInfo() {
    var item = orderController.chooseGrab.orders[0];
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.only(bottom: 12.h),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color((0xffececec))))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "订单信息",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "订单类型",
                      style: TextStyle(
                          fontSize: 14.sp, color: const Color(0xff666666)),
                    ),
                    Text(
                      item.cartInfo[0].cartInfoMap.type == "fresh"
                          ? "生鲜"
                          : "普通商品",
                      style: TextStyle(
                          fontSize: 14.sp, color: const Color(0xff666666)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "订单号",
                      style: TextStyle(
                          fontSize: 14.sp, color: const Color(0xff666666)),
                    ),
                    Text(
                      item.orderId,
                      style: TextStyle(
                          fontSize: 14.sp, color: const Color(0xff666666)),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildOrderIncome() {
    var item = orderController.chooseGrab.orders[0];
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.only(bottom: 12.h),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color((0xffececec))))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "订单收入",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "配送费",
                      style: TextStyle(
                          fontSize: 14.sp, color: const Color(0xff666666)),
                    ),
                    Text(
                      "${orderController.chooseGrab.brokerage}元",
                      style: TextStyle(
                          fontSize: 14.sp, color: const Color(0xff666666)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "合计",
                      style: TextStyle(
                          fontSize: 14.sp, color: const Color(0xff666666)),
                    ),
                    Text(
                      "${orderController.chooseGrab.brokerage}元",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xffff4400)),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent, //这里替换你选择的颜色
      ),
    );
    // postDetailController.myMapController.;
    super.dispose();
  }
}
