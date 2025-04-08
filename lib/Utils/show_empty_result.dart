import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/gen/assets.gen.dart';

import 'app_text_style.dart';
import 'global_button.dart';

class ShowEmptyResult extends StatelessWidget {
  const ShowEmptyResult(
      {super.key,
      this.height,
      this.width,
      this.title,
      this.desc,
      this.widget,
      this.refreshOnTap});
  final double? height;
  final double? width;

  final String? title;
  final String? desc;
  final Widget? widget;
  final VoidCallback? refreshOnTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Assets.images.emptyResult.path,
              height: height,
              width: width ?? Get.width,
            ),
            20.height,
            AppTextStyle(
              text: title ?? 'No restaurant found!',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            5.height,
            AppTextStyle(
              text: desc ??
                  'No restaurantsModels found nearby your location. Try exploring a wider area or check again later!',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            refreshOnTap != null
                ? globalButton(
                    height: 35.h,
                    width: 150.w,
                    onTap: refreshOnTap ?? () {},
                    text: "Refresh")
                : 0.height,
            widget != null ? 30.height : 0.width,
            widget ?? 0.width
          ],
        ),
      ),
    );
  }
}
