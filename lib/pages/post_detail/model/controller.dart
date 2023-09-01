import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:get/get.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:post_app/api/order.dart';
import 'package:post_app/model/grab.dart';
import 'package:post_app/utils/map.dart';
import 'package:post_app/pages/order_home/model/home_order_controller.dart';
import 'package:post_app/model/ride_route_model.dart';

class PostDetailController extends GetxController {
  late BMFMapController myMapController;
  BaiduLocation location = BaiduLocation(
      longitude: 120.28924886067708, latitude: 30.482062174479168);
  final LocationFlutterPlugin myLocPlugin = LocationFlutterPlugin();
  final HomeOrderController homeOrderController =
      Get.put(HomeOrderController());

  /// 根据polyline设置地图显示范围
  late BMFCoordinateBounds coordinateBounds;

  late Timer timer;
  /// 棋手到用户
  BMFPolyline? _polyline;

  /// 商户到用户
  BMFPolyline? _polyline2;

  late BMFLocation uLocation;


  Future<void> getLocation() async {
    Map iosMap = initIOSOptions().getMap();
    Map androidMap = initAndroidOptions().getMap();

    var suc = await myLocPlugin.prepareLoc(androidMap, iosMap);

    if (suc) {
      await myLocPlugin.startLocation();
      debugPrint("startLocation");
    }
  }

  void updateUserHeading(BaiduHeading heading) {
    BMFUserLocation userLocation = BMFUserLocation(
      location: uLocation,
      heading: BMFHeading(trueHeading: heading.trueHeading),
      updating: true,
      title: '我的位置',
    );
    myMapController.updateLocationData(userLocation);
  }

  /// 创建完成回调
  void onBMFMapCreated(BMFMapController controller) {
    myMapController = controller;

    /// 地图加载回调
    myMapController.setMapDidLoadCallback(callback: () {
      debugPrint('mapDidLoad-地图加载完成');
    });
    myMapController.setMapClickedMarkerCallback(callback: (BMFMarker marker) {
      debugPrint('marker点击----${marker.id}');
    });

    myMapController.setMapDragMarkerCallback(callback: (BMFMarker marker,
        BMFMarkerDragState newState, BMFMarkerDragState oldState) {
      debugPrint('marker推拽----${marker.id}');
    });

    myLocPlugin.seriesLocationCallback(callback: handleLocationCallback);

    myLocPlugin.singleLocationCallback(callback: handleLocationCallback);

    /// 开始监听位置变化
    getLocation();

    /// 开始监听设备朝向
    myLocPlugin.startUpdatingHeading();

    myLocPlugin.updateHeadingCallback(callback: (res) {
      updateUserHeading(res);
    });
    uLocation = BMFLocation(
      coordinate: BMFCoordinate(location.latitude!, location.longitude!),
      altitude: location.altitude,
      horizontalAccuracy: location.horizontalAccuracy,
      verticalAccuracy: location.verticalAccuracy,
      speed: location.speed,
      course: location.course,
    );

    BMFUserLocation user = BMFUserLocation(
      location: uLocation,
    );
    myMapController.updateLocationData(user);
    myMapController.setUserTrackingMode(BMFUserTrackingMode.FollowWithHeading);
    myMapController.showUserLocation(true);
    refresh();
  }

  /// 绘制路线
  Future<void> drawRoutes(
      {required BaiduLocation from, required BaiduLocation to}) async {
    /// 起点
    BMFPlanNode startNode = BMFPlanNode(
      pt: BMFCoordinate(from.latitude!, from.longitude!),
    );

    /// 终点
    BMFPlanNode endNode =
        BMFPlanNode(pt: BMFCoordinate(to.latitude!, to.longitude!));
    BMFDrivingRoutePlanOption option = BMFDrivingRoutePlanOption(
      from: startNode,
      to: endNode,
      // ridingType: 1,
    );
    BMFDrivingRouteSearch routeSearch = BMFDrivingRouteSearch();


    /// 结果回调
    routeSearch.onGetDrivingRouteSearchResult(callback: handleDraw2Store);

    /// 发起检索
    bool result = await routeSearch.dringRouteSearch(option);

    if (result) {
      debugPrint("发起检索成功999");
    } else {
      debugPrint("发起检索失败");
    }
  }

  /// 检索
  Future<void> searchStore2User() async {
    /// 起点
    BMFPlanNode startNode = BMFPlanNode(
      pt: BMFCoordinate(
          double.parse(homeOrderController.chooseGrab.orders[0].storeLatitude),
          double.parse(
              homeOrderController.chooseGrab.orders[0].storeLongitude)),
    );

    /// 终点
    BMFPlanNode endNode =
        BMFPlanNode(pt: homeOrderController.buildBMFCoordinateFromOrder());

    /// 途经点

    BMFRidingRoutePlanOption option = BMFRidingRoutePlanOption(
      from: startNode,
      to: endNode,
      ridingType: 1,
    );

    /// 检索对象
    BMFRidingRouteSearch routeSearch2 = BMFRidingRouteSearch();

    /// 检索结果回调
    routeSearch2.onGetRidingRouteSearchResult(
        callback: _onGetRidingRouteSearchResult);

    /// 发起检索
    bool result = await routeSearch2.ridingRouteSearch(option);

    if (result) {
      debugPrint("发起检索成功");
    } else {
      debugPrint("发起检索失败");
    }
  }

