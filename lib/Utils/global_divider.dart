import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget globalDivider({double? height, Color? color}) {
  return Divider(
    height: height ?? 1.h,
    color: color ?? Colors.grey.shade300,
  );
}
