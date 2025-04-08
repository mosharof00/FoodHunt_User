import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:food_hunt_user/Utils/app_text_style.dart';
import 'package:food_hunt_user/Utils/appbar_title.dart';
import 'package:food_hunt_user/Utils/cached_image_helper.dart';
import 'package:food_hunt_user/Utils/custom_svg_image.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/gen/colors.gen.dart';

import '../../../../gen/assets.gen.dart';
import '../controllers/payment_method_controller.dart';

class PaymentMethodView extends GetView<PaymentMethodController> {
  const PaymentMethodView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
        appBar: AppBar(
          backgroundColor: ColorName.bgColor,
          surfaceTintColor: ColorName.bgColor,
          title: appbarTitle(text: 'Payment Method'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: controller.paymentMethodList.length,
              itemBuilder: (context, index) {
                final method = controller.paymentMethodList[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: InkWell(
                    onTap: () {
                      controller.selectedPaymentMethodIndex.value = index;
                      Get.back();
                    },
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      height: 70.h,
                      width: Get.width,
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2.r,
                                offset: Offset(1, 1))
                          ]),
                      child: Row(
                        children: [
                          cachedImageWidget(
                            imgUrl: method.logoUrl??'',
                            width: 100.w,
                            fit: BoxFit.contain,
                            borderRadius: 10.r
                          ),
                          15.width,
                          Expanded(
                              child: AppTextStyle(
                            text: method.name!,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          )),
                          Obx(() => customSvgImage(
                              imagePath:
                                  controller.selectedPaymentMethodIndex.value ==
                                          index
                                      ? Assets.icons.radioOnIcon
                                      : Assets.icons.radioOffIcon,
                              color: ColorName.primaryColor,
                            height: 20.h,
                            width: 20.w
                          )),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
