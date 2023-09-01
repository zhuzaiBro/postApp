import 'package:flutter/cupertino.dart';
import 'package:post_app/api/order.dart';
import 'package:post_app/model/base_data.dart';
import 'package:post_app/pages/login/model/user_controller.dart';
import 'package:get/get.dart';
import 'package:post_app/model/grab.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';

import '../../../utils/dialog.dart';

class HomeOrderController extends GetxController {

  final userController = Get.put(UserController());

  BaseData<Grab> availableGrabs = BaseData();
  BaseData<Grab> myGrabs = BaseData();
  BaseData<Grab> deliveringGrabs = BaseData();

  Grab chooseGrab = Grab(id: 0, name: "", brokerage: 0.00, status: "", orders: []);

  bool isFetching = false;

  RxInt currentIndex = 0.obs;
  PageController pageController = PageController();


  @override
  void onReady() {
    fetchAvailableData();
    fetchMyGrabs();
    super.onReady();
  }


  Future<void> fetchAvailableData() async {
    if(!availableGrabs.isMore!) {
      return;
    }
    isFetching = true;
    var res = await getAvailableGrab(availableGrabs.page!, availableGrabs.size!);
    availableGrabs.handleData(res.list, res.total);
    isFetching = false;
    refresh();
  }

  Future<void> fetchMyGrabs() async {
    if(!availableGrabs.isMore!) {
      return;
    }
    isFetching = true;
    var res = await getMyGrab(availableGrabs.page!, availableGrabs.size!);

    List<Grab> locked = [];
    List<Grab> delivery = [];

    res.forEach((grab) {
      switch(grab.status) {
        case "COMPLETED":
          break;
        case "LOCKED":

          locked.add(grab);
          break;
        case "DELIVERING":
          delivery.add(grab);
          break;
      }
    });
    myGrabs.handleData(locked, locked.length);
    deliveringGrabs.handleData(delivery, delivery.length);
    isFetching = false;
    refresh();
  }

  void setChooseGrab(Grab grab) {
    chooseGrab = grab;
    refresh();
  }

  BMFCoordinate buildBMFCoordinateFromOrder() {
    return BMFCoordinate(double.parse(chooseGrab.orders[0].userAddressLatitude), double.parse(chooseGrab.orders[0].userAddressLongitude));
  }

  /// 处理配送
  void handleSendBtnPres() {
    var status = chooseGrab.status;
    if (status == GrabStatus.AVAILABLE.status) {
      defaultDialog(() {
        getGrab(chooseGrab.id).then((value) {
          chooseGrab.status = GrabStatus.DELIVERING.status;
          fetchAvailableData();
          fetchMyGrabs();
          refresh();
          Get.back();
        });
      }, "接单", "确定接受该订单吗？");
    } else if (status == GrabStatus.LOCKED.status) {
      defaultDialog(() {
        startGrab([chooseGrab.orders[0].orderId])
            .then((value) {
          chooseGrab.status = GrabStatus.DELIVERING.status;
          fetchAvailableData();
          fetchMyGrabs();
          refresh();
          Get.back();
        });
      }, "确认取货", "确认已经取到货物");
    } else if (status == GrabStatus.DELIVERING.status) {
      defaultDialog(() {
        finishGrab([chooseGrab.orders[0].orderId])
            .then((value) {
          chooseGrab.status = GrabStatus.COMPLETED.status;
          fetchAvailableData();
          fetchMyGrabs();
          refresh();
          Get.back();
        });
      }, "确认送达", "确认你已送达");
    }
  }
}