import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:food_hunt_user/Helper/helper_utils.dart';
import 'package:food_hunt_user/Utils/app_text_style.dart';
import 'package:food_hunt_user/Utils/app_text_style_over_flow.dart';
import 'package:food_hunt_user/Utils/appbar_title.dart';
import 'package:food_hunt_user/Utils/cached_image_helper.dart';
import 'package:food_hunt_user/Utils/custom_icon_button.dart';
import 'package:food_hunt_user/Utils/custom_svg_image.dart';
import 'package:food_hunt_user/Utils/global_button.dart';
import 'package:food_hunt_user/Utils/global_divider.dart';
import 'package:food_hunt_user/Utils/global_snackbar.dart';
import 'package:food_hunt_user/Utils/quantity_widget.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/Utils/view_summary.dart';
import 'package:food_hunt_user/app/routes/app_pages.dart';
import 'package:food_hunt_user/gen/colors.gen.dart';

import '../../../../gen/assets.gen.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    return Scaffold(
        backgroundColor: ColorName.bgColor,
        appBar: AppBar(
          backgroundColor: ColorName.bgColor,
          surfaceTintColor: ColorName.bgColor,
          title: appbarTitle(text: 'Cart'),
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: CustomIconButton(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: controller.cartList.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      cachedImageWidget(
                          imgUrl:
                              'https://i.pinimg.com/236x/a8/37/3d/a8373d1b3858a717b184ede20f35f134.jpg',
                          height: 300.h,
                          width: Get.width,
                          borderRadius: 15.r),
                      20.height,
                      AppTextStyle(
                        text: 'Your cart is empty!',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.cartList.length,
                            itemBuilder: (context, index) {
                              final cartItem = controller.cartList[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  children: [
                                    cachedImageWidget(
                                      imgUrl: cartItem.imageUrl ?? "",
                                      height: 85.h,
                                      width: 85.w,
                                      borderRadius: 15.r,
                                    ),
                                    15.width,
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: AppTextStyleOverFlow(
                                                text: cartItem.name,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            CustomIconButton(
                                              onPressed: () {
                                                controller.cartList
                                                    .remove(cartItem);
                                                globalSnackBar(
                                                    title: 'Remove to Cart',
                                                    message:
                                                        'Remove to cart successfully');
                                              },
                                              backgroundColor: Colors.white,
                                              size: 20.sp,
                                              icon: customSvgImage(
                                                  imagePath:
                                                      Assets.icons.crossIcon,
                                                  color:
                                                      ColorName.primaryColor),
                                            )
                                          ],
                                        ),
                                        cartItem.additionalItems == null ||
                                                cartItem
                                                    .additionalItems!.isEmpty
                                            ? SizedBox.shrink()
                                            : AppTextStyleOverFlow(
                                                text: cartItem.additionalItems!
                                                    .map((item) => item.name)
                                                    .join(', '),
                                                color: Colors.grey,
                                                fontSize: 12.sp,
                                              ),
                                        AppTextStyle(
                                          text:
                                              "${HelperUtils.currencySymbol}${cartItem.basePrice}",
                                          color: Colors.grey,
                                          fontSize: 12.sp,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppTextStyle(
                                              text:
                                                  "${HelperUtils.currencySymbol}${cartItem.totalPrice.toStringAsFixed(2)}",
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            QuantityWidget(
                                              qty: cartItem.qty,
                                              iconSize: 25.sp,
                                              minusOnTap: () {
                                                if (cartItem.qty <= 1) {
                                                  globalSnackBar(
                                                      title: 'Minimum quantity',
                                                      message:
                                                          'Minimum quantity is 1');
                                                } else {
                                                  controller
                                                      .updateCartItemQuantity(
                                                          index,
                                                          cartItem.qty - 1);
                                                }
                                              },
                                              plusOnTap: () {
                                                controller
                                                    .updateCartItemQuantity(
                                                        index,
                                                        cartItem.qty + 1);
                                              },
                                            )
                                          ],
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              );
                            });
                      }),
                      20.height,
                      AppTextStyle(
                        text: 'Summary:',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.start,
                        decoration: TextDecoration.underline,
                        color: Colors.grey,
                        decorationColor: Colors.grey,
                      ),
                      10.height,
                      Obx(
                        () => viewSummary(
                            title: 'Subtotal',
                            amount: controller.subTotal.value.toString()),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: globalDivider(),
                      ),
                      viewSummary(
                          title: 'Service charge',
                          amount: controller.serviceCharge.toString()),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: globalDivider(color: Colors.grey),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTextStyle(
                            text: 'Total',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          15.width,
                          AppTextStyle(
                              text: "(${controller.cartList.length}-items)"),
                          Spacer(),
                          Obx(() => AppTextStyle(
                                text:
                                    "${HelperUtils.currencySymbol}${controller.total.value.toStringAsFixed(2)}",
                                fontSize: 18.sp,
                              )),
                        ],
                      ),
                      30.height,
                      globalButton(
                          onTap: () {
                            Get.toNamed(Routes.CHECKOUT);
                          },
                          text: 'Check Out'),
                    ],
                  ),
          ),
        ));
  }
}
