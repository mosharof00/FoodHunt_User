import 'package:get/get.dart';

import '../../../../models/order_model.dart';

class OrderDetailsController extends GetxController {
  //TODO: Implement OrderDetailsController

  late Order order;
  @override
  void onInit() {
    if (Get.arguments != null) {
      order = Get.arguments;
    }
    super.onInit();
  }
}
