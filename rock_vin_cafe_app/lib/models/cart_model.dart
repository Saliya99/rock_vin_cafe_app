class CartModel {
  int cartId;
  String uid;
  int quantity;
  double totalPrice;
  int foodId;
  String foodName;
  double foodPrice;
  String foodImg;

  CartModel({
    required this.cartId,
    required this.uid,
    required this.quantity,
    required this.totalPrice,
    required this.foodId,
    required this.foodName,
    required this.foodPrice,
    required this.foodImg,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      cartId: int.parse(map['cartid'] as String),
      uid: map['uid'] as String,
      quantity: int.parse(map['quantity'] as String),
      totalPrice: double.parse(map['totalprice'] as String),
      foodId: int.parse(map['food_id'] as String),
      foodName: map['food_name'] as String,
      foodPrice: double.parse(map['food_price'] as String),
      foodImg: map['food_img'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cartid': cartId.toString(),
      'uid': uid,
      'quantity': quantity.toString(),
      'totalprice': totalPrice.toString(),
      'food_id': foodId.toString(),
      'food_name': foodName,
      'food_price': foodPrice.toString(),
      'food_img': foodImg,
    };
  }

  List<dynamic> dataToList() {
    return [
      cartId,
      uid,
      quantity,
      totalPrice,
      foodId,
      foodName,
      foodPrice,
    ];
  }

  String tableColumns() {
    return 'cartid, uid, quantity, totalprice, food_id, food_name, food_price, food_img';
  }
}
