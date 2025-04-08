import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';

import '../../../../Utils/custom_icon_button.dart';
import '../../../../Utils/custom_svg_image.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';

class BottomTextField extends StatelessWidget {
  const BottomTextField({
    super.key,
    required this.textEditingController,
    this.suffixIcon,
    required this.sendOnTap,
  });

  final TextEditingController textEditingController;
  final Widget? suffixIcon;
  final VoidCallback sendOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end, // Align with bottom
      children: [
        Expanded(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: 120.h, // Limit max expansion height
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: TextFormField(
              controller: textEditingController,
              keyboardType: TextInputType.multiline,
              maxLines: null, // Allow auto expansion
              style: GoogleFonts.outfit(
                textStyle: const TextStyle(
                  color: ColorName.black,
                  fontSize: 16,
                ),
              ),
              decoration: InputDecoration(
                hintText: "Type your message",
                hintStyle: GoogleFonts.outfit(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
                border: InputBorder.none, // Remove default border
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        ),
        10.width,
        CustomIconButton(
          onPressed: sendOnTap,
          size: 45.sp,
          backgroundColor: ColorName.primaryColor,
          icon: customSvgImage(
            imagePath: Assets.icons.sendUpArrowIcon,
            color: Colors.white,
            height: 24.h,
            width: 26.w,
          ),
        ),
      ],
    );
  }
}
