import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';

import '../../../../Helper/helper_utils.dart';
import '../../../../Utils/app_text_style.dart';
import '../../../../Utils/app_text_style_over_flow.dart';
import '../../../../Utils/cached_image_helper.dart';
import '../../../../Utils/global_divider.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../cart/controllers/cart_controller.dart';

class OrderItemLayout extends StatelessWidget {
  const OrderItemLayout(
      {super.key, required this.orderItem, this.showEditIcon, this.showItems});
  final CartModel orderItem;
  final bool? showEditIcon;
  final bool? showItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        children: [
          Row(
            children: [
              cachedImageWidget(
                imgUrl: orderItem.imageUrl ?? "",
                height: 85.h,
                width: 85.w,
                borderRadius: 15.r,
              ),
              15.width,
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AppTextStyleOverFlow(
                          text: orderItem.name,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 35.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: ColorName.primaryColor),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: AppTextStyle(
                            text: "${orderItem.qty.toString()} x",
                            color: ColorName.primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  showItems == false ||   orderItem.additionalItems == null ||
                          orderItem.additionalItems!.isEmpty
                      ? SizedBox.shrink()
                      : AppTextStyle(
                          text: orderItem.additionalItems!
                              .map((item) => item.name)
                              .join(', '),
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextStyle(
                        text:
                            "${HelperUtils.currencySymbol}${orderItem.totalPrice.toStringAsFixed(2)}",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorName.primaryColor,
                      ),
                      showEditIcon == true
                          ? SvgPicture.asset(
                              Assets.icons.editOutlineIcon,
                              height: 20.h,
                              width: 20.h,
                            )
                          : AppTextStyle(
                              text:
                                  "${HelperUtils.currencySymbol}${orderItem.basePrice.toStringAsFixed(2)}",
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                    ],
                  ),
                ],
              ))
            ],
          ),
          12.height,
          globalDivider()
        ],
      ),
    );
  }
}
