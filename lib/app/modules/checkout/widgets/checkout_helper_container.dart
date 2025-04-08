import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';

import '../../../../Utils/global_divider.dart';

Widget checkoutHelperContainer({required Widget title, required Widget child}) {
  return Container(
    width: Get.width,
    padding: EdgeInsets.all(10.r),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [title, 10.height, globalDivider(), 10.height, child],
    ),
  );
}
