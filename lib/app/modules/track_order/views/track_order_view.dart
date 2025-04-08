import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:food_hunt_user/Utils/app_text_style_over_flow.dart';
import 'package:food_hunt_user/Utils/cached_image_helper.dart';
import 'package:food_hunt_user/Utils/custom_svg_image.dart';
import 'package:food_hunt_user/Utils/global_divider.dart';
import 'package:food_hunt_user/Utils/show_empty_result.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';

import '../../../../Utils/app_text_style.dart';
import '../../../../Utils/appbar_title.dart';
import '../../../../Utils/custom_icon_button.dart';
import '../../../../Utils/methods/distance_helper.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../routes/app_pages.dart';
import '../controllers/track_order_controller.dart';

class TrackOrderView extends GetView<TrackOrderController> {
  const TrackOrderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Track Order'),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: CustomIconButton(
            onPressed: () {
              Get.back();
              Get.delete<TrackOrderController>();
            },
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(10.r),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Obx(() {
              if (controller.isDriverInitializing.value == 1) {
                return Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                      color: ColorName.primaryColor, size: 40.sp),
                );
              } else if (controller.driverLocation.value == null ||
                  controller.isDriverInitializing.value == 2) {
                return ShowEmptyResult(
                  title: 'Driver not found!',
                  desc: 'Something went wring. Can not track the order.',
                );
              } else {
                return Stack(children: [
                  GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(23.7895417, 90.4240717),
                      zoom: 15,
                    ),
                    markers: controller.markers,
                    polylines: controller.polylines,
                    onMapCreated: (GoogleMapController mapController) {
                      controller.mapController = mapController;
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    mapType: MapType.normal,
                    compassEnabled: true,
                    zoomControlsEnabled: true,
                  ),
                  Positioned(
                      top: 50.h,
                      left: 15.w,
                      right: 15.w,
                      child: Container(
                        height: 65.h,
                        width: Get.width,
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            cachedImageWidget(
                                imgUrl:
                                    controller.order.restaurantProfileImage ??
                                        '',
                                height: Get.height,
                                width: 50.w,
                                borderRadius: 6.r),
                            10.width,
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                            AppTextStyle(
                              text: "${controller.order.itemQty} Items",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            )
                          ],
                        ),
                      ))
                ]);
              }
            }),
          )),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (controller.driverLocation.value != null) {
      //       controller.mapController?.animateCamera(
      //         CameraUpdate.newLatLng(controller.driverLocation.value!),
      //       );
      //     }
      //   },
      //   child: const Icon(Icons.center_focus_strong),
      // ),
    );
  }
}

Future<void> getInfoDialog() async {
  final controller = Get.find<TrackOrderController>();
  return showDialog<void>(
    context: Get.context!,
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          color: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          child: Container(
            margin: EdgeInsets.all(15.r),
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                  )
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    cachedImageWidget(
                        imgUrl: controller.driver.value.driverImageUrl ?? '',
                        height: 70.h,
                        width: 70.w,
                        borderRadius: 10.r),
                    10.width,
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextStyle(
                          text: "Driver",
                          color: ColorName.primaryColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        AppTextStyle(
                          text: controller.driver.value.fullName ?? 'Unknown',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    )),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.toNamed(Routes.CHATS, arguments: {
                              'receiver_name': controller.driver.value.fullName,
                              'receiver_id': controller.driver.value.id,
                            });
                          },
                          icon: customSvgImage(
                              imagePath: Assets.icons.chatsIcon,
                              color: ColorName.primaryColor,
                              height: 25.h,
                              width: 25.w),
                        ),
                        5.width,
                        IconButton(
                          onPressed: () {},
                          icon: customSvgImage(
                              imagePath: Assets.icons.callIcon,
                              color: ColorName.primaryColor,
                              height: 25.h,
                              width: 25.w),
                        ),
                      ],
                    )
                  ],
                ),
                10.height,
                globalDivider(),
                10.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextStyle(
                      text: 'ETA',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    AppTextStyle(
                      text: DistanceHelper.deliveryBy(
                          totalMinutes:
                              controller.driver.value.currentOrderDeliveryEta!),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorName.primaryColor,
                    )
                  ],
                ),
                10.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextStyle(
                      text: 'Vehicle',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    AppTextStyle(
                      text: controller.driver.value.vehicleType!.capitalize!,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorName.primaryColor,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
