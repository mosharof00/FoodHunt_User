import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';

import '../gen/colors.gen.dart';
import 'app_text_style.dart';
import 'custom_svg_image.dart';

Widget iconButtonHelper(
    {required VoidCallback onTap,
    required String iconSvg,
    required String text}) {
  return Container(
    height: 35.h,
    width: 120.w,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 1.r, offset: Offset(1.h, 1.w))
        ]),
    child: CupertinoButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customSvgImage(
            imagePath: iconSvg,
            height: 20.h,
            width: 20.w,
            color: ColorName.primaryColor,
          ),
          5.width,
          AppTextStyle(
            text: text,
            fontSize: 13.sp,
            color: Colors.grey.shade600,
          )
        ],
      ),
    ),
  );
}
