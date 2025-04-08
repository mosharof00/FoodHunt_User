import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:food_hunt_user/Helper/helper_utils.dart';
import 'package:food_hunt_user/Utils/app_text_style.dart';
import 'package:food_hunt_user/Utils/app_text_style_over_flow.dart';
import 'package:food_hunt_user/Utils/custom_icon_button.dart';
import 'package:food_hunt_user/Utils/custom_svg_image.dart';
import 'package:food_hunt_user/Utils/global_button.dart';
import 'package:food_hunt_user/Utils/global_snackbar.dart';
import 'package:food_hunt_user/Utils/loading_action.dart';
import 'package:food_hunt_user/Utils/shimmer_loading.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/Utils/view_summary.dart';
import 'package:food_hunt_user/app/modules/cart/controllers/cart_controller.dart';
import 'package:food_hunt_user/app/routes/app_pages.dart';
import 'package:food_hunt_user/gen/assets.gen.dart';

import '../../../../Utils/appbar_title.dart';
import '../../../../Utils/cached_image_helper.dart';
import '../../../../Utils/input_field_with_label.dart';
import '../../../../gen/colors.gen.dart';
import '../controllers/checkout_controller.dart';
import '../widgets/checkout_helper_container.dart';
import '../widgets/order_item_layout.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return Scaffold(
        backgroundColor: ColorName.bgColor,
        appBar: AppBar(
          backgroundColor: ColorName.bgColor,
          surfaceTintColor: ColorName.bgColor,
          title: appbarTitle(text: 'Check Out'),
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
                checkoutHelperContainer(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextStyle(
                        text: 'Delivery',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomIconButton(
                        onPressed: () {
                          controller.addressEditingController.text =
                              controller.selectedAddress.value.address!;
                          controller.specialInstructionsEditingController.text =
                              controller.specialInstructions.value;
                          controller.updateAddressValidation(
                              controller.addressEditingController.text);
                          addressDialog(
                              context: context, controller: controller);
                        },
                        size: 30.sp,
                        icon: customSvgImage(
                            imagePath: Assets.icons.edit,
                            height: 22.h,
                            width: 22.w,
                            color: ColorName.primaryColor),
                      )
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle),
                          child: Center(
                              child: SvgPicture.asset(
                                  Assets.icons.locationCircularIcon))),
                      10.width,
                      Expanded(child: Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextStyle(
                              text: controller.selectedAddress.value.address!,
                              fontSize: 13.sp,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              color: Colors.grey.shade700,
                            ),
                            AppTextStyleOverFlow(
                              text:
                                  "note: ${controller.specialInstructions.value}",
                              textAlign: TextAlign.start,
                              fontSize: 12.sp,
                              color: Colors.grey,
                            )
                          ],
                        );
                      })),
                    ],
                  ),
                ),
                15.height,
                checkoutHelperContainer(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextStyle(
                          text: 'Your Items',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        // globalButton(
                        //     onTap: () {},
                        //     text: 'Add Items',
                        //     height: 30.h,
                        //     width: 90.w,
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(50.r),
                        //     borderColor: ColorName.primaryColor,
                        //     textColor: ColorName.primaryColor,
                        //     fontWeight: FontWeight.w500)
                      ],
                    ),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cartController.cartList.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartController.cartList[index];
                          return OrderItemLayout(
                            orderItem: cartItem,
                            showItems: false,
                          );
                        })),
                15.height,
                checkoutHelperContainer(
                    title: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.PAYMENT_METHOD);
                        },
                        borderRadius: BorderRadius.circular(50.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customSvgImage(
                                imagePath: Assets.icons.wallet,
                                height: 20.h,
                                width: 20.w,
                                color: ColorName.primaryColor),
                            15.width,
                            AppTextStyle(
                              text: 'Payment Method',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            10.width,
                            Expanded(
                              child: Obx(() {
                                if (controller.paymentMethodController.isLoading
                                        .value ||
                                    controller.paymentMethodController
                                            .selectedPaymentMethod ==
                                        null) {
                                  return shimmerLoadingWidget(
                                      height: 30.h);
                                } else {
                                  return Row(
                                    children: [
                                      cachedImageWidget(
                                          imgUrl: controller
                                                  .paymentMethodController
                                                  .selectedPaymentMethod!
                                                  .logoUrl ??
                                              "",
                                          height: 25.h,
                                          width: 60.w,
                                          fit: BoxFit.contain),
                                      Expanded(
                                        child: AppTextStyleOverFlow(
                                          text: controller
                                                  .paymentMethodController
                                                  .selectedPaymentMethod!
                                                  .name ??
                                              '',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  );
                                }
                              }),
                            )
                          ],
                        ),
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.COUPONS,
                              arguments: controller.restaurant.id);
                        },
                        borderRadius: BorderRadius.circular(50.r),
                        child: Row(
                          children: [
                            customSvgImage(
                                imagePath: Assets.icons.discountIconAlt,
                                height: 25.h,
                                width: 25.w,
                                color: ColorName.primaryColor),
                            15.width,
                            AppTextStyle(
                              text: 'Get Discount',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            Spacer(),
                            Obx(() => AppTextStyle(
                                  text: controller.discount.value == 0.0 ||
                                          controller.discount.value == 0
                                      ? ''
                                      : "${HelperUtils.currencySymbol} ${controller.discount.value}",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: ColorName.primaryColor,
                                )),
                            10.width,
                            Icon(
                              Icons.arrow_forward_ios,
                              color: ColorName.primaryColor,
                              size: 18.sp,
                            )
                          ],
                        ),
                      ),
                    )),
                15.height,
                checkoutHelperContainer(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextStyle(
                          text: 'Tip your rider',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        AppTextStyle(
                          text: 'Your rider receives 100% of the tip',
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    child: Obx(() {
                      return Row(
                        children: [
                          ...List.generate(controller.tipList.length, (index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: InkWell(
                                onTap: () {
                                  controller.selectedTipIndex.value = index;
                                  controller.tip.value = controller.tipList[
                                          controller.selectedTipIndex.value]
                                      .toDouble();
                                  controller.getTotal();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 3.h),
                                  decoration: BoxDecoration(
                                      color:
                                          controller.selectedTipIndex.value ==
                                                  index
                                              ? Colors.grey.shade600
                                              : Colors.white,
                                      borderRadius: BorderRadius.circular(40.r),
                                      border: Border.all(
                                        width: 1.w,
                                        color:
                                            controller.selectedTipIndex.value ==
                                                    index
                                                ? Colors.transparent
                                                : Colors.grey.shade600,
                                      )),
                                  child: Center(
                                    child: AppTextStyle(
                                      text: index == 0
                                          ? "Not now"
                                          : "${HelperUtils.currencySymbol} ${controller.tipList[index]}",
                                      color:
                                          controller.selectedTipIndex.value ==
                                                  index
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })
                        ],
                      );
                    })),
                15.height,
                checkoutHelperContainer(title: Obx(() {
                  return Column(
                    children: [
                      viewSummary(
                          title: 'Subtotal',
                          amount: cartController.subTotal.value.toString()),
                      10.height,
                      viewSummary(
                          title: 'Delivery Fee',
                          amount: controller.deliveryFee.value.toString()),
                      10.height,
                      viewSummary(
                          title: 'Service charge',
                          amount: cartController.serviceCharge.toString()),
                      10.height,
                      viewSummary(
                          title: 'Tip', amount: controller.tip.toString()),
                      10.height,
                      viewSummary(
                          title: 'Discount',
                          amount: controller.discount.value.toString(),
                          icon: '-')
                    ],
                  );
                }), child: Obx(() {
                  return viewSummary(
                      title: 'Total',
                      amount: controller.total.value.toString());
                })),
                20.height,
                Obx(() {
                  if (controller.isOrderLoading.value) {
                    return loadingAction();
                  } else {
                    return globalButton(
                        onTap: () {
                          if (controller.paymentMethodController
                                  .selectedPaymentMethod !=
                              null) {
                            controller.insertOrder();
                          } else {
                            globalSnackBar(
                                title: 'Payment Method not found!',
                                message:
                                    'Payment method not found please check and try again.');
                          }
                        },
                        text:
                            "Place Order - ${controller.total.value.toString()}");
                  }
                }),
                40.height,
              ],
            ),
          ),
        ));
  }
}

