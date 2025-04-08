import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/app/modules/track_order/controllers/track_order_controller.dart';

import '../../../../Helper/helper_utils.dart';
import '../../../../Utils/app_text_style.dart';
import '../../../../Utils/cached_image_helper.dart';
import '../../../../Utils/custom_icon_button.dart';
import '../../../../Utils/custom_svg_image.dart';
import '../../../../Utils/global_snackbar.dart';
import '../../../../Utils/methods/pick_files.dart';
import '../../../../Utils/methods/view_photos.dart';
import '../../../../Utils/shimmer_loading.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../controllers/chats_controller.dart';
import '../widgets/bottom_text_field.dart';
import '../widgets/select_file_bottom_sheet.dart';
import '../widgets/send_file_bottom_sheet.dart';

class ChatsView extends GetView<ChatsController> {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatsController());

    return Scaffold(
      backgroundColor: ColorName.white,
      appBar: AppBar(
        backgroundColor: ColorName.white,
        surfaceTintColor: ColorName.white,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                ViewPhotos.viewSinglePhoto(Get.find<TrackOrderController>()
                        .driver
                        .value
                        .driverImageUrl ??
                    HelperUtils.defaultProfileImage);
              },
              child: cachedImageWidget(
                  imgUrl: Get.find<TrackOrderController>()
                          .driver
                          .value
                          .driverImageUrl ??
                      HelperUtils.defaultProfileImage,
                  height: 50.h,
                  width: 50.w,
                  borderRadius: 100.r),
            ),
            10.width,
            AppTextStyle(
              text: 'Driver name',
              color: Colors.grey,
              fontSize: 12.sp,
            ),
            AppTextStyle(
              text: controller.receiverName,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: CustomIconButton(
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (chatController.isLoading.value) {
                return Center(
                    child: LoadingAnimationWidget.threeArchedCircle(
                        color: ColorName.primaryColor, size: 40.sp));
              }

              return ListView.builder(
                reverse: true,
                padding: EdgeInsets.all(10.r),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  final isSender = message.senderId == controller.sender.id;
                  final messageDate = message.createdAt ?? DateTime.now();

                  // Check if we need to show a date header
                  bool showDateHeader =
                      index == controller.messages.length - 1 ||
                          DateFormat('yyyy-MM-dd').format(messageDate) !=
                              DateFormat('yyyy-MM-dd').format(
                                  controller.messages[index + 1].createdAt ??
                                      DateTime.now());

                  // Format time
                  final messageTime = DateFormat('hh:mm a').format(messageDate);

                  // Format date header
                  String formattedDate = '';
                  final now = DateTime.now();
                  final yesterday = now.subtract(Duration(days: 1));

                  if (DateFormat('yyyy-MM-dd').format(messageDate) ==
                      DateFormat('yyyy-MM-dd').format(now)) {
                    formattedDate = 'Today';
                  } else if (DateFormat('yyyy-MM-dd').format(messageDate) ==
                      DateFormat('yyyy-MM-dd').format(yesterday)) {
                    formattedDate = 'Yesterday';
                  } else {
                    formattedDate =
                        DateFormat('MMM dd, yyyy').format(messageDate);
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (showDateHeader)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 10.w),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade600,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: AppTextStyle(
                                text: formattedDate,
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                      // Chat Message Box with Time
                      Align(
                        alignment: isSender
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 12.w),
                          margin: EdgeInsets.symmetric(vertical: 4.h),
                          constraints: BoxConstraints(
                            maxWidth: 250.w,
                          ), // Ensures message doesn't stretch too wide
                          decoration: BoxDecoration(
                            color: isSender
                                ? ColorName.primaryColor
                                : Colors.grey[200],
                            borderRadius: isSender
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    bottomLeft: Radius.circular(20.r),
                                    bottomRight: Radius.circular(20.r),
                                  )
                                : BorderRadius.only(
                                    topRight: Radius.circular(20.r),
                                    bottomLeft: Radius.circular(20.r),
                                    bottomRight: Radius.circular(20.r),
                                  ),
                          ),
                          child: Column(
                            crossAxisAlignment: isSender
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              message.fileUrls == null ||
                                      message.fileUrls!.isEmpty
                                  ? 0.height
                                  : InkWell(
                                      onTap: () {
                                        ViewPhotos.viewSinglePhoto(
                                            message.fileUrls!.first);
                                      },
                                      child: cachedImageWidget(
                                        imgUrl: message.fileUrls!.first,
                                        borderRadius: 20.r,
                                        height: 200.h,
                                        width: Get.width,
                                      ),
                                    ),
                              message.content == null ||
                                      message.content!.isEmpty
                                  ? SizedBox.shrink()
                                  : AppTextStyle(
                                      text: message.content!,
                                      color: isSender
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                              AppTextStyle(
                                text: messageTime,
                                color: isSender ? Colors.white54 : Colors.grey,
                                fontSize: 10.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
          ),
          Obx(() {
            if (controller.isFileSending.value) {
              return Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: shimmerLoadingWidget(
                        height: 200.h, width: 250.w, borderRadius: 20.r),
                  ));
            } else {
              return SizedBox.shrink();
            }
          }),
          Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
            child: BottomTextField(
              textEditingController: controller.textController,
              sendOnTap: () {
                if (controller.textController.text.isNotEmpty) {
                  controller.sendMessage(
                      senderId: controller.sender.id!,
                      receiverId: controller.receiverId,
                      message: controller.textController.text);
                  controller.textController.clear();
                  controller.selectedXFile.value = null;
                } else {
                  globalSnackBar(
                      durationInSeconds: 2,
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
                      sendFileBottomSheet();
                    },
                    cameraOnTap: () async {
                      Get.back();
                      controller.selectedXFile.value =
                          await PickFile.pickSingleFile(
                              imageSource: ImageSource.camera);
                      sendFileBottomSheet();
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
          ),
        ],
      ),
    );
  }
}
