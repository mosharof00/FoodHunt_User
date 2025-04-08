import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:food_hunt_user/Helper/helper_utils.dart';
import 'package:food_hunt_user/Utils/app_text_style.dart';
import 'package:food_hunt_user/Utils/cached_image_helper.dart';
import 'package:food_hunt_user/Utils/methods/method_helper.dart';
import 'package:food_hunt_user/Utils/show_empty_result.dart';
import 'package:food_hunt_user/Utils/show_ratings.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/app/modules/home/controllers/home_controller.dart';
import 'package:food_hunt_user/app/routes/app_pages.dart';
import 'package:food_hunt_user/gen/assets.gen.dart';
import 'package:food_hunt_user/gen/colors.gen.dart';

class RestaurantLayout extends StatelessWidget {
  const RestaurantLayout({
    super.key,
    required this.controller,
  });
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return LoadingAnimationWidget.threeArchedCircle(
            color: ColorName.primaryColor, size: 40.sp);
      } else {
        if (controller.nearByRestaurantList.isEmpty) {
          return ShowEmptyResult(
            refreshOnTap: (){
              controller.fetchRestaurants(controller.location.value!);
            },

          );
        } else {
          return ListView.builder(
              itemCount: controller.nearByRestaurantList.length,
              itemBuilder: (_, index) {
                final restaurant = controller.nearByRestaurantList[index];
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.r),
                    onTap: () {
                      Get.toNamed(Routes.RESTAURANT_DETAILS,
                          arguments: restaurant);
                    },
                    child: Container(
                        height: 300.h,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 1.r,
                                  offset: Offset(1, 1))
                            ]),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Expanded(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.r),
                                            topRight: Radius.circular(20.r)),
                                        child: cachedImageWidget(
                                            imgUrl:
                                                restaurant.coverImageUrl ?? '',
                                            width: Get.width))),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AppTextStyle(
                                      text: restaurant.restaurantName!,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    10.height,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                Assets.icons.deliveryCycleIcon),
                                            5.width,
                                            AppTextStyle(
                                              text:
                                                  "${HelperUtils.currencySymbol} ${MethodHelper.getDeliveryCharge(restaurant.distance!)}",
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                Assets.icons.clockFillIcon),
                                            5.width,
                                            AppTextStyle(
                                              text: MethodHelper.getETA(
                                                  distanceInMeters:
                                                      restaurant.distance!,
                                                  eta: restaurant.eta!),
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                Assets.icons.shareFillIcon),
                                            5.width,
                                            AppTextStyle(
                                              text:
                                                  "${restaurant.distance!.floor()} mi",
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    10.height,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _helperContainer(text: 'Burger'),
                                        _helperContainer(text: 'Chicken'),
                                        _helperContainer(text: 'Fast Food'),
                                      ],
                                    ),
                                    10.height
                                  ],
                                ))
                              ],
                            ),
                            Positioned(
                                top: 15.h,
                                left: 10.w,
                                right: 10.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 5.h),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50.r)),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              Assets.icons.discountIconAlt,
                                            ),
                                            5.width,
                                            AppTextStyle(
                                              text:
                                                  "${restaurant.discountValue ?? 0}% off",
                                              fontWeight: FontWeight.w500,
                                            )
                                          ],
                                        )),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 5.h),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50.r)),
                                        child: ShowRatings(
                                            ratings: restaurant.totalRating
                                                .toDouble())),
                                  ],
                                )),
                            Align(
                              alignment: Alignment.center,
                              child: cachedImageWidget(
                                imgUrl: restaurant.profile ?? '',
                                height: 75.h,
                                width: 70.w,
                                borderRadius: 10.r,
                              ),
                            )
                          ],
                        )),
                  ),
                );
              });
        }
      }
    });
  }
}

Widget _helperContainer({
  required String text,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
    decoration: BoxDecoration(
        color: Color(0xFfF6F6F6), borderRadius: BorderRadius.circular(10.r)),
    child: Center(
      child: AppTextStyle(
        text: text,
        color: Colors.grey,
      ),
    ),
  );
}
