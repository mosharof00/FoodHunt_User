import 'package:get/get.dart';

import '../controllers/review_and_trip_controller.dart';

class ReviewAndTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewAndTripController>(
      () => ReviewAndTripController(),
    );
  }
}
