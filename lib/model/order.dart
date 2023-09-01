

import 'package:json_annotation/json_annotation.dart';

import 'cart_info.dart';


part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {

 String createTime;      //: "2023-05-30 22:14:42",
 String? updateTime;      //: null,
 int id;      //: 27,
 int grabId;      //: 16,
 String orderId;     //: "1663549362178883584",
 int orderPrimaryId;      //: 492,
 int storeId;     //: 3,
 String storeName;     //: "馋喵农专营店",
 String storePhone;      //: "15024359582",
 String storeAddress;      //: "浙江省嘉兴市长水街道塘桥路",
 String storeLatitude;     //: "30.73316",
 String storeLongitude;      //: "120.805801",
 int uid;     //: 195,
 String userPhone;     //: "18268109673",
 String userAddress;     //: "浙江省 嘉兴市 南湖区 罗马都市东区-西2门",
 String userAddressLatitude;     //: "30.74720",
 String userAddressLongitude;      //: "120.7931",
 String deliveryStatus;      //: "NOT_STARTED",
 int? deliveryUid;     //: null,
 int? deliveryAt;      //: null,
 int? deliveryFinished;      //: null
 String realName;
 String? mark;
 List<CartInfo> cartInfo;

  Order({
    required this.createTime,      //: "2023-05-30 22:14:42",
    required this.updateTime,      //: null,
    required this.id,      //: 27,
    required this.grabId,      //: 16,
    required this.orderId,     //: "1663549362178883584",
    required this.orderPrimaryId,      //: 492,
    required this.storeId,     //: 3,
    required this.storeName,     //: "馋喵农专营店",
    required this.storePhone,      //: "15024359582",
    required this.storeAddress,      //: "浙江省嘉兴市长水街道塘桥路",
    required this.storeLatitude,     //: "30.73316",
    required this.storeLongitude,      //: "120.805801",
    required this.uid,     //: 195,
    required this.userPhone,     //: "18268109673",
    required this.userAddress,     //: "浙江省 嘉兴市 南湖区 罗马都市东区-西2门",
    required this.userAddressLatitude,     //: "30.74720",
    required this.userAddressLongitude,      //: "120.7931",
    required this.deliveryStatus,      //: "NOT_STARTED",
    required this.deliveryUid,     //: null,
    required this.deliveryAt,      //: null,
    required this.deliveryFinished,
    required this.realName,
    required this.cartInfo,
    required this.mark,
  });

 factory Order.fromJson( Map<String, dynamic> json) => _$OrderFromJson(json);

 Map<String, dynamic> toJson() => _$OrderToJson(this);
}