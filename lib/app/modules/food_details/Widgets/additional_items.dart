import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/app/modules/food_details/controllers/food_details_controller.dart';

import '../../../../Helper/helper_utils.dart';
import '../../../../Utils/app_text_style.dart';
import '../../../../Utils/cached_image_helper.dart';
import '../../../../gen/colors.gen.dart';

class AdditionalItems extends StatelessWidget {
  const AdditionalItems({super.key, required this.controller});
  final FoodDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.food.value.addOns!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final additionalItem = controller.food.value.addOns![index];
          return InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () {
              if (controller.selectedAdditionalItems.contains(additionalItem)) {
                controller.selectedAdditionalItems.remove(additionalItem);
              } else {
                controller.selectedAdditionalItems.add(additionalItem);
              }
              controller.getTotal();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  cachedImageWidget(
                      imgUrl: additionalItem.image ?? "",
                      height: 40.h,
                      width: 40.w,
                      borderRadius: 10.r),
                  10.width,
                  Expanded(
                    child: AppTextStyle(
                      text: additionalItem.name!,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  AppTextStyle(
                    text:
                        "+${HelperUtils.currencySymbol} ${additionalItem.price}",
                    color: Colors.grey,
                  ),
                  5.width,
                  Obx(() {
                    return Container(
                      height: 23.h,
                      width: 23.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1.5.r,
                            color: controller.selectedAdditionalItems
                                    .contains(additionalItem)
                                ? ColorName.primaryColor
                                : Colors.grey.shade400),
                      ),
                      child: controller.selectedAdditionalItems
                              .contains(additionalItem)
                          ? Center(
                              child: Container(
                                height: 13.h,
                                width: 13.w,
                                decoration: BoxDecoration(
                                  color: ColorName.primaryColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: ColorName.primaryColor
                                            .withAlpha(150),
                                        blurRadius: 2.r,
                                        offset: Offset(1, 3))
                                  ],
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                    );
                  })
                ],
              ),
            ),
          );
        });
  }
}
