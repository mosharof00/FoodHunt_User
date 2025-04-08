import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:food_hunt_user/Helper/helper_utils.dart';
import 'package:food_hunt_user/Utils/cached_image_helper.dart';
import 'package:food_hunt_user/Utils/global_button.dart';
import 'package:food_hunt_user/Utils/global_snackbar.dart';
import 'package:food_hunt_user/Utils/input_field_with_label.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';

import '../../../../Utils/app_text_style.dart';
import '../../../../Utils/appbar_title.dart';
import '../../../../Utils/custom_icon_button.dart';
import '../../../../gen/colors.gen.dart';
import '../../../routes/app_pages.dart';
import '../controllers/review_and_trip_controller.dart';

class ReviewAndTripView extends GetView<ReviewAndTripController> {
  const ReviewAndTripView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Delivered'),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: CustomIconButton(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.height,
              AppTextStyle(
                text: 'Your order from Hungry Puppets hasbeen delivered!',
                textAlign: TextAlign.start,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              10.height,
              cachedImageWidget(
                imgUrl:
                    'https://i.pinimg.com/736x/03/d8/a0/03d8a0b54bb7aee6cec0cbe810679f89.jpg',
                height: 150.h,
                width: Get.width,
                borderRadius: 20.r,
              ),
              5.height,
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.ORDER_DETAILS,
                      arguments: controller.order);
                },
                child: AppTextStyle(
                  text: 'View order details',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorName.primaryColor,
                  decorationColor: ColorName.primaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
              10.height,
              AppTextStyle(
                text: 'Notes from your driver Carlos Lopez',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: ColorName.primaryColor,
              ),
              5.height,
              AppTextStyle(
                text:
                    'Your order is on the red table on the porch as you requested. Enjoy your meal!',
                textAlign: TextAlign.start,
              ),
              10.height,
              AppTextStyle(
                text: 'Review the driver',
                color: ColorName.primaryColor,
                fontWeight: FontWeight.w500,
              ),
              15.height,
              Obx(() => RatingBar.builder(
                    initialRating: controller.selectedRating.value,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 40.0,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      controller.updateRating(rating);
                    },
                  )),
              Obx(() => AppTextStyle(
                    text:
                        'Your rating: ${controller.selectedRating.value.toStringAsFixed(1)}',
                  )),
              15.height,
              AppTextStyle(
                text:
                    'Show your appreciation! Tip your hard-working delivery driver. They keep 100% of the tip!',
                fontSize: 12.sp,
                color: Colors.grey,
                textAlign: TextAlign.start,
              ),
              15.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...List.generate(4, (index) {
                    List<String> tipList = [
                      '${HelperUtils.currencySymbol}2',
                      '${HelperUtils.currencySymbol}5',
                      '${HelperUtils.currencySymbol}9',
                      'Custom'
                    ];
                    return InkWell(
                      onTap: () {
                        controller.selectedTipsIndex.value = index;
                        if (index == 3) {
                          takeCustomAmount(
                              context: context, controller: controller);
                        } else {
                          controller.tipsAmount.value =
                              int.parse(tipList[index]);
                        }
                      },
                      borderRadius: BorderRadius.circular(15.r),
                      child: Container(
                        height: 50.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 3.r,
                                  offset: Offset(1, 1)),
                            ]),
                        child: Obx(() {
                          return Center(
                            child: AppTextStyle(
                              text: tipList[index],
                              color: controller.selectedTipsIndex.value == index
                                  ? ColorName.primaryColor
                                  : Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }),
                      ),
                    );
                  })
                ],
              ),
              40.height,
              globalButton(
                onTap: () {},
                text: 'Sent Tip',
                suffixWidget: Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Obx(() {
                    return AppTextStyle(
                      text:
                          "-   ${HelperUtils.currencySymbol}${controller.tipsAmount.value.toString()}",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorName.white,
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void takeCustomAmount({
  required BuildContext context,
  required ReviewAndTripController controller,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Material(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              height: 200.h,
              width: Get.width,
              decoration: BoxDecoration(
                color: ColorName.bgColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(15.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InputFieldWithLabel(
                      controller: controller.tipsEditingController,
                      label: 'Enter amount',
                      keyboardType: TextInputType.number,
                      hintText: 'Amount',
                    ),
                    20.height,
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            // Cancel and close dialog
                            // controller.resetAmount();
                            Navigator.of(context).pop();
                          },
                          child: AppTextStyle(
                            text: 'Cancel',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorName.primaryColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Confirm and close dialog
                            if (controller
                                .tipsEditingController.text.isNotEmpty) {
                              controller.tipsAmount.value = int.parse(
                                  controller.tipsEditingController.text);
                              Navigator.of(context).pop();
                            } else {
                              globalSnackBar(
                                  title: 'Invalid Input',
                                  message: 'Please enter a valid amount!');
                            }
                          },
                          child: AppTextStyle(
                            text: 'OK',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorName.primaryColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
