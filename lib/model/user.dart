import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  int uid; //": 35,
  String username; //": "15024359582",
   bool checkStatus; //": false,
   String realName;//": "",

   String nickname;//": "汪汪",
   String avatar;//": "https://cdn.discosoul.com.cn/farm-1309397063c63aa871cf38453688062178e6f2e858.jpg",
   String phone; //": "15024359582",
   String addIp; //": "172.17.0.2",
   String lastIp; //": "172.17.0.2",
   double nowMoney; //": 1001.07,
   double brokeragePrice; //": 2,
   bool status; //": true,
   String userType; //": "routine",
   int payCount; //": 143,
   int spreadCount; //": 2,
   String addres; //": "",

   String loginType; //": "",


  User( {

    required this.uid, //": 35,
    required this.username, //": "15024359582",

    required this.checkStatus, //": false,
    required this.realName, //": "",

    required this.nickname, //": "汪汪",
    required this.avatar, //": "https://cdn.discosoul.com.cn/farm-1309397063c63aa871cf38453688062178e6f2e858.jpg",
    required this.phone, //": "15024359582",
    required this.addIp, //": "172.17.0.2",
    required this.lastIp, //": "172.17.0.2",
    required this.nowMoney, //": 1001.07,
    required this.brokeragePrice, //": 2,
    required this.status, //": true,
    required this.userType, //": "routine",
    required this.payCount, //": 143,
    required this.spreadCount, //": 2,
    required this.addres, //": "",
    required this.loginType, //":

  }
      );

  factory User.fromJson( Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

