class FoodModel {
  String foodId;
  String foodName;
  double foodPrice;
  String foodImg;
  String foodDesc;
  String foodCategory;

  FoodModel({
    required this.foodId,
    required this.foodName,
    required this.foodPrice,
    required this.foodImg,
    required this.foodDesc,
    required this.foodCategory,
  });

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      foodId: map['food_id'] as String,
      foodName: map['food_name'] as String,
      foodPrice: double.parse(map['food_price'] as String),
      foodImg: map['food_img'] as String,
      foodDesc: map['food_desc'] as String,
      foodCategory: map['food_cat_id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'food_id': foodId,
      'food_name': foodName,
      'food_price': foodPrice.toString(),
      'food_img': foodImg,
      'food_desc': foodDesc,
      'food_cat_id': foodCategory,
    };
  }

  List<dynamic> dataToList() {
    return [
      foodId,
      foodName,
      foodPrice,
      foodImg,
      foodDesc,
      foodCategory,
    ];
  }

  // String tableColumns() {
  //   return 'food_id, food_name, food_price, food_img, food_desc,foodCategory';
  // }
}
