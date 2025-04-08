import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:food_hunt_user/Helper/helper_utils.dart';
import 'package:food_hunt_user/Utils/app_text_style.dart';
import 'package:food_hunt_user/Utils/cached_image_helper.dart';
import 'package:food_hunt_user/Utils/custom_icon_button.dart';
import 'package:food_hunt_user/Utils/custom_svg_image.dart';
import 'package:food_hunt_user/Utils/global_button.dart';
import 'package:food_hunt_user/Utils/global_divider.dart';
import 'package:food_hunt_user/Utils/quantity_widget.dart';
import 'package:food_hunt_user/Utils/show_ratings.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/Utils/view_summary.dart';
import 'package:food_hunt_user/app/modules/cart/controllers/cart_controller.dart';
import 'package:food_hunt_user/app/modules/food_details/Widgets/additional_items.dart';
import 'package:food_hunt_user/app/modules/food_details/Widgets/size_items.dart';
import 'package:food_hunt_user/app/routes/app_pages.dart';
import 'package:food_hunt_user/gen/assets.gen.dart';
import 'package:food_hunt_user/gen/colors.gen.dart';

import '../../../../Utils/global_snackbar.dart';
import '../controllers/food_details_controller.dart';

class FoodDetailsView extends GetView<FoodDetailsController> {
  const FoodDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final food = controller.food.value;
    return Scaffold(
        backgroundColor: ColorName.bgColor,
        body: Padding(
            padding: EdgeInsets.all(15.r),
            child: NestedScrollView(
              headerSliverBuilder: (_, __) {
                return [
                  SliverAppBar(
                    floating: true,
                    pinned: true,
                    snap: true,
                    expandedHeight: 200.h,
                    // Height of the expanded AppBar
                    automaticallyImplyLeading: false,
                    backgroundColor: ColorName.bgColor,
                    surfaceTintColor: ColorName.white,
                    toolbarHeight: 40.h,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomIconButton(
                          icon: customSvgImage(
                            imagePath: Assets.icons.arrowBackIcon,
                          ),
                        ),
                        Obx(() {
                          return CustomIconButton(
                              onPressed: () {
                                if (controller.isWishListed.value) {
                                  controller.isWishListed.value = false;
                                } else {
                                  controller.isWishListed.value = true;
                                }
                              },
                              icon: customSvgImage(
                                  height: 18.h,
                                  width: 18.w,
                                  imagePath: Assets.icons.loveIcon,
                                  color: controller.isWishListed.value
                                      ? ColorName.primaryColor
                                      : Colors.grey));
                        }),
                      ],
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: cachedImageWidget(
                            imgUrl: food.imageUrl ?? "",
                            // height: 200.h,
                            width: Get.width,
                            borderRadius: 15.r),
                      ),
                    ),
                  )
                ];
              },
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.height,
                    AppTextStyle(
                      text: food.name!,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    5.height,
                    ShowRatings(ratings: food.ratings!.toDouble()),
                    5.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppTextStyle(
                          text: HelperUtils.currencySymbol,
                          fontWeight: FontWeight.w600,
                        ),
                        AppTextStyle(
                          text: food.basePrice!.toString(),
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        Spacer(),
                        Obx(() {
                          return QuantityWidget(
                            qty: controller.selectedQty.value,
                            minusOnTap: () {
                              if (controller.selectedQty.value <= 1) {
                                globalSnackBar(
                                    title: 'Minimum quantity',
                                    message: 'Minimum quantity is 1');
                              } else {
                                controller.selectedQty.value--;
                              }
                              controller.getTotal();
                            },
                            plusOnTap: () {
                              controller.selectedQty.value++;
                              controller.getTotal();
                            },
                          );
                        }),
                      ],
                    ),
                    15.height,
                    AppTextStyle(
                      text: food.description!,
                      color: Colors.grey,
                      textAlign: TextAlign.start,
                    ),
                    10.height,
                    globalDivider(),
                    10.height,
                    Row(
                      children: [
                        AppTextStyle(
                          text: "Size",
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        5.width,
                        AppTextStyle(
                          text: "(Required)",
                          color: Colors.grey,
                        )
                      ],
                    ),
                    controller.sizeList.isNotEmpty
                        ? SizeItems(controller: controller)
                        : 0.height,
                    controller.sizeList.isNotEmpty ? 10.height : 0.height,
                    controller.sizeList.isNotEmpty ? globalDivider() : 0.height,
                    10.height,
                    Row(
                      children: [
                        AppTextStyle(
                          text: "Add On",
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        5.width,
                        AppTextStyle(
                          text: "(Optional)",
                          color: Colors.grey,
                        )
                      ],
                    ),
                    AdditionalItems(controller: controller),
                    10.height,
                    globalDivider(),
                    15.height,
                    Obx(() {
                      return viewSummary(
                          title: 'Total',
                          amount: controller.totalAmount.toStringAsFixed(2));
                    }),
                    20.height,
                    globalButton(
                        onTap: () {
                          final cartController = Get.put(CartController());

                          if (cartController.cartList
                              .any((item) => item.id == food.id)) {

                            ///   update cart
                            cartController.cartList
                                .removeWhere((item) => item.id == food.id);
                            cartController.cartList.add(CartModel(
                                id: food.id!,
                                imageUrl: food.imageUrl!,
                                name: food.name!,
                                basePrice: food.basePrice!.toDouble(),
                                additionalItemsPrice:
                                    controller.additionalItemsPrice.value,
                                totalPrice: controller.totalAmount.value,
                                qty: controller.selectedQty.value,
                                sizes: controller.selectedSize,
                                additionalItems: controller
                                        .selectedAdditionalItems.isNotEmpty
                                    ? controller.selectedAdditionalItems
                                    : []));
                          } else {

                            ///    Add to  cart
                            cartController.cartList.add(CartModel(
                                id: food.id!,
                                imageUrl: food.imageUrl!,
                                name: food.name!,
                                basePrice: controller.basePriceOnSize.value,
                                additionalItemsPrice:
                                    controller.additionalItemsPrice.value,
                                totalPrice: controller.totalAmount.value,
                                qty: controller.selectedQty.value,
                                sizes: controller.selectedSize,
                                additionalItems: controller
                                        .selectedAdditionalItems.isNotEmpty
                                    ? controller.selectedAdditionalItems
                                    : []));
                          }

                          cartController. calculateTotal();
                          Get.toNamed(Routes.CART);
                        },
                        text: "Add to cart"),
                    30.height,
                  ],
                ),
              ),
            )));
  }
}
