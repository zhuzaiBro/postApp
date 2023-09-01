// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      uid: json['uid'] as int,
      username: json['username'] as String,
      checkStatus: json['checkStatus'] as bool,
      realName: json['realName'] as String,
      nickname: json['nickname'] as String,
      avatar: json['avatar'] as String,
      phone: json['phone'] as String,
      addIp: json['addIp'] as String,
      lastIp: json['lastIp'] as String,
      nowMoney: (json['nowMoney'] as num).toDouble(),
      brokeragePrice: (json['brokeragePrice'] as num).toDouble(),
      status: json['status'] as bool,
      userType: json['userType'] as String,
      payCount: json['payCount'] as int,
      spreadCount: json['spreadCount'] as int,
      addres: json['addres'] as String,
      loginType: json['loginType'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'checkStatus': instance.checkStatus,
      'realName': instance.realName,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'addIp': instance.addIp,
      'lastIp': instance.lastIp,
      'nowMoney': instance.nowMoney,
      'brokeragePrice': instance.brokeragePrice,
      'status': instance.status,
      'userType': instance.userType,
      'payCount': instance.payCount,
      'spreadCount': instance.spreadCount,
      'addres': instance.addres,
      'loginType': instance.loginType,
    };
