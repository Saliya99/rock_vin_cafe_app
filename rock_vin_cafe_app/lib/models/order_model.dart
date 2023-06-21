class OrderModel {
  String uid;
  int foodId;
  int quantity;
  double totalPrice;
  int status;
  DateTime pickupTime;
  String orderFrom;

  OrderModel({
    required this.uid,
    required this.foodId,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    required this.pickupTime,
    required this.orderFrom,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      uid: map['uid'] as String,
      foodId: map['foodid'] as int,
      quantity: map['quantity'] as int,
      totalPrice: map['totalprice'] as double,
      status: map['status'] as int,
      pickupTime: DateTime.parse(map['picup_time'] as String),
      orderFrom: map['order_from'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'foodid': foodId,
      'quantity': quantity,
      'totalprice': totalPrice,
      'status': status,
      'picup_time': pickupTime.toIso8601String(),
      'order_from': 'm',
    };
  }

  String tableColumns() {
    return 'uid, foodid, quantity, totalprice, status, picup_time, order_from';
  }
}
