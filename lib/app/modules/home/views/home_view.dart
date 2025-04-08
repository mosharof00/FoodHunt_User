import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:food_hunt_user/Utils/app_text_style.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/app/modules/home/widgets/location_dialog.dart';
import 'package:food_hunt_user/app/modules/home/widgets/restaurant_layout.dart';
import 'package:food_hunt_user/app/modules/home/widgets/trades.dart';
import 'package:food_hunt_user/gen/colors.gen.dart';

import '../../../../Helper/logger.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/home_controller.dart';
import '../widgets/following.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<HomeController>()) {
      // Ensure HomeController is permanent and not reinitialized
      Get.put(HomeController(), permanent: true);
    }
    return Scaffold(
        backgroundColor: ColorName.white,
        appBar: AppBar(
          backgroundColor: ColorName.bgColor,
          surfaceTintColor: ColorName.bgColor,
          toolbarHeight: 60.h,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      locationDialog(
                          context: context,
                          okText: 'Search',
                          addressEditingController:
                              controller.addressEditingController,
                          isLoading: controller.isGettingLocation,
                          isAddressValid: controller.isAddressValid,
                          onTap: () async {
                            LatLng? latLng;
                            latLng = await controller.getLatLng(
                                controller.addressEditingController.text);
                            if (latLng != null) {
                              Log.i(
                                  "latitude: ${latLng.latitude} longitude: ${latLng.longitude}");
                              controller.location.value = latLng;
                              controller.newAddress.value =
                                  controller.addressEditingController.text;
                              controller
                                  .fetchRestaurants(controller.location.value!);

                              Get.back();
                            }
                          });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(Assets.icons.locationIcon),
                            10.width,
                            AppTextStyle(
                              text: 'Deliver to',
                              color: ColorName.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          ],
                        ),
                        5.height,
                        Obx(
                          () => AppTextStyle(
                            text: controller.newAddress.value,
                            color: Colors.black54,
                            fontSize: 12,
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    ),
                  )),
                  SvgPicture.asset(Assets.icons.notificationIcon)
                ],
              ),
            ],
          ),
          centerTitle: false,
        ),
        body: Column(
          children: [
            5.height,
            Divider(
              color: Colors.grey,
            ),
            10.height,
            Expanded(
                child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: false,
                          dividerColor: Colors.transparent,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          indicatorSize: TabBarIndicatorSize.label,
                          tabAlignment: TabAlignment.center,
                          indicatorColor: Colors.black,
                          indicatorWeight: 1,
                          tabs: [
                            Tab(
                                child: Text('Restaurants',
                                    style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500))),
                            Tab(
                                child: Text('Trades',
                                    style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500))),
                            Tab(
                                child: Text('Following',
                                    style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500))),
                          ],
                        ),
                        Expanded(
                            child: TabBarView(children: [
                          RestaurantLayout(controller: controller),
                          Trades(),
                          Following(),
                        ]))
                      ],
                    )))
          ],
        ));
  }
}
