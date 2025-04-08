import 'package:food_hunt_user/app/models/restaurantsModels/menu_item_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  //TODO: Implement CartController

  final cartList = <CartModel>[].obs;
  final total = 0.0.obs;
  final subTotal = 0.0.obs;
  final serviceCharge = 1.00;

  void updateCartItemQuantity(int index, int newQuantity) {
    if (index >= 0 && index < cartList.length) {
      final updatedItem = CartModel(
          id: cartList[index].id,
          imageUrl: cartList[index].imageUrl,
          name: cartList[index].name,
          basePrice: cartList[index].basePrice,
          additionalItemsPrice: cartList[index].additionalItemsPrice,
          totalPrice: (cartList[index].basePrice * newQuantity) +
              cartList[index].additionalItemsPrice,
          qty: newQuantity,
          sizes: cartList[index].sizes,
          additionalItems: cartList[index].additionalItems);
      cartList[index] = updatedItem;
      calculateTotal();
    }
  }

  void calculateTotal() {
    subTotal.value = 0.0;
    for (var item in cartList) {
      subTotal.value = subTotal.value + item.totalPrice;
    }
    total.value = 0.0;
    total.value = subTotal.value + serviceCharge;
  }
}

class CartModel {
  CartModel({
    required this.id,
     this.imageUrl,
    required this.name,
    required this.basePrice,
    required this.additionalItemsPrice,
    required this.totalPrice,
    required this.qty,
    this.additionalItems,
    this.sizes,
  });
  final String id;
  final String? imageUrl;
  final String name;
  final double basePrice;
  final double additionalItemsPrice;
  final double totalPrice;
  final int qty;
  final Map<String, dynamic>? sizes;
  final List<AddOn>? additionalItems;
}
