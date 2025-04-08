import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_text_style.dart';

Widget simpleButton({
  required String text,
  required Function() onPressed,
  Color? textColor,
  Color? backgroundColor,
  double? width,
  double? height,
  double? borderRadius,
  FontWeight? fontWeight,
}) {
  return CupertinoButton(
    onPressed: onPressed,
    child: Container(
      height: height ?? 40.h,
      width: width?.h,
      decoration: BoxDecoration(
        color: backgroundColor ?? Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
      ),
      child: Center(
        child: AppTextStyle(text: text, fontSize: 16, fontWeight: FontWeight.w500, color: textColor ?? Color(0xFF000000)
        ),
      ),
    ),
  );
}