import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';

import '../../../../Utils/custom_svg_image.dart';
import '../../../../Utils/global_button.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';

Future<void> selectFileBottomSheet({
  required BuildContext context,
  required VoidCallback cameraOnTap,
  required VoidCallback galleryOnTap,
}) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allows full-screen height if needed
    builder: (context) {
      return Container(
        width: Get.width,
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            globalButton(
              onTap: galleryOnTap,
              text: "Gallery",
              height: 35.h,
              color: Colors.white,
              textColor: Colors.black,
              borderColor: ColorName.primaryColor,
              prefixWidget: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: customSvgImage(
                  imagePath: Assets.icons.galleryFillIcon,
                  color: ColorName.primaryColor,
                  height: 20.h,
                  width: 20.w,
                ),
              ),
            ),
            20.height,
            globalButton(
              onTap: cameraOnTap,
              text: "Camera",
              height: 35.h,
              color: Colors.white,
              textColor: Colors.black,
              borderColor: ColorName.primaryColor,
              prefixWidget: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: customSvgImage(
                  imagePath: Assets.icons.cameraFillIcon,
                  color: ColorName.primaryColor,
                  height: 20.h,
                  width: 20.w,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