  handleDraw2Store(BMFDrivingRouteResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败 errorCode:${errorCode.toString()}";
      debugPrint(error);
      return;
    }
    debugPrint(result.routes![0].toString());
    /// 所有骑行路线中第一条路线
    BMFDrivingRouteLine firstLine = result.routes![0];
    var routeModel = RidingRouteModel.withModel(firstLine);

    if (_polyline != null) {
      myMapController.removeOverlay(_polyline!.id);
    }

    /// 起点marker
    BMFMarker startMarker = BMFMarker.icon(
      position: routeModel.startNode!.location!,
      title: routeModel.startNode?.title,
      icon: "resoures/icon_start.png",
    );
    myMapController.addMarker(startMarker);
    /// 终点marker
    BMFMarker endMarker = BMFMarker.icon(
      position: routeModel.endNode!.location!,
      title: routeModel.endNode?.title,
      icon: "resoures/icon_end.png",
    );
    myMapController.addMarker(endMarker);

    List<BMFCoordinate> coordinates = [];
    for (BMFDrivingStep? step in firstLine.steps!) {
      if (null == step) {
        continue;
      }
      /// 路线经过的路段坐标点
      if (null != step.points) {
        coordinates.addAll(step.points!);
      }
    }

    /// 添加路线polyline
    _polyline = BMFPolyline(
      coordinates: coordinates,
      indexs: [0],
      textures: ["resoures/traffic_texture_slow.png"],
      dottedLine: false,
    );
    debugPrint("myMapController.addPolyline(_polyline!);");
    myMapController.addPolyline(_polyline!);
  }

  /// 检索结果回调
  void _onGetRidingRouteSearchResult(
      BMFRidingRouteResult result, BMFSearchErrorCode errorCode) {
    if (errorCode != BMFSearchErrorCode.NO_ERROR) {
      var error = "检索失败 errorCode:${errorCode.toString()}";
      debugPrint(error);
      return;
    }

    /// 所有骑行路线中第一条路线
    BMFRidingRouteLine firstLine = result.routes![0];
    var routeModel = RidingRouteModel.withModel(firstLine);

    refresh();
    if (_polyline2 != null) {
      myMapController.removeOverlay(_polyline2!.id);
    }
    /// 移除marker
    myMapController.cleanAllMarkers();

    /// 起点marker
    BMFMarker startMarker = BMFMarker.icon(
      position: routeModel.startNode!.location!,
      title: routeModel.startNode?.title,
      icon: "resoures/icon_start.png",
    );

    myMapController.addMarker(startMarker);

    /// 终点marker
    BMFMarker endMarker = BMFMarker.icon(
      position: routeModel.endNode!.location!,
      title: routeModel.endNode?.title,
      icon: "resoures/icon_end.png",
    );
    myMapController.addMarker(endMarker);

    List<BMFCoordinate> coordinates = [];
    for (BMFRidingStep? step in firstLine.steps!) {
      if (null == step) {
        continue;
      }

      /// 路线经过的路段坐标点
      if (null != step.points) {
        coordinates.addAll(step.points!);
      }
    }

    /// 添加路线polyline
    _polyline2 = BMFPolyline(
      coordinates: coordinates,
      indexs: [0],
      textures: ["resoures/traffic_texture_smooth.png"],
      dottedLine: false,
    );
    myMapController.addPolyline(_polyline2!);

    // /// 根据polyline设置地图显示范围
    // coordinateBounds = getVisibleMapRect(coordinates);
    // myMapController.setVisibleMapRectWithPadding(
    //   visibleMapBounds: coordinateBounds,
    //   insets: EdgeInsets.only(
    //       top: 120.h, bottom: Get.height / 2, left: 20.w, right: 20.w),
    //   animated: true,
    // );
  }



  void handleLocationCallback(BaiduLocation result) {
    //result为定位结果
    if (result.latitude != null && result.longitude != null) {
      location = result;
      /// 更新位置
      uLocation = BMFLocation(
          coordinate: BMFCoordinate(result.latitude!, result.longitude!));
      myMapController.updateLocationData(BMFUserLocation(location: uLocation));

      /// 打开路线规划
      if (homeOrderController.chooseGrab.status == GrabStatus.LOCKED.status ||
          homeOrderController.chooseGrab.status ==
              GrabStatus.AVAILABLE.status) {
        /// 棋手到店铺路线

        drawRoutes(
          from: location,
          to: BaiduLocation(
              latitude: double.parse(
                  homeOrderController.chooseGrab.orders[0].storeLatitude),
              longitude: double.parse(
                  homeOrderController.chooseGrab.orders[0].storeLongitude)),
        );
        /// 绘制商家到订单的路线规划
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          searchStore2User();
          timer.cancel();
        });
      } else if (homeOrderController.chooseGrab.status ==
          GrabStatus.DELIVERING.status) {
        /// 直接绘制棋手到用户的路线
        debugPrint("棋手到店铺路线");
        drawRoutes(
          from: location,
          to: BaiduLocation(
              latitude: double.parse(
                  homeOrderController.chooseGrab.orders[0].userAddressLatitude),
              longitude: double.parse(homeOrderController
                  .chooseGrab.orders[0].userAddressLongitude)),
        );
      }
    }
  }

  @override
  void onClose() {
    myLocPlugin.stopLocation();
    myLocPlugin.stopUpdatingHeading();
    timer.cancel();

    super.onClose();
  }
}
