import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_hunt_user/Utils/app_text_style.dart';
import 'package:food_hunt_user/Utils/cached_image_helper.dart';
import 'package:food_hunt_user/Utils/custom_icon_button.dart';
import 'package:food_hunt_user/Utils/custom_svg_image.dart';
import 'package:food_hunt_user/Utils/shimmer_loading.dart';
import 'package:food_hunt_user/Utils/show_empty_result.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/gen/assets.gen.dart';
import 'package:food_hunt_user/gen/colors.gen.dart';

import '../../../../Helper/helper_utils.dart';
import '../../../../Utils/icon_button_helper.dart';
import '../../../../Utils/methods/method_helper.dart';
import '../../../../Utils/show_fillow_count.dart';
import '../controllers/restaurant_details_controller.dart';
import '../widgets/all_list.dart';

class RestaurantDetailsView extends GetView<RestaurantDetailsController> {
  const RestaurantDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final restaurant = controller.restaurant.value;
    return Scaffold(
        backgroundColor: ColorName.bgColor,
        body: NestedScrollView(
            controller: controller.scrollController,
            headerSliverBuilder: (_, __) {
              return [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  snap: true,
                  expandedHeight: 440.h, // Height of the expanded AppBar
                  automaticallyImplyLeading: false,
                  backgroundColor: ColorName.bgColor,
                  surfaceTintColor: ColorName.white,

                  title: Padding(
                    padding: EdgeInsets.only(bottom: 3.h, top: 10.h),
                    child: Row(
                      children: [
                        CustomIconButton(
                          icon: customSvgImage(
                            imagePath: Assets.icons.arrowBackIcon,
                          ),
                        ),
                        const Spacer(),
                        CustomIconButton(
                          icon: customSvgImage(
                              imagePath: Assets.icons.uploadFillIcon,
                              height: 24.h,
                              width: 24.w,
                              color: ColorName.primaryColor),
                        ),
                        10.width,
                        CustomIconButton(
                          icon: customSvgImage(
                              imagePath: Assets.icons.shareRightArrowIcon,
                              height: 24.h,
                              width: 24.w,
                              color: ColorName.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  bottom: PreferredSize(
                      preferredSize: Size.fromHeight(80.h),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Obx(() {
                          if (controller.isLoading.value) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: 50.h, left: 15.w, right: 15.w),
                              child: shimmerLoadingWidget(
                                height: 30.h,
                                width: Get.width,
                                borderRadius: 10.r,
                              ),
                            );
                          } else if (controller.menuItems.isEmpty) {
                            return SizedBox(
                              height: 40.h,
                              width: Get.width,
                            );
                          } else {
                            return TabBar(
                                controller: controller.tabController,
                                isScrollable: true,
                                dividerColor: Colors.transparent,
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.grey,
                                indicatorSize: TabBarIndicatorSize.label,
                                tabAlignment: TabAlignment.center,
                                indicatorColor: Colors.black,
                                indicatorWeight: 1,
                                tabs: [
                                  ...List.generate(
                                      controller.menuTabBarList.length,
                                      (index) {
                                    return Tab(
                                        child: Text(
                                            controller
                                                .menuTabBarList[index].name!,
                                            style: GoogleFonts.outfit(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500)));
                                  })
                                ]);
                          }
                        }),
                      )),
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Stack(
                      children: [
                        Column(
                          children: [
                            cachedImageWidget(
                              imgUrl: restaurant.coverImageUrl ?? '',
                              height: 190.h,
                              width: Get.width,
                            ),
                          ],
                        ),
                        Positioned(
                            bottom: 10.h,
                            left: 0.w,
                            right: 0.w,
                            child: Container(
                              height: 305.h,
                              width: Get.width,
                              margin: EdgeInsets.only(
                                  left: 15.w, right: 15.w, bottom: 40.h),
                              padding: EdgeInsets.all(15.r),
                              decoration: BoxDecoration(
                                  color: ColorName.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 1.r,
                                        offset: const Offset(1, 1))
                                  ]),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      cachedImageWidget(
                                        imgUrl: restaurant.profile ?? '',
                                        height: 50.h,
                                        width: 50.w,
                                        borderRadius: 8.r,
                                      ),
                                      10.width,
                                      Expanded(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppTextStyle(
                                            text: restaurant.restaurantName!,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          AppTextStyle(
                                            text:
                                                '@ ${restaurant.restaurantName}',
                                            color: Colors.grey,
                                            fontSize: 12.sp,
                                          )
                                        ],
                                      )),
                                      IconButton(
                                        onPressed: () {},
                                        icon: SvgPicture.asset(
                                            Assets.icons.editIcon),
                                      )
                                    ],
                                  ),
                                  10.height,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      showFollowCount(
                                          title: '290', desc: 'Orders'),
                                      showFollowCount(
                                          title: '1.2M', desc: 'Followers'),
                                      showFollowCount(
                                          title: '249', desc: 'Referrals'),
                                    ],
                                  ),
                                  5.height,
                                  Divider(
                                    color: Colors.grey.shade300,
                                  ),
                                  AppTextStyle(
                                    text:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                                    textAlign: TextAlign.center,
                                    fontSize: 12.sp,
                                    color: Colors.grey,
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
                                              Assets.icons.starIcon),
                                          5.width,
                                          AppTextStyle(
                                            text: restaurant.totalRating!
                                                .toString(),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  10.height,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      iconButtonHelper(
                                          onTap: () {},
                                          iconSvg: Assets.icons.userPlusIcon,
                                          text: 'Follow'),
                                      iconButtonHelper(
                                          onTap: () {},
                                          iconSvg: Assets.icons.chatsIcon,
                                          text: 'Message'),
                                    ],
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Obx(() {
              if (controller.isLoading.value) {
                return shimmerLoadingListVerticalWidget(
                    height: 100.h,
                    width: Get.width,
                    padding:
                        EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.h));
              } else if (controller.menuItems.isEmpty) {
                return ShowEmptyResult(
                  height: 150.h,
                  title: 'No menu found of the restaurant',
                  desc: '',
                );
              } else {
                return TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller.tabController,
                    children: [
                      ...List.generate(controller.menuTabBarViewList.length,
                          (index) {
                        final foodItemList =
                            controller.menuTabBarViewList[index];
                        return ItemList(
                          foodItemList: foodItemList,
                        );
                      })
                    ]);
              }
            })));
  }
}
