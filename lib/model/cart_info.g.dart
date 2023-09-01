// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartInfo _$CartInfoFromJson(Map<String, dynamic> json) => CartInfo(
      cartInfoMap:
          CartInfoMap.fromJson(json['cartInfoMap'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartInfoToJson(CartInfo instance) => <String, dynamic>{
      'cartInfoMap': instance.cartInfoMap.toJson(),
    };

CartInfoMap _$CartInfoMapFromJson(Map<String, dynamic> json) => CartInfoMap(
      productId: json['productId'] as int,
      seckillId: json['seckillId'] as int,
      vipTruePrice: (json['vipTruePrice'] as num).toDouble(),
      combinationId: json['combinationId'] as int,
      costPrice: (json['costPrice'] as num).toDouble(),
      trueStock: json['trueStock'] as int,
      truePrice: (json['truePrice'] as num).toDouble(),
      type: json['type'] as String,
      cartNum: json['cartNum'] as int,
      productInfo:
          ProductInfo.fromJson(json['productInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartInfoMapToJson(CartInfoMap instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'seckillId': instance.seckillId,
      'vipTruePrice': instance.vipTruePrice,
      'combinationId': instance.combinationId,
      'costPrice': instance.costPrice,
      'trueStock': instance.trueStock,
      'truePrice': instance.truePrice,
      'type': instance.type,
      'cartNum': instance.cartNum,
      'productInfo': instance.productInfo.toJson(),
    };

ProductInfo _$ProductInfoFromJson(Map<String, dynamic> json) => ProductInfo(
      specType: json['specType'] as int,
      isIntegral: json['isIntegral'] as int,
      otPrice: (json['otPrice'] as num).toDouble(),
      userCollect: json['userCollect'] as bool,
      isPostage: json['isPostage'] as int,
      isSub: json['isSub'] as int,
      sales: json['sales'] as int,
      integral: (json['integral'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      vipPrice: (json['vipPrice'] as num).toDouble(),
      storeName: json['storeName'] as String,
      id: json['id'] as int,
      keyword: json['keyword'] as String,
      image: json['image'] as String,
      cost: (json['cost'] as num).toDouble(),
      unitName: json['unitName'] as String,
    );

Map<String, dynamic> _$ProductInfoToJson(ProductInfo instance) =>
    <String, dynamic>{
      'specType': instance.specType,
      'isIntegral': instance.isIntegral,
      'otPrice': instance.otPrice,
      'userCollect': instance.userCollect,
      'isPostage': instance.isPostage,
      'isSub': instance.isSub,
      'sales': instance.sales,
      'integral': instance.integral,
      'price': instance.price,
      'vipPrice': instance.vipPrice,
      'storeName': instance.storeName,
      'id': instance.id,
      'keyword': instance.keyword,
      'image': instance.image,
      'cost': instance.cost,
      'unitName': instance.unitName,
    };