Future addressDialog(
    {required BuildContext context,
    required CheckoutController controller}) async {
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
                      return InputFieldWithLabel(
                        controller: controller.addressEditingController,
                        label: "Input your delivery address",
                        keyboardType: TextInputType.text,
                        hintText: 'Enter address',
                        maxLines: 2,
                        onChanged: (value) =>
                            controller.updateAddressValidation(value),
                        errorText: controller.isAddressValid.value
                            ? null
                            : "Address must be at least 15 characters long",
                      );
                    }),
                    15.height,
                    InputFieldWithLabel(
                      controller:
                          controller.specialInstructionsEditingController,
                      label: "Special Instructions",
                      hintText: 'Enter note',
                      keyboardType: TextInputType.multiline,
                      maxLines: 2,
                    ),
                    20.height,
                    Row(
                      children: [
                        Expanded(
                          child: globalButton(
                            onTap: () {
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
                            return globalButton(
                              color: controller.isAddressValid.value
                                  ? ColorName.primaryColor
                                  : Colors.grey,
                              onTap: () {
                                if (controller.isAddressValid.value) {
                                  Get.back();
                                  controller.getLocation(
                                      controller.addressEditingController.text);
                                } else {
                                  globalSnackBar(
                                      title: 'Address input invalid!',
                                      message: 'Please enter a valid address.');
                                }
                              },
                              text: 'Save and continue',
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
