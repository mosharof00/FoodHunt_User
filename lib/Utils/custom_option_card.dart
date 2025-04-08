import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_hunt_user/gen/colors.gen.dart';

import 'app_text_style.dart';

Widget customOptionCard(
    {required String title,
    Color? color,
    Color? iconColor,
    required String icon,
    required Function onTap}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
    child: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        onTap();
      },
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(30),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                icon,
                height: 25.h,
                width: 25.w,
                colorFilter: ColorFilter.mode(
                    iconColor ?? ColorName.primaryColor, BlendMode.srcIn),
              ),
            ),
            AppTextStyle(
                text: title, fontSize: 16, fontWeight: FontWeight.w500),
          ],
        ),
      ),
    ),
  );
}
