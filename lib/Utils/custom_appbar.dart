import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../gen/colors.gen.dart';
import 'app_text_style.dart';

Widget customAppBar({required String title}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    titleSpacing: 0,

    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 10.w,

        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: ColorName.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: ColorName.gray70,
                blurRadius: 5,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: ColorName.appTextBlackColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        SizedBox(width: 20.w),
        AppTextStyle(
          text: title,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ],
    ),
  );
}