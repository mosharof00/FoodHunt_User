import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../gen/colors.gen.dart';

class AppInputTextFormField extends StatelessWidget {
  const AppInputTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.expands,
    this.labelText,
    this.validator,
    this.autoValidateMode,
    this.obscureText,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.enabled,
    this.readOnly,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.onTap,
    this.onSaved,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.textInputAction,
    this.focusNode,
    this.autofocus,
    this.contentPadding,
    this.fillColor,
    this.cursorColor,
    this.borderColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.disabledBorderColor,
    this.errorBorderColor,
    this.errorTextColor,
    this.hintTextColor,
    this.labelTextColor,
    this.textColor,
    this.fontSize,
    this.borderWidth,
    this.borderRadius,
    this.height,
    this.width,
    this.suffix,
    this.prefix,
    this.fontWeight,
    this.errorFontWeight,
    this.errorFontSize,
    this.inputFormatters,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final bool? enabled;
  final bool? readOnly;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final void Function(String?)? onChanged;
  final void Function()? onTap;
  final void Function(String?)? onSaved;
  final void Function()? onEditingComplete;
  final void Function(String?)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool? autofocus;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Color? cursorColor;
  final Color? borderColor;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? disabledBorderColor;
  final Color? errorBorderColor;
  final Color? errorTextColor;
  final Color? hintTextColor;
  final Color? labelTextColor;
  final Color? textColor;
  final double? fontSize;
  final double? borderWidth;
  final double? borderRadius;
  final double? height;
  final double? width;
  final bool? expands;
  final FontWeight? fontWeight;
  final FontWeight? errorFontWeight;
  final double? errorFontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48.h, // Consistent height
      width: width,
      child: TextFormField(
        expands: expands ?? false,
        key: key,
        maxLines: maxLines ?? 1,
        minLines: minLines ?? 1,
        controller: controller,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        autovalidateMode:
        autoValidateMode ?? AutovalidateMode.onUserInteraction,
        enabled: enabled ?? true,
        readOnly: readOnly ?? false,
        maxLength: maxLength,
        onChanged: onChanged,
        onTap: onTap,
        onSaved: onSaved,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,

        focusNode: focusNode,
        autofocus: autofocus ?? false,
        cursorColor: cursorColor ?? ColorName.primaryColor,
        style: GoogleFonts.manrope(
          textStyle: TextStyle(
            color: textColor ?? ColorName.wrongAns,
            fontSize: fontSize ?? 14.sp,
            fontWeight: fontWeight ?? FontWeight.w400,
          ),
        ),
        decoration: InputDecoration(
          isDense: true, // Reduces extra space
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          fillColor: fillColor ?? Colors.white,
          filled: true,
          hintText: hintText?.tr ?? "",
          hintStyle: GoogleFonts.manrope(
            textStyle: TextStyle(
              color: hintTextColor ?? Colors.grey,
              fontSize: fontSize ?? 13.sp,
              fontWeight: fontWeight ?? FontWeight.w400,
            ),
          ),
          labelText: labelText,
          labelStyle: GoogleFonts.manrope(
            textStyle: TextStyle(
              color: labelTextColor ?? Colors.black,
              fontSize: fontSize ?? 14.sp,
              fontWeight: fontWeight ?? FontWeight.w400,
            ),
          ),
          prefixIcon: prefixIcon,
          prefixIconConstraints: BoxConstraints(
            minWidth: 40.w,
            minHeight: 40.h,
          ),
          suffixIcon: suffixIcon,
          suffixIconConstraints: BoxConstraints(
            minWidth: 40.w,
            minHeight: 40.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            borderSide: BorderSide(
              color: borderColor ?? Colors.grey.shade200,
              width: borderWidth ?? 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            borderSide: BorderSide(
              color: enabledBorderColor ?? Colors.grey.shade200,
              width: borderWidth ?? 1,
            ),
          ),
          disabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            borderSide: BorderSide(
              color: disabledBorderColor ?? Colors.grey.shade200,
              width: borderWidth ?? 1,
            ),
          ) ,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            borderSide: BorderSide(
              color: focusedBorderColor ?? ColorName.primaryColor,
              width: borderWidth ?? 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            borderSide: BorderSide(
              color: errorBorderColor ?? ColorName.wrongAns,
              width: borderWidth ?? 1,
            ),
          ),
        ),
      ),
    );
  }
}