import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:post_app/model/grab.dart';
import 'package:post_app/utils/request.dart';

import 'data_list.dart';


Future<DataList<Grab>> getAvailableGrab (int page, size) async {

  var res = await (request()).get("/mall/app/delivery-grab/available?page=$page&size=$size");

  var list = res.data['data']['content'] as List<dynamic>;

  return DataList(list: list.map((e) => Grab.fromJson(e)).toList(), total: res.data['data']['totalElements']);

}

/// 查询我的抢单
Future<List<Grab>> getMyGrab(int page, size) async {

  var res = await (request()).get("/mall/app/delivery-grab?page=$page&size=$size");

  var list = res.data['data'] as List<dynamic>;

   return list.map((e) => Grab.fromJson(e)).toList();
}
/// 查询配送中的订单
Future<DataList<Grab>> getDeliveringGrab(int page, size) async {

  var res = await (request()).get("/shop/mall/delivering-order?page=$page&size=$size");

  var list = res.data['data']['content'] as List<dynamic>;

  return DataList(list: list.map((e) => Grab.fromJson(e)).toList(), total: res.data['data']['totalElements']);
}

/// 配送员抢单开始配送
Future<void> getGrab(int id) async {

  var res = await request().post("/mall/app/delivery-grab/grab/$id");

  debugPrint(res.data.toString());
  //
}

/// 配送员到达商铺
Future<void> startGrab ( List<String> ids) async {

  var res = await request().post("/mall/fresh-order/start-delivering", data: ids,);
  debugPrint("${res.data.toString()}res.toString()");

}

Future<void> finishGrab(List<String> ids) async {

    var res = await request().post("/mall/fresh-order/delivery-arrived", data: ids);

    debugPrint(res.toString());

}

