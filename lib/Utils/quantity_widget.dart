import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_hunt_user/Utils/app_text_style.dart';
import 'package:food_hunt_user/Utils/custom_icon_button.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/gen/colors.gen.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget(
      {super.key,
      required this.qty,
      required this.minusOnTap,
      required this.plusOnTap, this.iconSize});

  final int qty;
  final VoidCallback minusOnTap;
  final VoidCallback plusOnTap;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconButton(
          onPressed: minusOnTap,
          size: iconSize ?? 30.sp,
          border: Border.all(width: 1.w, color: ColorName.primaryColor),
          backgroundColor: Colors.white,
          icon: Icon(
            Icons.remove,
            color: ColorName.primaryColor,
          ),
        ),
        10.width,
        AppTextStyle(
          text: qty.toString(),
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        10.width,
        CustomIconButton(
          onPressed: plusOnTap,
          size:iconSize?? 30.sp,
          backgroundColor: ColorName.primaryColor,
          border: Border.all(width: 1.w, color: ColorName.primaryColor),
          boxShadow: [
            BoxShadow(
                color: ColorName.primaryColor.withAlpha(100),
                blurRadius: 3.r,
                offset: Offset(2, 5))
          ],
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
