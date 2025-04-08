import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:food_hunt_user/Helper/food_item_greed_layout.dart';
import 'package:food_hunt_user/app/routes/app_pages.dart';

import '../../home/controllers/home_controller.dart';

class GreedView extends StatelessWidget {
  const GreedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
      child: MasonryGridView.count(
          padding: EdgeInsets.zero,
          crossAxisCount: 2,
          mainAxisSpacing: 20.h,
          crossAxisSpacing: 20.w,
          itemCount: Get.find<HomeController>().sampleFoodList.length - 1,
          itemBuilder: (context, index) {
            final foodItem = Get.find<HomeController>()
                .sampleFoodList
                .reversed
                .toList()[index + 1];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 300),
              child: ScaleAnimation(
                  child: FoodItemGreedLayout(
                foodItem: foodItem,
                onTap: () {
                  // Get.toNamed(Routes.FOOD_DETAILS, arguments: foodItem);
                },
              )),
            );
          }),
    );
  }
}
