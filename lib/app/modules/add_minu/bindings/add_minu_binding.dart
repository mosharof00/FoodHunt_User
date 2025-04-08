import 'package:get/get.dart';

import '../controllers/add_minu_controller.dart';

class AddMinuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddMinuController>(
      () => AddMinuController(),
    );
  }
}
