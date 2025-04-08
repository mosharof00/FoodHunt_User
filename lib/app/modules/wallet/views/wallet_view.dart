import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:food_hunt_user/Helper/helper_utils.dart';
import 'package:food_hunt_user/Utils/app_text_style.dart';
import 'package:food_hunt_user/Utils/cached_image_helper.dart';
import 'package:food_hunt_user/Utils/global_button.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/app/modules/payment_method/controllers/payment_method_controller.dart';

import '../../../../Utils/appbar_title.dart';
import '../../../../Utils/custom_icon_button.dart';
import '../../../../gen/colors.gen.dart';
import '../controllers/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});
  @override
  Widget build(BuildContext context) {
    final paymentMethodController = Get.put(PaymentMethodController());
    return Scaffold(
        backgroundColor: ColorName.bgColor,
        appBar: AppBar(
          backgroundColor: ColorName.bgColor,
          surfaceTintColor: ColorName.bgColor,
          title: appbarTitle(text: 'Wallet'),
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: CustomIconButton(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            children: [
              5.height,
              Container(
                height: 120.h,
                width: Get.width,
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: ColorName.primaryColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextStyle(
                          text: 'Balance',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        AppTextStyle(
                          text: '${HelperUtils.currencySymbol}30.50',
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Container(
                      height: Get.height,
                      width: 4.w,
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(50.r)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextStyle(
                          text: 'tswaps',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        AppTextStyle(
                          text: '${HelperUtils.currencySymbol}45.50',
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              15.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextStyle(
                    text: 'payment methods',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  globalButton(
                      onTap: () {},
                      text: 'Add',
                      height: 30.h,
                      width: 70.w,
                      color: Colors.white,
                      textColor: ColorName.primaryColor,
                      borderRadius: BorderRadius.circular(50.r),
                      borderColor: ColorName.primaryColor)
                ],
              ),
              10.height,
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount:
                        paymentMethodController.paymentMethodList.length - 1,
                    itemBuilder: (context, index) {
                      final method =
                          paymentMethodController.paymentMethodList[index + 1];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 10.h),
                        child: Container(
                          height: 120.h,
                          width: Get.width,
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2.r,
                                    offset: Offset(2, 2))
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppTextStyle(
                                    text: method.name!,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  cachedImageWidget(
                                      imgUrl: method.logoUrl??'',
                                      height: 40.h,
                                      width: 100.w,
                                      fit: BoxFit.contain)
                                ],
                              ),
                              AppTextStyle(
                                text: 'Expiring on: 12/24',
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
