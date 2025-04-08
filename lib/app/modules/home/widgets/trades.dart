import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:food_hunt_user/Utils/app_text_style_over_flow.dart';
import 'package:food_hunt_user/Utils/custom_icon_button.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/app/modules/home/controllers/home_controller.dart';
import 'package:food_hunt_user/gen/colors.gen.dart';

import '../../../../Helper/helper_utils.dart';
import '../../../../Utils/app_text_style.dart';
import '../../../../Utils/cached_image_helper.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';

class Trades extends StatelessWidget {
  const Trades({super.key});

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
                  height: 270.h,
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
                              flex: 6,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(20.r)),
                                  child: cachedImageWidget(
                                      imgUrl: foodItem.imageUrl!,
                                      width: Get.width))),
                          Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        cachedImageWidget(
                                          imgUrl: foodItem.sellerImageUrl!,
                                          height: 45.h,
                                          width: 45.w,
                                          borderRadius: 10.r,
                                        ),
                                        10.width,
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppTextStyleOverFlow(
                                                maxLines: 1,
                                                text: foodItem.name!,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              Row(
                                                children: [
                                                  AppTextStyle(
                                                    text:
                                                        "${foodItem.sellerName} | ${foodItem.availableQuantity}/${foodItem.quantity}",
                                                    fontSize: 11.sp,
                                                    color: Colors.grey,
                                                  ),
                                                  5.width,
                                                  Expanded(
                                                    child: AppTextStyleOverFlow(
                                                      text: (foodItem
                                                                  .quantity !=
                                                              foodItem
                                                                  .availableQuantity)
                                                          ? 'Available'
                                                          : 'Not Available',
                                                      maxLines: 1,
                                                      fontSize: 11.sp,
                                                      color: ColorName
                                                          .primaryColor,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6.w, vertical: 3.h),
                                            decoration: BoxDecoration(
                                                color: Color(0xFfF6F6F6),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.r)),
                                            child: Row(
                                              children: [
                                                AppTextStyle(
                                                  text: foodItem.rating!
                                                      .toString(),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                5.width,
                                                SvgPicture.asset(
                                                  Assets.icons.starIcon,
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
                                    10.height,
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
                          right: 10.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        Assets.icons.coinsIcon,
                                        height: 18.h,
                                        width: 18.w,
                                      ),
                                      5.width,
                                      AppTextStyle(
                                        text: "${10} +Swap",
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  )),
                              CustomIconButton(
                                size: 34.sp,
                                backgroundColor: Colors.white,
                                icon: SvgPicture.asset(Assets.icons.chatsIcon),
                              )
                            ],
                          )),
                    ],
                  )),
            ),
          );
        });
  }
}
