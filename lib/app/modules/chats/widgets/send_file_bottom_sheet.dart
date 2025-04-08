import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/app/modules/chats/widgets/select_file_bottom_sheet.dart';

import '../../../../Utils/app_text_style.dart';
import '../../../../Utils/custom_svg_image.dart';
import '../../../../Utils/global_divider.dart';
import '../../../../Utils/global_snackbar.dart';
import '../../../../Utils/methods/pick_files.dart';
import '../../../../Utils/selected_file_validation.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/chats_controller.dart';
import 'bottom_text_field.dart';

Future<void> sendFileBottomSheet() async {
  final controller = Get.put(ChatsController());
  return showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(20.r),
        child: Container(
            width: Get.width,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  topRight: Radius.circular(15.r),
                )),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTextStyle(
                    text: "Select a file",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  10.height,
                  globalDivider(height: 0.5),
                  10.height,
                  SelectedFileValidation(
                    height: 200.h,
                    width: Get.width,
                    selectedFile: controller.selectedXFile,
                    errorTitle: 'File is not selected',
                    unSelectedWidget: Container(
                      height: 200.h,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 50.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  20.height,
                  BottomTextField(
                    textEditingController: controller.textController,
                    sendOnTap: () {
                      if (controller.textController.text.isNotEmpty ||
                          controller.selectedXFile.value != null) {
                        controller.sendMessage(
                          senderId: controller.sender.id!,
                          receiverId: controller.receiverId,
                          message: controller.textController.text,
                          file: controller.selectedXFile.value,
                        );
                        controller.textController.clear();
                        controller.selectedXFile.value = null;
                        Get.back();
                      } else {
                        globalSnackBar(
                            title: "Empty message!",
                            message: "Please enter a message and try again");
                      }
                    },
                    suffixIcon: CupertinoButton(
                      onPressed: () {
                        selectFileBottomSheet(
                          context: context,
                          galleryOnTap: () async {
                            Get.back();
                            controller.selectedXFile.value =
                                await PickFile.pickSingleFile(
                                    imageSource: ImageSource.gallery);
                          },
                          cameraOnTap: () async {
                            Get.back();
                            controller.selectedXFile.value =
                                await PickFile.pickSingleFile(
                                    imageSource: ImageSource.camera);
                          },
                        );
                      },
                      padding: EdgeInsets.all(3.r),
                      child: customSvgImage(
                        imagePath: Assets.icons.attachmentIcon,
                        color: Colors.grey,
                        height: 20.h,
                        width: 25.w,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      );
    },
  );
}
