import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../services/local_store_config.dart';

class IntroductionScreenController extends GetxController {
  //TODO: Implement IntroductionScreenController
  final pageController = PageController();
  final currentPage = 0.obs;
  final isLastPage = false.obs;
  final pageCount = 3;

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int page) {
    currentPage.value = page;
    isLastPage.value = page == pageCount - 1;
  }

  void onSkipPressed() {
    // Handle skip action (e.g., navigate to login)
    HiveService.setOnBoardShowed(true);
    Get.offNamed(Routes.LOGIN);
  }

  void onNextPressed() {
    if (isLastPage.value) {
      // On last page, handle completion
      HiveService.setOnBoardShowed(true);
      Get.offNamed(Routes.LOGIN);
    } else {
      // Go to next page
      pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }
}
