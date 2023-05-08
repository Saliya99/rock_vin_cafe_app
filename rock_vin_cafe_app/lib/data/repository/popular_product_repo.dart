import 'package:get/get.dart';
import 'package:rock_vin_cafe_app/data/api/api_client.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});
  Future<Response> getPopularProductList ()async{
    return await apiClient.getData("ed point url");

  }
}