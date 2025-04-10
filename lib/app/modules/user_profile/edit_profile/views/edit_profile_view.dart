import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:food_hunt_user/Utils/custom_icon_button.dart';
import 'package:food_hunt_user/Utils/global_button.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/app/modules/home/controllers/home_controller.dart';

import '../../../../../Helper/logger.dart';
import '../../../../../Utils/app_text_style.dart';
import '../../../../../Utils/cached_image_helper.dart';
import '../../../../../Utils/custom_svg_image.dart';
import '../../../../../Utils/input_field_with_label.dart';
import '../../../../../Utils/loading_action.dart';
import '../../../../../Utils/methods/pick_files.dart';
import '../../../../../Utils/selected_file_validation.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          if (controller.isUserLoading.value) {
            return Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                  color: ColorName.primaryColor, size: 40.sp),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Obx(() {
                        if (controller.selectedCoverImage.value == null) {
                          return cachedImageWidget(
                              imgUrl: controller.user.value.coverImage ?? "",
                              height: 200.h,
                              width: Get.width,
                              borderRadius: 20.r);
                        } else {
                          return SizedBox(
                            height: 200.h,
                            width: Get.width,
                            child: SelectedFileValidation(
                              height: Get.height,
                              width: Get.width,
                              selectedFile: controller.selectedCoverImage,
                              errorTitle: 'File is not selected',
                            ),
                          );
                        }
                      }),
                      Positioned(
                        top: 20.h,
                        left: 15.w,
                        right: 15.w,
                        child: SafeArea(
                          child: Row(
                            children: [
                              CustomIconButton(
                                size: 45.sp,
                              ),
                              Expanded(
                                child: Text(
                                  "Profile",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: GoogleFonts.outfit().fontFamily,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black
                                            .withAlpha(100), // Shadow color
                                        offset: Offset(2,
                                            2), // Horizontal and vertical offset
                                        blurRadius: 4, // The blur radius
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              CustomIconButton(
                                size: 45.sp,
                                icon: SvgPicture.asset(
                                    Assets.icons.notificationIcon),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 150.h,
                        left: (Get.width - 120.w) /
                            2, // Centers the container horizontally
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              height: 120.h,
                              width: 120.w,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: ColorName.onPrimary,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withAlpha(30),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () async {
                                  controller.selectedProfileImage.value =
                                      await PickFile.pickSingleFile(
                                          imageSource: ImageSource.gallery);
                                },
                                child: Obx(() {
                                  if (controller.selectedProfileImage.value ==
                                      null) {
                                    return cachedImageWidget(
                                        imgUrl: controller
                                                .user.value.profileImageUrl ??
                                            "",
                                        height: Get.height,
                                        width: Get.width,
                                        borderRadius: 20.r);
                                  } else {
                                    return SelectedFileValidation(
                                      height: Get.height,
                                      width: Get.width,
                                      selectedFile:
                                          controller.selectedProfileImage,
                                      errorTitle: 'File is not selected',
                                      unSelectedWidget: Container(
                                        height: Get.height,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                        ),
                                      ),
                                    );
                                  }
                                }),
                              ),
                            ),
                            Positioned(
                                bottom: -18.h,
                                left: 45.w,
                                child: CustomIconButton(
                                  onPressed: () async {
                                    controller.selectedProfileImage.value =
                                        await PickFile.pickSingleFile(
                                            imageSource: ImageSource.gallery);
                                  },
                                  size: 35.sp,
                                  backgroundColor: Color(0xFfFFDBDB),
                                  border: Border.all(
                                      width: 2.w, color: Colors.white),
                                  icon: customSvgImage(
                                      imagePath: Assets.icons.cameraIcon,
                                      color: ColorName.primaryColor,
                                      height: 20.h,
                                      width: 20.w),
                                )),
                          ],
                        ),
                      ),
                      Positioned(
                          right: 20.w,
                          bottom: 85.h,
                          child: CustomIconButton(
                            onPressed: () async {
                              controller.selectedCoverImage.value =
                                  await PickFile.pickSingleFile(
                                      imageSource: ImageSource.gallery);
                            },
                            size: 35.sp,
                            backgroundColor: Colors.white.withAlpha(100),
                            border: Border.all(width: 2.w, color: Colors.white),
                            icon: customSvgImage(
                                imagePath: Assets.icons.cameraIcon,
                                color: ColorName.white,
                                height: 20.h,
                                width: 20.w),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      children: [
                        InputFieldWithLabel(
                            controller: controller.nameEditingController,
                            label: "Name",
                            keyboardType: TextInputType.text),
                        SizedBox(height: 10.h),
                        InputFieldWithLabel(
                            controller: controller.userNameEditingController,
                            label: "Username",
                            keyboardType: TextInputType.text),
                        SizedBox(height: 10.h),
                        InputFieldWithLabel(
                          controller: controller.bioEditingController,
                          label: "Bio",
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                        ),
                        50.height,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Obx(() => controller.isUpdating.value
                              ? loadingAction()
                              : globalButton(
                                  onTap: () {
                                    controller.updateUser();
                                  },
                                  text: "Save")),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        }));
  }
}
