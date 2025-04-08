import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';


import '../../../../Utils/app_text_style.dart';

class SelectedFileValidation extends StatelessWidget {
  const SelectedFileValidation(
      {super.key,
      required this.selectedFile,
      required this.errorTitle,
      this.height,
      this.width,
      this.onTap,
      this.unSelectedWidget});
  final Rxn<XFile?> selectedFile;
  final String errorTitle;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final Widget? unSelectedWidget;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor:Colors.transparent,
      onTap: onTap,
      child: Obx(
        () => selectedFile.value == null
            ? Column(
                children: [
                  unSelectedWidget ?? SizedBox.shrink(),
                  AppTextStyle(
                    text: errorTitle,
                    color: Colors.red.shade800,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              )
            : Align(
                alignment: Alignment.center,
                child: Container(
                  height: height ?? 100.h,
                  width: width ?? 130.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(
                            File(
                              selectedFile.value!.path,
                            ),
                          ))),
                ),
              ),
      ),
    );
  }
}
