import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:food_hunt_user/Utils/custom_icon_button.dart';

import '../gen/colors.gen.dart';

Widget topBarRoundStack(
     {required void Function() onPressed,bool? isShowButton = false}
) {
  return Stack(
    children: [
      Positioned(
        right: -60.w,
        top: -60.h,
        child: Container(
          height: 150.h,
          width: 150.w,
          decoration: BoxDecoration(
            color: ColorName.onPrimary,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      Positioned(
        left: -90.w,
        top: -80.h,
        child: Container(
          height: 180.h,
          width: 150.w,
          decoration: BoxDecoration(
            color: ColorName.white,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Container(
            height: 100.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: ColorName.onPrimary,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),
      Positioned(
        left: 5.w,
        top: -80.h,
        child: Container(
          height: 150.h,
          width: 160.w,
          decoration: BoxDecoration(
            color: ColorName.whitePaste,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      Positioned(
        left: 20.w,
        top: 50.h,
        child:isShowButton == false?SizedBox.shrink(): CustomIconButton(
          size: 50.sp,
          onPressed: onPressed,
        )
      ),
    ],
  );
}
