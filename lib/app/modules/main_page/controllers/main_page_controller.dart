import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_hunt_user/app/modules/cart/views/cart_view.dart';
import 'package:food_hunt_user/app/modules/explore/views/explore_view.dart';
import 'package:food_hunt_user/app/modules/settings/views/settings_view.dart';
import 'package:food_hunt_user/app/modules/upload/views/upload_view.dart';

import '../../home/views/home_view.dart';

class MainPageController extends GetxController {
  //TODO: Implement MainPageController
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final count = 0.obs;
  final selectedTab = 0.obs;
  List pageList = [
    const HomeView(),
    const ExploreView(),
    const CartView(),
    const UploadView(),
    const SettingsView(),
  ];

  changeTab(int index) {
    selectedTab.value = index;
  }

}
