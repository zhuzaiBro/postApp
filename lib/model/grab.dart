import 'package:json_annotation/json_annotation.dart';
import 'order.dart';

part 'grab.g.dart';

// Map<String, String> mapDeliveryInfo = {
//   "AVAILABLE": "抢单",
//   "LOCKED": "我已取货",
//   "DELIVERING": "我已送达",
//   "COMPLETED": "订单已完成"
// };

enum GrabStatus{
  AVAILABLE(status: "AVAILABLE", name: "抢单"),
  LOCKED(status: "LOCKED", name: "我已取货"),
  DELIVERING(status: "DELIVERING", name: "我已送达"),
  COMPLETED(status: "COMPLETED", name: "订单已完成");

  final String status;
  final String name;

  const GrabStatus({required this.status, required this.name});

  static getName(String status) {
    switch(status) {
      case "AVAILABLE":
        return GrabStatus.AVAILABLE.name;
      case "LOCKED":
        return GrabStatus.LOCKED.name;
      case "DELIVERING":
        return GrabStatus.DELIVERING.name;
      case "COMPLETED":
        return GrabStatus.COMPLETED.name;
      default:
        return GrabStatus.AVAILABLE.name;
    }
  }
}


@JsonSerializable(explicitToJson: true)
class Grab {
  int id;
  String name;
  double brokerage;
  String status;
  List<Order> orders;

  Grab({
      required this.id,
      required this.name,
      required this.brokerage,
      required this.status,
      required this.orders,
      });

  factory Grab.fromJson( Map<String, dynamic> json) => _$GrabFromJson(json);

  Map<String, dynamic> toJson() => _$GrabToJson(this);
}
