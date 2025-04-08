import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../gen/colors.gen.dart';
import 'app_text_style.dart';

class PasswordInputFieldWithLabel extends StatefulWidget {
  final String label;
  final String? hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final String? suffixText;
  final bool isPassword;
  TextEditingController? controller = TextEditingController();

   PasswordInputFieldWithLabel({
    super.key,
    required this.label,
    this.hintText,
    required this.keyboardType,
    this.maxLines = 1,
    this.suffixText,
    this.isPassword = false,
     this.controller,
  });

  @override
  State<PasswordInputFieldWithLabel> createState() => _InputFieldWithLabelState();
}

class _InputFieldWithLabelState extends State<PasswordInputFieldWithLabel> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextStyle(
          text: widget.label,
          fontSize: 15,
          color: ColorName.appTextGrayColor,
          fontWeight: FontWeight.w300,
        ),
        SizedBox(height: 5.h),
        TextField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          obscureText: widget.isPassword ? _obscureText : false,
          style: GoogleFonts.outfit(
            textStyle: const TextStyle(
              color: ColorName.black,
              fontSize: 18,
            ),
          ),
          decoration: InputDecoration(
            suffixText: widget.suffixText,
            suffixStyle: GoogleFonts.outfit(
              textStyle: const TextStyle(
                color: ColorName.appTextGrayColor,
                fontSize: 18,
              ),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(

                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: ColorName.gray410.withOpacity(0.4),
                size: 20.sp,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
                : null,
            hintText: widget.hintText ?? '',
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
