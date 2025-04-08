import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:food_hunt_user/Utils/app_text_style.dart';
import 'package:food_hunt_user/Utils/custom_svg_image.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';

import '../../../../Utils/appbar_title.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../controllers/upload_controller.dart';

class UploadView extends GetView<UploadController> {
  const UploadView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Explore'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                Assets.icons.notificationIcon,
              )),
          15.width,
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 30.h,
            crossAxisSpacing: 30.w,
            itemCount: 6,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: ScaleAnimation(
                    child: Container(
                      height: 160.h,
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10.r,
                                spreadRadius: 5.r,
                                offset: Offset(4, 4))
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: AppTextStyle(
                              text: "2/3",
                              color: ColorName.uploadColor,
                            ),
                          ),
                          customSvgImage(
                              imagePath: Assets.icons.uploadFillIcon,
                              color: ColorName.uploadColor,
                              height: 35.h,
                              width: 35.w),
                          AppTextStyle(
                            text: 'Code: QL9',
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                          AppTextStyle(
                            text: 'Receipts & \nGrocery',
                            color: ColorName.uploadColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                    ),
                  ));
            }),
      ),
    );
  }
}
