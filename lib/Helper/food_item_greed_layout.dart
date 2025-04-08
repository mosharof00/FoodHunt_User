import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_hunt_user/Utils/app_text_style.dart';
import 'package:food_hunt_user/Utils/app_text_style_over_flow.dart';
import 'package:food_hunt_user/Utils/cached_image_helper.dart';
import 'package:food_hunt_user/Utils/custom_svg_image.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/app/models/static_food_model.dart';
import 'package:food_hunt_user/gen/colors.gen.dart';

import '../gen/assets.gen.dart';

class FoodItemGreedLayout extends StatelessWidget {
  const FoodItemGreedLayout(
      {super.key, required this.foodItem, this.onTap, this.padding});
  final FoodStaticModel foodItem;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15.r),
        child: Container(
          height: 230.h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
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
                      flex: 7,
                      child: cachedImageWidget(
                          imgUrl: foodItem.imageUrl!, borderRadius: 15.r)),
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              cachedImageWidget(
                                  imgUrl: foodItem.sellerImageUrl!,
                                  height: 26.h,
                                  width: 26.w,
                                  borderRadius: 5.r),
                              5.width,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppTextStyleOverFlow(
                                      text: foodItem.name!,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      maxLines: 1,
                                    ),
                                    AppTextStyleOverFlow(
                                      text: foodItem.sellerName!,
                                      color: Colors.grey,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
              Positioned(
                  bottom: 55.h,
                  left: 10.w,
                  right: 10.w,
                  child: Container(
                    height: 50.h,
                    padding: EdgeInsets.all(5.r),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 1.r,
                              offset: Offset(1, 1))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            AppTextStyle(
                              text: foodItem.rating!.toString(),
                              fontWeight: FontWeight.w500,
                              fontSize: 10.sp,
                            ),
                            SvgPicture.asset(
                              Assets.icons.starIcon,
                            ),
                            AppTextStyle(
                              text: "(${foodItem.numberOfRatings!})",
                              color: Colors.grey,
                              fontSize: 10.sp,
                            ),
                            Spacer(),
                            AppTextStyle(
                              text: 'Dist: ',
                              fontWeight: FontWeight.w400,
                              fontSize: 9.sp,
                            ),
                            AppTextStyle(
                              text: "${foodItem.distance} mi",
                              color: Colors.grey,
                              fontSize: 9.sp,
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                          height: 0.7.h,
                        ),
                        Material(
                          color: Colors.white,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5.r),
                            onTap: () {},
                            child: Row(
                              // mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customSvgImage(
                                  imagePath: Assets.icons.shoppingBagIcon,
                                  color: ColorName.primaryColor,
                                  height: 10.h,
                                  width: 10.w,
                                ),
                                3.width,
                                AppTextStyle(
                                  text: 'Add to cart',
                                  fontSize: 10.sp,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
