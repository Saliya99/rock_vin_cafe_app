class FoodModel {
  String foodId;
  String foodName;
  double foodPrice;
  String foodImg;
  String foodDesc;
  DateTime createdAt;
  DateTime updatedAt;

  FoodModel({
    required this.foodId,
    required this.foodName,
    required this.foodPrice,
    required this.foodImg,
    required this.foodDesc,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      foodId: map['food_id'] as String,
      foodName: map['food_name'] as String,
      foodPrice: double.parse(map['food_price'] as String),
      foodImg: map['food_img'] as String,
      foodDesc: map['food_desc'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'food_id': foodId,
      'food_name': foodName,
      'food_price': foodPrice.toString(),
      'food_img': foodImg,
      'food_desc': foodDesc,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  List<dynamic> dataToList() {
    return [
      foodId,
      foodName,
      foodPrice,
      foodImg,
      foodDesc,
      createdAt,
      updatedAt
    ];
  }

  String tableColumns() {
    return 'food_id, food_name, food_price, food_img, food_desc, createdAt, updatedAt';
  }
}
