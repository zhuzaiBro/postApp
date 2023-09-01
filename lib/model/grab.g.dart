// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grab.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grab _$GrabFromJson(Map<String, dynamic> json) => Grab(
      id: json['id'] as int,
      name: json['name'] as String,
      brokerage: (json['brokerage'] as num).toDouble(),
      status: json['status'] as String,
      orders: (json['orders'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GrabToJson(Grab instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'brokerage': instance.brokerage,
      'status': instance.status,
      'orders': instance.orders.map((e) => e.toJson()).toList(),
    };
