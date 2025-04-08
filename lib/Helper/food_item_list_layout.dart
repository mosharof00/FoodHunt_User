import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:food_hunt_user/Utils/app_text_style.dart';
import 'package:food_hunt_user/Utils/cached_image_helper.dart';
import 'package:food_hunt_user/Utils/show_ratings.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';

import '../Utils/methods/method_helper.dart';
import '../app/models/restaurantsModels/menu_item_model.dart';
import '../app/modules/restaurant_details/controllers/restaurant_details_controller.dart';
import '../gen/assets.gen.dart';
import '../gen/colors.gen.dart';
import 'helper_utils.dart';

class FoodItemListLayout extends StatelessWidget {
  const FoodItemListLayout(
      {super.key, required this.foodItem, this.onTap, this.padding});
  final MenuItemModel foodItem;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RestaurantDetailsController>();
    return Padding(
      padding: padding ??
          EdgeInsets.only(
            left: 15.w,
            right: 15.w,
            bottom: 10.h,
          ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 120.h,
          width: Get.width,
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1.r,
                    offset: const Offset(1, 1))
              ]),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: cachedImageWidget(
                    imgUrl: foodItem.imageUrl ?? '', borderRadius: 20.r),
              ),
              10.width,
              Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextStyle(
                        text: foodItem.name!,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(Assets.icons.deliveryCycleIcon),
                              5.width,
                              AppTextStyle(
                                text:
                                    "${HelperUtils.currencySymbol} ${MethodHelper.getDeliveryCharge(controller.restaurant.value.distance!)}",
                                color: Colors.grey,
                              )
                            ],
                          ),
                          Container(
                            height: 15.h,
                            width: 1.w,
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            color: Colors.black,
                          ),
                          ShowRatings(
                              ratings: controller.restaurant.value.totalRating!
                                  .toDouble())
                        ],
                      ),
                      Row(
                        children: [
                          AppTextStyle(
                            text: HelperUtils.currencySymbol,
                            color: ColorName.primaryColor,
                          ),
                          AppTextStyle(
                            text: foodItem.basePrice!.toString(),
                          )
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
