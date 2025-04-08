import 'package:get/get.dart';

import '../controllers/get_coin_controller.dart';

class GetCoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetCoinController>(
      () => GetCoinController(),
    );
  }
}
