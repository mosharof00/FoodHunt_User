import 'package:get/get.dart';

import '../controllers/restaurant_details_controller.dart';

class RestaurantDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestaurantDetailsController>(
      () => RestaurantDetailsController(),
    );
  }
}
