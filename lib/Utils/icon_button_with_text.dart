import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../gen/colors.gen.dart';
import 'app_text_style.dart';

Widget iconButtonWithText({
  required String text,
  required Function() onPressed,
  Color? iconColor,
  Color? textColor,
  Color? backgroundColor,
  double? width,
  double? height,
  double? borderRadius,
  double? iconSize,
  double? opacity,
  required String icon,
  FontWeight? fontWeight,

}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: height ?? 40,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: ShapeDecoration(
        color: backgroundColor?.withOpacity(opacity ?? 1) ?? ColorName.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
           colorFilter: ColorFilter.mode(iconColor ?? ColorName.appTextBlackColor, BlendMode.srcIn),
            height: iconSize ?? 20,
            width: iconSize ?? 20,
          ),
          SizedBox(width: 5),
          AppTextStyle(
            text: text,
            fontSize: 12,
            fontWeight: fontWeight ?? FontWeight.w500,
            color: textColor,
          ),
        ],
      ),
    ),
  );
}
