import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_text_style.dart';

Widget buttonWithIcon({
  required String text,
  required Function() onPressed,
  Color? textColor,
  Color? backgroundColor,
  double? width,
  double? height,
  double? borderRadius,
  FontWeight? fontWeight,
  required String icon,
  required Color iconColor,
  double? iconWidth,
  double? iconHeight,
}) {
  return CupertinoButton(
    onPressed: onPressed,
    child: Container(
      height: height ?? 40,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor ?? Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: SvgPicture.asset(icon,
                height: iconHeight ?? 20.h,
                width: iconWidth ?? 20.w,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTextStyle(
                text: text,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor ?? Color(0xFF000000)),
          ),
        ],
      ),
    ),
  );
}
