import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_hunt_user/Utils/custom_icon_button.dart';
import 'package:food_hunt_user/Utils/custom_svg_image.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/app/modules/user_profile/widgets/greed_view.dart';
import 'package:food_hunt_user/gen/assets.gen.dart';
import 'package:food_hunt_user/gen/colors.gen.dart';

import '../../../../Utils/app_text_style.dart';
import '../../../../Utils/cached_image_helper.dart';
import '../../../../Utils/icon_button_helper.dart';
import '../../../../Utils/show_fillow_count.dart';
import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final user = controller.user.value;
    return Scaffold(
        backgroundColor: ColorName.bgColor,
        body: DefaultTabController(
            length: 4,
            child: NestedScrollView(
              headerSliverBuilder: (_, __) {
                return [
                  SliverAppBar(
                    floating: true,
                    pinned: true,
                    snap: true,
                    expandedHeight: 400.h, // Height of the expanded AppBar
                    automaticallyImplyLeading: false,
                    backgroundColor: ColorName.bgColor,
                    surfaceTintColor: ColorName.white,
                    title: Padding(
                      padding: EdgeInsets.only(bottom: 3.h),
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
                      child: TabBar(
                        isScrollable: false,
                        dividerColor: Colors.transparent,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.label,
                        tabAlignment: TabAlignment.center,
                        indicatorColor: Colors.black,
                        indicatorWeight: 1,
                        tabs: [
                          Tab(
                              child: Text("Restaurants",
                                  style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500))),
                          Tab(
                              child: Text("Trades",
                                  style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500))),
                          Tab(
                              child: Text("Offers",
                                  style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500))),
                          Tab(
                              child: Text("Reviews",
                                  style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500))),
                        ],
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Stack(
                        children: [
                          Column(
                            children: [
                              cachedImageWidget(
                                imgUrl: user.imageUrl!,
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
                                height: 275.h,
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
                                          imgUrl: user.sellerImageUrl!,
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
                                              text: user.restaurantName!,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            AppTextStyle(
                                              text: '@ ${user.sellerName}',
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
                  )
                ];
              },
              body: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.tabController,
                  children: const [
                    GreedView(),
                    GreedView(),
                    GreedView(),
                    GreedView(),
                  ]),
            )));
  }
}
