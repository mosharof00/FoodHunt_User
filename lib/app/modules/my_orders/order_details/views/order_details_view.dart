import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:food_hunt_user/Utils/global_button.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/app/routes/app_pages.dart';

import '../../../../../Helper/helper_utils.dart';
import '../../../../../Utils/app_text_style.dart';
import '../../../../../Utils/app_text_style_over_flow.dart';
import '../../../../../Utils/appbar_title.dart';
import '../../../../../Utils/cached_image_helper.dart';
import '../../../../../Utils/custom_icon_button.dart';
import '../../../../../Utils/custom_svg_image.dart';
import '../../../../../Utils/methods/method_helper.dart';
import '../../../../../Utils/view_summary.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../cart/controllers/cart_controller.dart';
import '../../../checkout/widgets/checkout_helper_container.dart';
import '../../../checkout/widgets/order_item_layout.dart';
import '../controllers/order_details_controller.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorName.bgColor,
        appBar: AppBar(
          backgroundColor: ColorName.bgColor,
          surfaceTintColor: ColorName.bgColor,
          title: appbarTitle(text: 'Order Details'),
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
                        text: 'Status',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: MethodHelper.getOrderStatusColor(
                              controller.order.orderStatus!,
                              isForText: false),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: AppTextStyle(
                          text: controller.order.orderStatus!,
                          color: MethodHelper.getOrderStatusColor(
                            controller.order.orderStatus!,
                          ),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppTextStyle(
                          text: controller.order.orderStatus ==
                                  OrderStatus.pending
                              ? 'Your order did not accept yet.'
                              : controller.order.orderStatus ==
                                      OrderStatus.cooking
                                  ? "Your order is accepted and it's on cooking."
                                  : controller.order.orderStatus ==
                                          OrderStatus.waitingPickUp
                                      ? "Your order is cooked and it's ready for delivery."
                                      : controller.order.orderStatus ==
                                              OrderStatus.pickedUp
                                          ? "A delivery man has picked up your order. You can track your order."
                                          : controller.order.orderStatus ==
                                                  OrderStatus.delivered
                                              ? "Your order is successfully delivered."
                                              : "Your order is cancelled",
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                      controller.order.orderStatus == OrderStatus.pickedUp
                          ? globalButton(
                              height: 25.h,
                              width: 100.w,
                              fontSize: 14.sp,
                              onTap: () {
                                Get.toNamed(Routes.TRACK_ORDER,
                                    arguments: {'order': controller.order});
                              },
                              text: 'Track Order')
                          : controller.order.orderStatus ==
                                  OrderStatus.delivered
                              ? globalButton(
                                  onTap: () {
                                    Get.toNamed(Routes.REVIEW_AND_TRIP);
                                  },
                                  height: 25.h,
                                  width: 120.w,
                                  fontSize: 14.sp,
                                  text: 'Review & trip')
                              : 0.height
                    ],
                  ),
                ),
                15.height,
                checkoutHelperContainer(
                  title: AppTextStyle(
                    text: 'Delivery',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
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
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextStyle(
                            text: 'Delivery',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          AppTextStyle(
                            text: controller.order.address!,
                            fontSize: 13.sp,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            color: Colors.grey.shade700,
                          ),
                          controller.order.specialInstructions == null ||
                                  controller.order.specialInstructions!.isEmpty
                              ? 0.height
                              : AppTextStyleOverFlow(
                                  text:
                                      "note: ${controller.order.specialInstructions}",
                                  textAlign: TextAlign.start,
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                )
                        ],
                      )),
                    ],
                  ),
                ),
                15.height,
                checkoutHelperContainer(
                  title: AppTextStyle(
                    text: 'Restaurant',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      cachedImageWidget(
                          imgUrl: controller.order.restaurantProfileImage ?? '',
                          height: 50.h,
                          width: 50.w,
                          borderRadius: 10.r),
                      10.width,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextStyle(
                              text: 'Restaurant',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: ColorName.primaryColor,
                            ),
                            AppTextStyleOverFlow(
                              text: controller.order.restaurantName!,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                15.height,
                checkoutHelperContainer(
                    title: AppTextStyle(
                      text: 'Ordered Items',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.order.orderItems!.length,
                        itemBuilder: (context, index) {
                          final orderItem = controller.order.orderItems![index];
                          return OrderItemLayout(
                            showEditIcon: false,
                            showItems: true,
                            orderItem: CartModel(
                                id: "#${orderItem.id}",
                                imageUrl: orderItem.image,
                                name: orderItem.name!,
                                basePrice: orderItem.pricePerUnit,
                                additionalItemsPrice: 0.0,
                                totalPrice: orderItem.total.toDouble(),
                                qty: orderItem.quantity!,
                                sizes: orderItem.size,
                                additionalItems: orderItem.addOn),
                          );
                        })),
                15.height,
                checkoutHelperContainer(
                    title: Row(
                      children: [
                        Row(
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
                          ],
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              cachedImageWidget(
                                  imgUrl: controller.order.paymentMethodLogo!,
                                  height: 25.h,
                                  width: 60.w,
                                  fit: BoxFit.contain),
                              Expanded(
                                child: AppTextStyleOverFlow(
                                  text: controller.order.paymentMethod!,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
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
                        AppTextStyle(
                          text: controller.order.discount == null ||
                                  controller.order.discount == 0.0 ||
                                  controller.order.discount == 0
                              ? ''
                              : "${HelperUtils.currencySymbol} ${controller.order.discount}",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorName.primaryColor,
                        )
                      ],
                    )),
                15.height,
                checkoutHelperContainer(
                  title: Column(
                    children: [
                      viewSummary(
                          title: 'Subtotal',
                          amount: controller.order.subtotal.toString()),
                      10.height,
                      viewSummary(
                          title: 'Delivery Fee',
                          amount: controller.order.deliveryFee.toString()),
                      10.height,
                      viewSummary(
                          title: 'Service Charge',
                          amount: controller.order.serviceCharge == null
                              ? "0.0"
                              : controller.order.serviceCharge.toString()),
                      10.height,
                      viewSummary(
                          title: 'Tip',
                          amount: controller.order.tip.toString()),
                      10.height,
                      viewSummary(
                          title: 'Discount',
                          amount: controller.order.discount!.toString(),
                          icon: '-'),
                    ],
                  ),
                  child: viewSummary(
                      title: 'Total',
                      amount: controller.order.total!.toString()),
                ),
                20.height,
                // globalButton(
                //     onTap: () {
                //       Get.offAllNamed(Routes.MY_ORDERS);
                //     },
                //     text:
                //         "Place Order - ${cartController.total.value.toString()}"),
                40.height,
              ],
            ),
          ),
        ));
  }
}
