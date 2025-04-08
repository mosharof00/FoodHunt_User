import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_text_style.dart';

Widget showStatus({required String status}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
    decoration: BoxDecoration(
      color: status == 'Active'
          ? Colors.yellow.withAlpha(50)
          : Colors.green.withAlpha(50),
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: AppTextStyle(
      text: status,
      color: status == 'Active' ? Colors.yellow : Colors.green,
      fontSize: 13.sp,
      fontWeight: FontWeight.w500,
    ),
  );
}
