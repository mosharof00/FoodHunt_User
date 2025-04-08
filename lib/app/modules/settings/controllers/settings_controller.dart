import 'package:get/get.dart';
import 'package:food_hunt_user/Helper/helper_utils.dart';
import 'package:food_hunt_user/Helper/logger.dart';
import 'package:food_hunt_user/app/routes/app_pages.dart';
import 'package:food_hunt_user/app/services/local_store_config.dart';

import '../../../repository/supabase_repository.dart';

class SettingsController extends GetxController {
  //TODO: Implement SettingsController
  final SupabaseRepository _supaRepo = SupabaseRepository();

  Future<void> logOut() async {
    try {
      await _supaRepo.signOut();
      await HelperUtils.deleteMainControllers();
      HiveService.deleteUserID();
      HiveService.deleteToken();
      HiveService.deleteUserRole();
      HelperUtils.isLoggedIn = false;
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Log.i(e);
    }
  }
}
