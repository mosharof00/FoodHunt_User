import 'package:get/get.dart';
import 'package:food_hunt_user/app/models/restaurantsModels/menu_item_model.dart';

import '../../../../Helper/logger.dart';

class FoodDetailsController extends GetxController {
  //TODO: Implement FoodDetailsController

  final food = MenuItemModel().obs;
  final isWishListed = false.obs;
  final selectedQty = 1.obs;
  final riceOnSize = 0.0.obs;
  final basePriceOnSize = 0.0.obs;
  final additionalItemsPrice = 0.0.obs;
  final totalAmount = 0.0.obs;

  ///    for sizes

  final sizeList = <Map<String, dynamic>>[].obs;
  final selectedSize = <String, dynamic>{}.obs;

  final selectedSizeIndex = 0.obs;

  ///    for Additional Items
  final selectedAdditionalItems = <AddOn>[].obs;

  void getTotal() {
    basePriceOnSize.value = 0.0;
    basePriceOnSize.value = sizeList.isNotEmpty
        ? selectedSize.values.first.toDouble()
        : food.value.basePrice!.toDouble();

    double itemPrice = basePriceOnSize.value * selectedQty.value;

    additionalItemsPrice.value = 0.0;
    if (selectedAdditionalItems.isNotEmpty) {
      for (var item in selectedAdditionalItems) {
        additionalItemsPrice.value = additionalItemsPrice.value + item.price!;
      }
    }
    totalAmount.value = 0.0;
    totalAmount.value = itemPrice + additionalItemsPrice.value;
  }

  @override
  void onInit() async {
    super.onInit(); // Call super.onInit() first

    if (Get.arguments != null) {
      food.value = Get.arguments['food'];
      food.value.sizePrices!.forEach((key, value) {
        sizeList.add({key: value});
        Log.w("$key   $value");
      });
    }
    await Future.delayed(Duration(seconds: 1));
    selectedSize.value = sizeList[selectedSizeIndex.value];
    getTotal();
  }
}
