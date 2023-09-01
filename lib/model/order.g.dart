// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      createTime: json['createTime'] as String,
      updateTime: json['updateTime'] as String?,
      id: json['id'] as int,
      grabId: json['grabId'] as int,
      orderId: json['orderId'] as String,
      orderPrimaryId: json['orderPrimaryId'] as int,
      storeId: json['storeId'] as int,
      storeName: json['storeName'] as String,
      storePhone: json['storePhone'] as String,
      storeAddress: json['storeAddress'] as String,
      storeLatitude: json['storeLatitude'] as String,
      storeLongitude: json['storeLongitude'] as String,
      uid: json['uid'] as int,
      userPhone: json['userPhone'] as String,
      userAddress: json['userAddress'] as String,
      userAddressLatitude: json['userAddressLatitude'] as String,
      userAddressLongitude: json['userAddressLongitude'] as String,
      deliveryStatus: json['deliveryStatus'] as String,
      deliveryUid: json['deliveryUid'] as int?,
      deliveryAt: json['deliveryAt'] as int?,
      deliveryFinished: json['deliveryFinished'] as int?,
      realName: json['realName'] as String,
      mark: json['mark'] as String?,
      cartInfo: (json['cartInfo'] as List<dynamic>)
          .map((e) => CartInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'id': instance.id,
      'grabId': instance.grabId,
      'orderId': instance.orderId,
      'orderPrimaryId': instance.orderPrimaryId,
      'storeId': instance.storeId,
      'storeName': instance.storeName,
      'storePhone': instance.storePhone,
      'storeAddress': instance.storeAddress,
      'storeLatitude': instance.storeLatitude,
      'storeLongitude': instance.storeLongitude,
      'uid': instance.uid,
      'userPhone': instance.userPhone,
      'userAddress': instance.userAddress,
      'userAddressLatitude': instance.userAddressLatitude,
      'userAddressLongitude': instance.userAddressLongitude,
      'deliveryStatus': instance.deliveryStatus,
      'deliveryUid': instance.deliveryUid,
      'deliveryAt': instance.deliveryAt,
      'deliveryFinished': instance.deliveryFinished,
      'cartInfo': instance.cartInfo.map((e) => e.toJson()).toList(),
    };
