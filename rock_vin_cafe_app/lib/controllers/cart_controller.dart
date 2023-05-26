import 'package:get/get.dart';
import 'package:rock_vin_cafe_app/models/products_model.dart';
import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};

  void addItem(ProductModel product, int quantity) {
    //print("length of the item is " + _items.length.toString());
    if (quantity > 0) {
      _items.putIfAbsent(product.id!, () {
        print("adding item to the cart id " +
            product.id!.toString() +
            quantity.toString());

        _items.forEach((key, Value) {
          print("quantity is " + Value.quantity.toString());
        });
        return CartModel(
          id: product.id,
          name: product.name,
          price: product.price,
          img: product.img,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
        );
      });
    }
  }
}
