import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:food_hunt_user/Utils/app_input_text_form_field.dart';
import 'package:food_hunt_user/Utils/appbar_title.dart';
import 'package:food_hunt_user/Utils/cached_image_helper.dart';
import 'package:food_hunt_user/Utils/custom_svg_image.dart';
import 'package:food_hunt_user/Utils/input_field_with_label.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';
import 'package:food_hunt_user/app/modules/explore/widgets/tab_view_widget.dart';
import 'package:food_hunt_user/gen/colors.gen.dart';

import '../../../../Helper/helper_utils.dart';
import '../../../../Utils/app_text_style.dart';
import '../../../../Utils/app_text_style_over_flow.dart';
import '../../../../Utils/custom_icon_button.dart';
import '../../../../gen/assets.gen.dart';
import '../../../models/static_food_model.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/widgets/trades.dart';
import '../controllers/explore_controller.dart';

class ExploreView extends GetView<ExploreController> {
  const ExploreView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorName.bgColor,
        appBar: AppBar(
          backgroundColor: ColorName.bgColor,
          surfaceTintColor: ColorName.bgColor,
          title: appbarTitle(text: 'Explore'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  Assets.icons.notificationIcon,
                )),
            10.width,
          ],
        ),
        body: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  children: [
                    Expanded(
                      child: AppInputTextFormField(
                        disabledBorderColor: Colors.grey.shade200,
                        borderColor: Colors.grey.shade200,
                        hintText: 'Find a Local Meal',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.r),
                          child: customSvgImage(
                            imagePath: Assets.icons.selarchIcon,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    10.width,
                    Container(
                      height: 45.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                          color: ColorName.primaryColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Center(
                        child: customSvgImage(
                            imagePath: Assets.icons.filterIcon,
                            color: ColorName.white,
                            height: 20.h,
                            width: 20.w),
                      ),
                    )
                  ],
                )),
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
                            text: 'Restaurants',
                          ),
                          Tab(
                            text: 'Trades',
                          ),
                          Tab(
                            text: 'Following',
                          ),
                        ],
                      ),
                      10.height,
                      Expanded(
                          child: TabBarView(children: [
                        TabViewWidget(),
                        TabViewWidget(),
                        TabViewWidget(),
                      ])),
                    ],
                  )),
            ),
          ],
        ));
  }
}
