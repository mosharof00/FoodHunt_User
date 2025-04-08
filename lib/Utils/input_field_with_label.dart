import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../gen/colors.gen.dart';
import 'app_text_style.dart';

class InputFieldWithLabel extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final String? suffixText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? errorText;

  const InputFieldWithLabel({
    super.key,
    required this.label,
    this.hintText,
    required this.keyboardType,
    this.maxLines = 1,
    this.suffixText,
    this.controller,
    this.onChanged,
    this.errorText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextStyle(
          text: label,
          fontSize: 15,
          color: ColorName.appTextGrayColor,
          fontWeight: FontWeight.w300,
        ),
        SizedBox(height: 5.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: GoogleFonts.outfit(
            textStyle: TextStyle(
              color: ColorName.black,
              fontSize: 18,
            ),
          ),
          onChanged: onChanged,
          decoration: InputDecoration(
            errorText: errorText,
            suffixText: suffixText,
            suffixStyle: GoogleFonts.outfit(
              textStyle: TextStyle(
                color: ColorName.appTextGrayColor,
                fontSize: 18,
              ),
            ),
            hintText: hintText ?? '',
            filled: true,
            fillColor: ColorName.white,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorName.appTextGrayColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorName.gray70),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorName.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
