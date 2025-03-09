class OrderStatusModel {
  final String orderNumber;
  final String orderDetail;
  final String estimatedTime;
  final String status;

  OrderStatusModel({
    required this.orderNumber,
    required this.orderDetail,
    required this.estimatedTime,
    required this.status,
  });
}
// statuslist[Random().nextInt(3)],