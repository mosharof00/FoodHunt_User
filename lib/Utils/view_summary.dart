import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Helper/helper_utils.dart';
import 'app_text_style.dart';

Widget viewSummary(
    {required String title, required String amount, String? icon}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      AppTextStyle(
        text: title,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      AppTextStyle(
        text: "${icon ?? ''} ${HelperUtils.currencySymbol}$amount",
        fontSize: 18.sp,
      )
    ],
  );
}
