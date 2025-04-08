import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_hunt_user/Utils/custom_icons.dart';

List<TabItem> navItems = [
  TabItem(
    icon: CustomIcons.homeIcon,
    title: "Home".tr,
  ),
  TabItem(
    icon: CustomIcons.exploreIcon,
    title: 'Explore'.tr,
  ),
  TabItem(
    icon: CustomIcons.shoppingBagIcon,
    title: 'Cart'.tr,
  ),
  TabItem(
    icon: CustomIcons.uploadIcon,
    title: 'Upload'.tr,
  ),
  TabItem(
    icon: CustomIcons.settingsIcon,
    title: 'Settings'.tr,
  ),
];
