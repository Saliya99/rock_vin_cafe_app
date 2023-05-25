import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rock_vin_cafe_app/data/repository/popular_product_repo.dart';
import 'package:rock_vin_cafe_app/models/products_model.dart';
import 'package:rock_vin_cafe_app/utils/colors.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity=>_quantity;
  int _inCartItems=0;
  int get inCartItems=>_inCartItems+_quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("got products");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductList);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      print("Incremented");
      _quantity = checkQuantity(_quantity+1);
    }else{
      _quantity = checkQuantity(_quantity-1);
      print("Decremented");
    }
    update();
  }
  int checkQuantity(int quantity){
    if (quantity <0){
      Get.snackbar("Item Count", "You can't reduce more !",
          backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 0;
    }else if(quantity>20){
      Get.snackbar("Item Count", "You can't add more !",
      backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
      );
      return 20;
    }else{
      return quantity;
    }
  }

  void initProduct(){
    _quantity=0;
    _inCartItems=0;
    //if exist
    //get from storage _inCartItems=3
  }
}
