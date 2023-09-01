
import 'package:json_annotation/json_annotation.dart';

part 'cart_info.g.dart';

@JsonSerializable(explicitToJson: true)
class CartInfo {

  CartInfoMap cartInfoMap;


  CartInfo({required this.cartInfoMap});

  factory CartInfo.fromJson( Map<String, dynamic> json) => _$CartInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CartInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CartInfoMap {

  int productId;   // : 6,
  int seckillId;   // : 0,
  double vipTruePrice;   // : 32.98,
  int combinationId;   // : 0,
  double costPrice;   // : 22,
  int trueStock;   // : 9987,
  double truePrice;   // : 32.98,
  String type;   // : "fresh",
  int cartNum;   // : 1,
  ProductInfo productInfo;

  CartInfoMap({
    required this.productId,
    required this.seckillId,
    required this.vipTruePrice,
    required this.combinationId,
    required this.costPrice,
    required this.trueStock,
    required this.truePrice,
    required this.type,
    required this.cartNum,
    required this.productInfo,
});

  factory CartInfoMap.fromJson( Map<String, dynamic> json) => _$CartInfoMapFromJson(json);

  Map<String, dynamic> toJson() => _$CartInfoMapToJson(this);
}



@JsonSerializable(explicitToJson: true)
class ProductInfo {
  int specType;   //": 0,
  int isIntegral;   //": 0,
  double otPrice;   //": 11,
  bool userCollect;   //": false,
  int isPostage;   //": 0,
  int isSub;   //": 0,
  int sales;   //": 56,
  double integral;   //": 0,
  double price;   //": 32.98,
  double vipPrice;   //": 0,
  String storeName;   //": "王店三元土鸡 1.5kg/只",
  int id;   //": 6,
  String keyword;   //": "现杀拔毛",
  String image;   //": "https://cdn.discosoul.com.cn/farm-130939706349c3c370487b45fb95a38fc71bdf067f.png",
  double cost;   //": 22,
  String unitName;   //": "只",
  ProductInfo({
    required this.specType,
    required this.isIntegral,
    required this.otPrice,
    required this.userCollect,
    required this.isPostage,
    required this.isSub,
    required this.sales,
    required this.integral,
    required this.price,
    required this.vipPrice,
    required this.storeName,
    required this.id,
    required this.keyword,
    required this.image,
    required this.cost,
    required this.unitName,
});

  factory ProductInfo.fromJson( Map<String, dynamic> json) => _$ProductInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductInfoToJson(this);
}