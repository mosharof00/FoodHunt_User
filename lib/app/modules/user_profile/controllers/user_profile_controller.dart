import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/static_food_model.dart';

class UserProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement RestaurantDetailsController

  final ScrollController scrollController = ScrollController();

  final user = FoodStaticModel().obs;

  /// Tab
  late TabController tabController;
  RxInt selectedTabIndex = 0.obs;
  void updateSelectedTab(int index) {
    selectedTabIndex.value = tabController.index;
    tabController.animateTo(tabController.index);
    update();
    // if (selectedTabIndex.value == 1 &&
    //     isWithdrawRequestInitializing.value == 100) {
    //   fetchWithdrawRequestList();
    // }
  }

  @override
  void onInit() {
    tabController = TabController(
      length: 4,
      vsync: this,
    );
    if (Get.arguments != null) {
      user.value = Get.arguments;
    }

    super.onInit();
  }
}
