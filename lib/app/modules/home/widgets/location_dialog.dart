import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:food_hunt_user/Utils/loading_action.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';

import '../../../../Utils/global_button.dart';
import '../../../../Utils/global_snackbar.dart';
import '../../../../Utils/input_field_with_label.dart';
import '../../../../gen/colors.gen.dart';

Future locationDialog({
  required BuildContext context,
  required TextEditingController addressEditingController,
  required RxBool isLoading,
  required RxBool isAddressValid,
  required VoidCallback onTap,
  String? okText,
}) async {
  return showDialog(
      context: context,
      builder: (_) {
        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  10.r, // Push up on keyboard open
            ),
            child: Material(
              borderRadius: BorderRadius.circular(20.r),
              child: Padding(
                padding: EdgeInsets.all(10.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() {
                      void updateAddressValidation(String value) {
                        addressEditingController.text = value;
                        isAddressValid.value = value.length >= 15;
                      }

                      return InputFieldWithLabel(
                        controller: addressEditingController,
                        label: "Input your delivery address",
                        keyboardType: TextInputType.text,
                        hintText: 'Enter address',
                        maxLines: 2,
                        onChanged: (value) {
                          updateAddressValidation(value);
                        },
                        errorText: isAddressValid.value
                            ? null
                            : "Address must be at least 15 characters long",
                      );
                    }),
                    20.height,
                    Row(
                      children: [
                        Expanded(
                          child: globalButton(
                            onTap: () {
                              addressEditingController.clear();
                              Get.back();
                            },
                            text: 'Cancel',
                            height: 35.h,
                            fontSize: 14.sp,
                          ),
                        ),
                        10.width,
                        Expanded(
                          child: Obx(() {
                            return isLoading.value
                                ? loadingAction()
                                : globalButton(
                                    color: isAddressValid.value
                                        ? ColorName.primaryColor
                                        : Colors.grey,
                                    onTap: () {
                                      if (isAddressValid.value) {
                                        onTap();
                                      } else {
                                        globalSnackBar(
                                            title: 'Address input invalid!',
                                            message:
                                                'Please enter a valid address.');
                                      }
                                    },
                                    text: okText??'Save and continue',
                                    height: 35.h,
                                    fontSize: 14.sp,
                                  );
                          }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
