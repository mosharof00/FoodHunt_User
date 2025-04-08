import 'package:get/get.dart';
import 'package:food_hunt_user/Helper/logger.dart';
import 'package:food_hunt_user/app/modules/home/controllers/home_controller.dart';
import 'package:food_hunt_user/app/modules/main_page/controllers/main_page_controller.dart';

import '../app/services/local_store_config.dart';

class OrderStatus {
  static const String pending = 'Pending';
  static const String cooking = 'Cooking';
  static const String waitingPickUp = 'Waiting PickUp';
  static const String pickedUp = 'Picked Up';
  static const String delivered = 'Delivered';
  static const String canceled = 'Canceled';
}

class HelperUtils {
  static String currencySymbol = '\$';
  static String defaultProfileImage =
      // "https://i.pinimg.com/474x/18/b5/b5/18b5b599bb873285bd4def283c0d3c09.jpg";
      "https://axbajldpgtugenukkold.supabase.co/storage/v1/object/public/images/data/default_profile_image.png";
  static bool isOnboard = false;
  static bool isLoggedIn = false;
  static bool isAdmin = false;
  static double latitude = 0.0;
  static double longitude = 0.0;
  static String address = "";

  ///  app primary color
  static RxString isPrimaryColor = ''.obs;

  ///  user info
  static String userId = "";
  static String userRole = "";
  static String token = "";
  static String firebaseToken = "";


  ///   auth type
  static String manualAuthType = 'manual';
  static String googleAuthType = 'google';
  static String facebookAuthType = 'facebook';
  //
  static Future<void> setUser({
    required String id,
    required String role,
  }) async {
    ///  store data into Hive
    HiveService.deleteUserID();
    HiveService.setUserID(id);
    HiveService.deleteUserRole();
    HiveService.setUserRole(role);
    // HiveService.deleteToken();
    // HiveService.setToken(token);
    // FirebaseDBService.addedUser(users[0], 'student');
    ///   Get data into static variables
    HelperUtils.userId = id;
    HelperUtils.userRole = role;
    HelperUtils.isLoggedIn = true;
    Log.i("UserId: ${HelperUtils.userId}  \nRole: ${HelperUtils.userRole}");
  }

  static Future<void> initializeMainControllers() async {
    /// ✅ Check if the controller is already registered before initializing

      if (!Get.isRegistered<HomeController>()) {
        // Ensure HomeController is permanent and not reinitialized
        Get.put(HomeController(), permanent: true);
      }
      if (!Get.isRegistered<MainPageController>()) {
        // Ensure MainPageController is permanent and not reinitialized
        Get.put(MainPageController(), permanent: true);

    }
    await Future.delayed(Duration(milliseconds: 500));
  }


  static Future<void> deleteMainControllers() async {
    Get.put(MainPageController(), permanent: false);
    Get.put(HomeController(), permanent: false);
    Get.delete<HomeController>(force: true);
    Get.delete<MainPageController>(force: true);
  }
}
