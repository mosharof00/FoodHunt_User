import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:food_hunt_user/Utils/app_text_style_over_flow.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/Utils/view_rating_stars.dart';
import 'package:food_hunt_user/app/modules/home/controllers/home_controller.dart';
import 'package:food_hunt_user/gen/colors.gen.dart';

import '../../../../Helper/helper_utils.dart';
import '../../../../Utils/app_text_style.dart';
import '../../../../Utils/cached_image_helper.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';

class Following extends StatelessWidget {
  const Following({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return ListView.builder(
        itemCount: controller.sampleFoodList.length,
        itemBuilder: (_, index) {
          final foodItem = controller.sampleFoodList[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: InkWell(
              borderRadius: BorderRadius.circular(20.r),
              onTap: () {
                Get.toNamed(Routes.USER_PROFILE, arguments: foodItem);
              },
              child: Container(
                  height: 375.h,
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
                              flex: 5,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(20.r)),
                                  child: cachedImageWidget(
                                      imgUrl: foodItem.imageUrl!,
                                      width: Get.width))),
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        cachedImageWidget(
                                          imgUrl: foodItem.sellerImageUrl!,
                                          height: 35.h,
                                          width: 35.w,
                                          borderRadius: 10.r,
                                        ),
                                        10.width,
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: AppTextStyleOverFlow(
                                                      maxLines: 1,
                                                      text: foodItem.name!,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 6.w,
                                                              vertical: 3.h),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFfF6F6F6),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.r)),
                                                      child: Row(
                                                        children: [
                                                          AppTextStyle(
                                                            text: foodItem
                                                                .rating!
                                                                .toString(),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          5.width,
                                                          SvgPicture.asset(
                                                            Assets
                                                                .icons.starIcon,
                                                          ),
                                                          5.width,
                                                          AppTextStyle(
                                                            text:
                                                                "(${foodItem.numberOfRatings!})",
                                                            color: Colors.grey,
                                                          )
                                                        ],
                                                      )),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  AppTextStyle(
                                                    text: "Reviewed by:",
                                                    fontSize: 10.sp,
                                                    color: Colors.grey,
                                                  ),
                                                  5.width,
                                                  AppTextStyleOverFlow(
                                                    text: foodItem.sellerName!,
                                                    color:
                                                        ColorName.primaryColor,
                                                    fontSize: 13.sp,
                                                  ),
                                                ],
                                              ),
                                              ViewRatingStars(
                                                rating: 4,
                                                starSize: 15.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    AppTextStyle(
                                      text:
                                          'Try our new launched pizza and get 20% off',
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                Assets.icons.deliveryCycleIcon),
                                            5.width,
                                            AppTextStyle(
                                              text:
                                                  "${HelperUtils.currencySymbol} ${foodItem.price}",
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
                                              text: "${foodItem.duration}",
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
                                              text: "${foodItem.distance} mi",
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                      Positioned(
                        top: 15.h,
                        left: 10.w,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50.r)),
                            child: Row(
                              children: [
                                AppTextStyle(
                                  text: HelperUtils.currencySymbol,
                                  fontWeight: FontWeight.w500,
                                  color: ColorName.primaryColor,
                                ),
                                3.width,
                                AppTextStyle(
                                  text: foodItem.price!.toString(),
                                  fontWeight: FontWeight.w500,
                                )
                              ],
                            )),
                      ),
                    ],
                  )),
            ),
          );
        });
  }
}
