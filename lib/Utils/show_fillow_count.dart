import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_text_style.dart';

Widget showFollowCount({required String title, required String desc}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      AppTextStyle(
        text: title,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      AppTextStyle(
        text: desc,
        fontSize: 12.sp,
        color: Colors.grey,
      ),
    ],
  );
}
