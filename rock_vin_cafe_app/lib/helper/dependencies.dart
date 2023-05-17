import 'package:get/get.dart';
import 'package:rock_vin_cafe_app/controllers/popular_product_controller.dart';
import 'package:rock_vin_cafe_app/data/repository/popular_product_repo.dart';

import '../data/api/api_client.dart';

Future<void> init() async {
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: "https://mvs.bslmeiyu.com"));

  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

  //controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
}
