import 'dart:io';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:permission_handler/permission_handler.dart';


/// 获取地图显示区域
BMFCoordinateBounds getVisibleMapRect(List<BMFCoordinate> coordinates) {
  BMFCoordinate fisrt = coordinates[0];
  double leftBottomX = fisrt.latitude;
  double leftBottomY = fisrt.longitude;
  double rightTopX = fisrt.latitude;
  double rightTopY = fisrt.longitude;

  for (BMFCoordinate coordinate in coordinates) {
    if (coordinate.latitude < leftBottomX) {
      leftBottomX = coordinate.latitude;
    }

    if (coordinate.longitude < leftBottomY) {
      leftBottomY = coordinate.longitude;
    }

    if (coordinate.latitude > rightTopX) {
      rightTopX = coordinate.latitude;
    }

    if (coordinate.longitude > rightTopY) {
      rightTopY = coordinate.longitude;
    }
  }

  BMFCoordinate leftBottom = BMFCoordinate(leftBottomX, leftBottomY);
  BMFCoordinate rightTop = BMFCoordinate(rightTopX, rightTopY);

  BMFCoordinateBounds coordinateBounds =
  BMFCoordinateBounds(northeast: rightTop, southwest: leftBottom);

  return coordinateBounds;
}

/// 初始化IOS定位选项
BaiduLocationIOSOption initIOSOptions() {
  BaiduLocationIOSOption options = BaiduLocationIOSOption(
    // 坐标系
    coordType: BMFLocationCoordType.bd09ll,
    // 位置获取超时时间
    locationTimeout: 10,
    // 获取地址信息超时时间
    reGeocodeTimeout: 10,
    // 应用位置类型 默认为automotiveNavigation
    activityType: BMFActivityType.automotiveNavigation,
    // 设置预期精度参数 默认为best
    desiredAccuracy: BMFDesiredAccuracy.best,
    // 是否需要最新版本rgc数据
    isNeedNewVersionRgc: true,
    // 指定定位是否会被系统自动暂停
    pausesLocationUpdatesAutomatically: false,
    // 指定是否允许后台定位,
    // 允许的话是可以进行后台定位的，但需要项目
    allowsBackgroundLocationUpdates: false,
    // 设定定位的最小更新距离
    distanceFilter: 10,
  );
  return options;
}

/// 初始化安卓定位选项
BaiduLocationAndroidOption initAndroidOptions() {
  BaiduLocationAndroidOption options = BaiduLocationAndroidOption(
// 定位模式，可选的模式有高精度、仅设备、仅网络。默认为高精度模式
      locationMode: BMFLocationMode.hightAccuracy,
// 是否需要返回地址信息
      isNeedAddress: true,
// 是否需要返回海拔高度信息
      isNeedAltitude: true,
// 是否需要返回周边poi信息
      isNeedLocationPoiList: true,
// 是否需要返回新版本rgc信息
      isNeedNewVersionRgc: true,
// 是否需要返回位置描述信息
      isNeedLocationDescribe: true,
// 是否使用gps
      openGps: true,
// 可选，设置场景定位参数，包括签到场景、运动场景、出行场景
      locationPurpose: BMFLocationPurpose.sport,
// 坐标系
      coordType: BMFLocationCoordType.bd09ll,
// 设置发起定位请求的间隔，int类型，单位ms
// 如果设置为0，则代表单次定位，即仅定位一次，默认为0
      scanspan: 0);
  return options;
}

final LocationFlutterPlugin _myLocPlugin = LocationFlutterPlugin();
/// 开始定位
Future<void> startGetLoc(void Function(BaiduLocation)callback) async {
  Map iosMap = initIOSOptions().getMap();
  Map androidMap = initAndroidOptions().getMap();

  /// 准备定位
  var suc = await _myLocPlugin.prepareLoc(androidMap, iosMap);
  if (Platform.isIOS) {
    //接受定位回调
    _myLocPlugin.singleLocationCallback(callback: callback);
    suc = await _myLocPlugin
        .singleLocation({'isReGeocode': true, 'isNetworkState': true});
  } else if (Platform.isAndroid) {
    //接受定位回调
    _myLocPlugin.seriesLocationCallback(callback: callback);
    suc = await _myLocPlugin.startLocation();
  }
}

/// 关闭定位
Future<void> stopLocation() async {
  var suc = await _myLocPlugin.stopLocation();
}


// 动态申请定位权限
void requestPermission() async {
  // 申请权限
  bool hasLocationPermission = await requestLocationPermission();
  if (hasLocationPermission) {
    // 权限申请通过
  } else {}
}
/// 申请定位权限
/// 授予定位权限返回true， 否则返回false
Future<bool> requestLocationPermission() async {
  //获取当前的权限
  var status = await Permission.location.status;
  if (status == PermissionStatus.granted) {
    //已经授权
    return true;
  } else {
    //未授权则发起一次申请
    status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}

Future<void> initMap() async {
  /// 设置用户是否同意SDK隐私协议
  BMFMapSDK.setAgreePrivacy(true);
  LocationFlutterPlugin myLocPlugin = LocationFlutterPlugin();

  /// since 3.1.0 开发者必须设置
  myLocPlugin.setAgreePrivacy(true);

  // 百度地图sdk初始化鉴权
  if (Platform.isIOS) {
    BMFMapSDK.setApiKeyAndCoordType(
        'bQnRWNogbbOAqZQIsWtTAG5kCd5UDE0Q', BMF_COORD_TYPE.BD09LL);
  } else if (Platform.isAndroid) {
    /// 初始化获取Android 系统版本号
    await BMFAndroidVersion.initAndroidVersion();
    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
  }
  Map? map = await BMFMapVersion.nativeMapVersion;
}




