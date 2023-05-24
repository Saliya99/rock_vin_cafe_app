import 'package:get/get.dart';
import 'package:rock_vin_cafe_app/data/api/api_client.dart';
import 'package:rock_vin_cafe_app/utils/app_constants.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});
  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED__PRODUCT_URI);
  }
}
