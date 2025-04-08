import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../Utils/custom_bottom_navbar.dart';
import '../../../../gen/colors.gen.dart';
import '../controllers/main_page_controller.dart';

class MainPageView extends GetView<MainPageController> {
  const MainPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(
              () => BottomBarDefault(
            items: navItems,
            backgroundColor: Colors.white,
            color: Colors.grey,
            colorSelected: ColorName.primaryColor,
            indexSelected: controller.selectedTab.value,
            top: 15,
            paddingVertical: 20,
            iconSize: 26,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              topLeft: Radius.circular(20.r),
            ),
            // highlightStyle: const HighlightStyle(
            //     sizeLarge: true, isHexagon: true, elevation: 6),
            onTap: (index) => controller.changeTab(index),
          ),
        ),
        body: Obx(() => controller.pageList[controller.selectedTab.value])
    );
  }
}
