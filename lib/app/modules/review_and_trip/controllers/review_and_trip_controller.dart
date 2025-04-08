import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/order_model.dart';
import '../../my_orders/controllers/my_orders_controller.dart';

class ReviewAndTripController extends GetxController {
  //TODO: Implement ReviewAndTripController

  final tipsEditingController = TextEditingController();
  late Order order;

  var selectedRating = 0.0.obs;
  final selectedTipsIndex = 0.obs;
  final tipsAmount = 2.obs;

  void updateRating(double rating) {
    selectedRating.value = rating;
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      order = Get.arguments;
    }
    super.onInit();
  }
}
