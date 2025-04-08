import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:food_hunt_user/Helper/helper_utils.dart';
import 'package:food_hunt_user/Utils/app_text_style.dart';
import 'package:food_hunt_user/Utils/app_text_style_over_flow.dart';
import 'package:food_hunt_user/Utils/cached_image_helper.dart';
import 'package:food_hunt_user/Utils/global_button.dart';
import 'package:food_hunt_user/Utils/methods/method_helper.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/app/modules/main_page/controllers/main_page_controller.dart';
import 'package:food_hunt_user/app/routes/app_pages.dart';
import 'package:food_hunt_user/gen/assets.gen.dart';

import '../../../../Utils/appbar_title.dart';
import '../../../../Utils/custom_icon_button.dart';
import '../../../../Utils/shimmer_loading.dart';
import '../../../../gen/colors.gen.dart';
import '../controllers/my_orders_controller.dart';

class MyOrdersView extends GetView<MyOrdersController> {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyOrdersController());
    return Scaffold(
        backgroundColor: ColorName.bgColor,
        appBar: AppBar(
          backgroundColor: ColorName.bgColor,
          surfaceTintColor: ColorName.bgColor,
          title: appbarTitle(text: 'Order History'),
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: CustomIconButton(
              onPressed: () {
                Get.put(MainPageController()).selectedTab.value = 4;
                Get.offNamed(Routes.MAIN_PAGE);
                Get.delete<MyOrdersController>();
              },
            ),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
            child: Obx(() {
              if (controller.isInitialize.value == 1) {
                return Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                      color: ColorName.primaryColor, size: 40.sp),
                );
              } else if (controller.isInitialize.value == 0 &&
                  controller.orderList.isNotEmpty) {
                return NotificationListener(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent &&
                        controller.isEndPage.value == false &&
                        controller.isLoading.value == false) {
                      controller.fetchOrders();
                    }
                    return false;
                  },
                  child: RefreshIndicator(
                    color: ColorName.primaryColor,
                    onRefresh: () async {
                      controller.isInitialize.value = 100;
                      await controller.fetchOrders();
                    },
                    child: Obx(() {
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: controller.orderList.length +
                              (controller.isLoading.value == true ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == controller.orderList.length &&
                                controller.isLoading.value) {
                              return shimmerLoadingWidget(
                                  height: 130.h,
                                  width: Get.width,
                                  borderRadius: 20.r);
                            } else {
                              final order = controller.orderList[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 15.h),
                                child: InkWell(
                                  onTap: () {
                                    if (order.orderStatus ==
                                        OrderStatus.pickedUp) {
                                      Get.toNamed(Routes.TRACK_ORDER,
                                          arguments: {'order': order});
                                    } else if (order.orderStatus ==
                                        OrderStatus.delivered) {
                                      Get.toNamed(Routes.REVIEW_AND_TRIP,
                                          arguments: order);
                                    } else {
                                      Get.toNamed(Routes.ORDER_DETAILS,
                                          arguments: order);
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(20.r),
                                  child: Container(
                                    width: Get.width,
                                    padding: EdgeInsets.all(10.r),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 2.r,
                                              offset: Offset(1, 1))
                                        ]),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                AppTextStyle(
                                                  text: "Order ID:",
                                                  fontSize: 12.sp,
                                                  color: Colors.grey,
                                                ),
                                                5.width,
                                                AppTextStyle(
                                                  text:
                                                      "#${order.id.toString()}",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 4.h),
                                              decoration: BoxDecoration(
                                                color: MethodHelper
                                                    .getOrderStatusColor(
                                                        order.orderStatus!,
                                                        isForText: false),
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                              ),
                                              child: AppTextStyle(
                                                text: order.orderStatus!,
                                                color: MethodHelper
                                                    .getOrderStatusColor(
                                                        order.orderStatus!),
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                        10.height,
                                        ...List.generate(
                                            order.orderItems!.length, (item) {
                                          final foodItem =
                                              order.orderItems![item];
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 8.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                cachedImageWidget(
                                                  imgUrl: foodItem.image!,
                                                  height: 35.h,
                                                  width: 35.w,
                                                  borderRadius: 10.r,
                                                ),
                                                10.width,
                                                Expanded(
                                                    child: AppTextStyleOverFlow(
                                                  text: foodItem.name!,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                                10.width,
                                                AppTextStyle(
                                                  text: "x${foodItem.quantity}",
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                        5.height,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  Get.toNamed(
                                                      Routes.ORDER_DETAILS,
                                                      arguments: order);
                                                },
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4.w,
                                                      vertical: 2.h),
                                                  // Set padding to zero or customize it
                                                  minimumSize: Size(5.h, 5.w),
                                                  // Optional: Adjust size constraints
                                                  tapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap, // Optional: Reduces tap area
                                                ),
                                                child: Row(
                                                  children: [
                                                    AppTextStyle(
                                                      text: 'View Details',
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor: ColorName
                                                          .primaryColor,
                                                      color: ColorName
                                                          .primaryColor,
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    5.width,
                                                    Icon(
                                                      Icons.arrow_forward,
                                                      color: ColorName
                                                          .primaryColor,
                                                      size: 18.sp,
                                                    )
                                                  ],
                                                )),
                                            Row(
                                              children: [
                                                AppTextStyle(
                                                  text: HelperUtils
                                                      .currencySymbol,
                                                  color: ColorName.primaryColor,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                AppTextStyle(
                                                  text: '${order.total?.toStringAsFixed(2)}',
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.w500,
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          });
                    }),
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.images.emptyResult.path,
                      height: 300.h,
                      width: Get.width,
                    ),
                    20.height,
                    AppTextStyle(
                      text: 'No order found!',
                    ),
                    30.height,
                    globalButton(
                        onTap: () {
                          controller.isInitialize.value = 100;
                          controller.currentPage.value = 0;
                          controller.fetchOrders();
                        },
                        text: "Refresh")
                  ],
                );
              }
            })));
  }
}
