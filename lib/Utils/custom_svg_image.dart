import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../gen/colors.gen.dart';

Widget customSvgImage(
    {required String imagePath, Color? color, double? height, double? width}) {
  return SvgPicture.asset(
    imagePath,
    height: height ?? 15.h,
    width: width ?? 15.w,
    colorFilter: ColorFilter.mode(color ?? ColorName.black, BlendMode.srcIn),
  );
}
