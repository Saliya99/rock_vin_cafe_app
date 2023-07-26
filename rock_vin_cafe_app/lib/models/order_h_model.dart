class OrderHModel {
  dynamic orderId;
  dynamic uid;
  dynamic quantity;
  dynamic totalPrice;
  dynamic status;
  dynamic pickupTime;
  dynamic foodId;
  dynamic foodName;
  dynamic foodPrice;
  dynamic foodImg;

  OrderHModel({
    required this.orderId,
    required this.uid,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    required this.pickupTime,
    required this.foodId,
    required this.foodName,
    required this.foodPrice,
    required this.foodImg,
  });

  factory OrderHModel.fromMap(Map<String, dynamic> map) {
    return OrderHModel(
      orderId: map['orderid'],
      uid: map['uid'],
      quantity: map['quantity'],
      totalPrice: map['totalprice'],
      status: map['status'],
      pickupTime: (map['picup_time']),
      foodId: map['food_id'],
      foodName: map['food_name'],
      foodPrice: map['food_price'],
      foodImg: map['food_img'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderid': orderId,
      'uid': uid,
      'quantity': quantity,
      'totalprice': totalPrice,
      'status': status,
      'picup_time': pickupTime,
      'food_id': foodId,
      'food_name': foodName,
      'food_price': foodPrice,
      'food_img': foodImg,
    };
  }

  String tableColumns() {
    return 'orderid, uid, quantity, totalprice, status, picup_time, food_id, food_name, food_price, food_img';
  }
}
