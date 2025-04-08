import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../Utils/app_text_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../controllers/introduction_screen_controller.dart';

class IntroductionScreenView extends GetView<IntroductionScreenController> {
  const IntroductionScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: ColorName.white,
          body: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    children: [
                      _IntroPage(
                        imagePath: Assets.images.onboardingPage1.path,
                      ),
                      _IntroPage(
                        imagePath: Assets.images.onboardingPage2.path,
                      ),
                      _IntroPage(
                        imagePath: Assets.images.onboardingPage3.path,
                      ),
                    ],
                  ),
                ),
                // Bottom Navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Skip Button
                    TextButton(
                      onPressed: controller.onSkipPressed,
                      child: AppTextStyle(
                        text: 'Skip',
                        color: ColorName.primaryColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Dot Indicator
                    SmoothPageIndicator(
                      controller: controller.pageController,
                      count: controller.pageCount,
                      effect: WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 8,
                        activeDotColor: ColorName.primaryColor,
                        dotColor: ColorName.gray410,
                      ),
                    ),
                    // Next/Done Button
                    Obx(() => controller.isLastPage.value
                        ? TextButton(
                            onPressed: controller.onNextPressed,
                            child: AppTextStyle(
                              text: 'Done',
                              color: ColorName.primaryColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : IconButton(
                            onPressed: controller.onNextPressed,
                            icon: Icon(
                              Icons.arrow_forward,
                              color: ColorName.primaryColor,
                              size: 24.sp,
                            ),
                          )),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

// Custom widget for each intro page
class _IntroPage extends StatelessWidget {
  final String imagePath;

  const _IntroPage({
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        imagePath,
        height: Get.height,
        width: Get.width,
        fit: BoxFit.contain,
      ),
    );
  }
}
