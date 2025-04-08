import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:food_hunt_user/Helper/helper_utils.dart';
import 'package:food_hunt_user/Utils/app_text_style.dart';
import 'package:food_hunt_user/Utils/global_button.dart';
import 'package:food_hunt_user/Utils/global_divider.dart';
import 'package:food_hunt_user/Utils/global_snackbar.dart';
import 'package:food_hunt_user/Utils/show_empty_result.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/app/models/coupon_model.dart';
import 'package:food_hunt_user/app/modules/cart/controllers/cart_controller.dart';
import 'package:food_hunt_user/app/modules/checkout/controllers/checkout_controller.dart';

import '../../../../Utils/appbar_title.dart';
import '../../../../Utils/custom_icon_button.dart';
import '../../../../gen/colors.gen.dart';
import '../controllers/coupons_controller.dart';

class CouponsView extends GetView<CouponsController> {
  const CouponsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorName.bgColor,
        appBar: AppBar(
          backgroundColor: ColorName.bgColor,
          surfaceTintColor: ColorName.bgColor,
          title: appbarTitle(text: 'Coupons'),
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: CustomIconButton(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              15.height,
              Obx(() {
                if (controller.isLoading.value) {
                  return Expanded(
                    child: Center(
                      child: LoadingAnimationWidget.threeArchedCircle(
                          color: ColorName.primaryColor, size: 40.sp),
                    ),
                  );
                } else if (controller.restaurantDiscountList.isEmpty &&
                    controller.globalDiscountList.isEmpty) {
                  return ShowEmptyResult(
                    title: 'No discount found!',
                    desc: 'There are no discounts under the restaurant',
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.selectedCoupon.value.code == null
                          ? 0.height
                          : Container(
                              height: 100.h,
                              width: Get.width,
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                  color: ColorName.primaryColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        AppTextStyle(
                                          text: 'Code',
                                          fontSize: 13.sp,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 3.h),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(50.r)),
                                          child: Center(
                                            child: AppTextStyle(
                                              text: controller
                                                  .selectedCoupon.value.code!,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: Get.height,
                                    width: 1.w,
                                    color: Colors.grey.shade400,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        AppTextStyle(
                                          text: 'Total Discount',
                                          fontSize: 13.sp,
                                        ),
                                        AppTextStyle(
                                          text:
                                              "${HelperUtils.currencySymbol} ${controller.totalDiscount.value.toString()}",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: Get.height,
                                    width: 1.w,
                                    color: Colors.grey.shade400,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                  ),
                                  Expanded(
                                    child: globalButton(
                                        fontSize: 14.sp,
                                        height: 30.h,
                                        onTap: () {
                                          final checkoutController =
                                              Get.find<CheckoutController>();
                                          checkoutController.discount.value =
                                              controller.totalDiscount.value;
                                          checkoutController.couponCode.value = controller.selectedCoupon.value.code!;
                                          checkoutController.getTotal();
                                          Get.back();
                                          globalSnackBar(
                                              durationInSeconds: 2,
                                              title:
                                                  'Coupon applied successfully!',
                                              message:
                                                  "You got a ${HelperUtils.currencySymbol}${controller.totalDiscount.value} amount discount on the coupon.");
                                        },
                                        text: 'Apply'),
                                  ),
                                ],
                              ),
                            ),
                      10.height,
                      controller.selectedCoupon.value.code == null
                          ? 0.height
                          : globalDivider(),
                      10.height,
                      AppTextStyle(
                        text: "Restaurant discounts:",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      20.height,
                      Obx(() {
                        if (controller.restaurantDiscountList.isEmpty) {
                          return AppTextStyle(
                            text: 'No restaurant discount is available!',
                            textAlign: TextAlign.center,
                            color: Colors.grey,
                          );
                        } else {
                          return Column(
                            children: [
                              ...List.generate(
                                  controller.restaurantDiscountList.length,
                                  (index) {
                                Coupon coupon =
                                    controller.restaurantDiscountList[index];
                                return couponLayout(
                                  controller: controller,
                                  coupon: coupon,
                                  onTap: () {
                                    controller.totalDiscount.value =
                                        controller.calculateDiscount(
                                            coupon,
                                            Get.find<CartController>()
                                                .subTotal
                                                .value);
                                  },
                                  selectedColor:
                                      controller.selectedCoupon.value.id ==
                                              coupon.id
                                          ? ColorName.primaryColor
                                          : Colors.black12,
                                );
                              })
                            ],
                          );
                        }
                      }),
                      20.height,
                      AppTextStyle(
                        text: "Global discounts:",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      20.height,
                      Obx(() {
                        if (controller.globalDiscountList.isEmpty) {
                          return AppTextStyle(
                            text: 'No global discount is available!',
                            textAlign: TextAlign.center,
                            color: Colors.grey,
                          );
                        } else {
                          return Column(
                            children: [
                              ...List.generate(
                                  controller.globalDiscountList.length,
                                  (index) {
                                Coupon coupon =
                                    controller.globalDiscountList[index];
                                return couponLayout(
                                  controller: controller,
                                  coupon: coupon,
                                  onTap: () {
                                    controller.totalDiscount.value =
                                        controller.calculateDiscount(
                                            coupon,
                                            Get.find<CartController>()
                                                .subTotal
                                                .value);
                                  },
                                  selectedColor:
                                      controller.selectedCoupon.value.id ==
                                              coupon.id
                                          ? ColorName.primaryColor
                                          : Colors.black12,
                                );
                              })
                            ],
                          );
                        }
                      }),
                    ],
                  );
                }
              })
            ],
          ),
        ));
  }
}

Widget couponLayout(
    {required CouponsController controller,
    required Coupon coupon,
    required VoidCallback onTap,
    required Color selectedColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        // height: 70.h,
        width: Get.width,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                  color: selectedColor, blurRadius: 3.r, offset: Offset(1, 1))
            ]),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppTextStyle(
                    text: coupon.code!,
                    fontSize: 16.sp,
                  ),
                  AppTextStyle(
                    text: controller.checkDateValidate(coupon),
                    fontSize: 12.sp,
                    color:
                        controller.checkDateValidate(coupon).split(" ").first ==
                                'Expired'
                            ? Colors.grey
                            : Colors.red.shade300,
                  ),
                ],
              ),
            ),
            15.width,
            AppTextStyle(
              text: controller.getDiscount(coupon),
              color: ColorName.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    ),
  );
}
